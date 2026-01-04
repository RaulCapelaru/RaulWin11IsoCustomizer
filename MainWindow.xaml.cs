using System;
using System.Diagnostics;
using System.IO;
using System.Net.Http;
using System.Threading.Tasks;
using System.Windows;
using FolderBrowserDialog = System.Windows.Forms.FolderBrowserDialog;
using MessageBox = System.Windows.MessageBox;
using OpenFileDialog = Microsoft.Win32.OpenFileDialog;

namespace RaulWin11IsoCustomizer
{
    public partial class MainWindow : Window
    {
        private string isoPath = "";
        private string workingDirectory = "";
        private string extractedIsoPath = "";
        private bool isIsoExtracted = false;
        private bool isAutounattendAdded = false;
        private const string AUTOUNATTEND_URL = "https://raw.githubusercontent.com/RaulCapelaru/Autounattend-for-RAULWIN11-ISO-CUSTOMIZER/main/autounattend.xml";

        public MainWindow()
        {
            InitializeComponent();
        }

        private void BtnSelectIso_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog
            {
                Filter = "ISO Files (*.iso)|*.iso",
                Title = "Select Windows 11 ISO File"
            };

            if (openFileDialog.ShowDialog() == true)
            {
                isoPath = openFileDialog.FileName;
                txtIsoPath.Text = isoPath;
                UpdateStatus($"ISO selected: {Path.GetFileName(isoPath)}");
                UpdateButtonStates();
            }
        }

        private void BtnSelectWorkDir_Click(object sender, RoutedEventArgs e)
        {
            using (var folderDialog = new FolderBrowserDialog())
            {
                folderDialog.Description = "Select Working Directory (needs ~10GB free space)";
                
                if (folderDialog.ShowDialog() == System.Windows.Forms.DialogResult.OK)
                {
                    workingDirectory = folderDialog.SelectedPath;
                    txtWorkDir.Text = workingDirectory;
                    extractedIsoPath = Path.Combine(workingDirectory, "WIN11_EXTRACTED");
                    UpdateStatus($"Working directory set: {workingDirectory}");
                    UpdateButtonStates();
                }
            }
        }

        private async void BtnExtractIso_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(isoPath) || string.IsNullOrEmpty(workingDirectory))
            {
                MessageBox.Show("Please select both ISO file and working directory first.", 
                    "Missing Information", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            try
            {
                SetButtonsEnabled(false);
                UpdateStatus("Extracting ISO contents... This may take several minutes.");
                progressBar.Value = 0;

                // Create extraction directory
                if (Directory.Exists(extractedIsoPath))
                {
                    var result = MessageBox.Show(
                        "Extraction directory already exists. Do you want to delete it and start fresh?",
                        "Directory Exists", 
                        MessageBoxButton.YesNo, 
                        MessageBoxImage.Question);
                    
                    if (result == MessageBoxResult.Yes)
                    {
                        Directory.Delete(extractedIsoPath, true);
                    }
                    else
                    {
                        SetButtonsEnabled(true);
                        return;
                    }
                }

                Directory.CreateDirectory(extractedIsoPath);

                await Task.Run(() => ExtractIso());

                isIsoExtracted = true;
                isAutounattendAdded = false;
                txtAutounattendStatus.Text = "No autounattend.xml added yet";
                txtAutounattendStatus.Foreground = new System.Windows.Media.SolidColorBrush(
                    System.Windows.Media.Color.FromRgb(255, 165, 0));

                progressBar.Value = 100;
                UpdateStatus("✓ ISO extracted successfully! You can now add autounattend.xml");
                MessageBox.Show("ISO extracted successfully!", "Success", 
                    MessageBoxButton.OK, MessageBoxImage.Information);

                UpdateButtonStates();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error extracting ISO: {ex.Message}", "Error", 
                    MessageBoxButton.OK, MessageBoxImage.Error);
                UpdateStatus("Error during extraction.");
                SetButtonsEnabled(true);
            }
        }

        private void ExtractIso()
        {
            // Mount the ISO
            UpdateProgress(10, "Mounting ISO...");
            string mountScript = $@"
                $iso = Mount-DiskImage -ImagePath '{isoPath}' -PassThru
                $driveLetter = ($iso | Get-Volume).DriveLetter
                $driveLetter
            ";

            string driveLetter = ExecutePowerShell(mountScript).Trim();
            
            if (string.IsNullOrEmpty(driveLetter))
            {
                throw new Exception("Failed to mount ISO");
            }

            string sourcePath = $"{driveLetter}:\\";

            try
            {
                UpdateProgress(30, "Copying files from mounted ISO...");
                
                // Copy all files and directories
                CopyDirectory(sourcePath, extractedIsoPath);

                UpdateProgress(90, "Dismounting ISO...");
            }
            finally
            {
                // Dismount the ISO
                string dismountScript = $"Dismount-DiskImage -ImagePath '{isoPath}'";
                ExecutePowerShell(dismountScript);
            }

            UpdateProgress(100, "Extraction complete!");
        }

        private void CopyDirectory(string sourceDir, string destDir)
        {
            Directory.CreateDirectory(destDir);

            foreach (string file in Directory.GetFiles(sourceDir))
            {
                string destFile = Path.Combine(destDir, Path.GetFileName(file));
                File.Copy(file, destFile, true);
                
                // Remove read-only attribute
                FileAttributes attributes = File.GetAttributes(destFile);
                if ((attributes & FileAttributes.ReadOnly) == FileAttributes.ReadOnly)
                {
                    File.SetAttributes(destFile, attributes & ~FileAttributes.ReadOnly);
                }
            }

            foreach (string dir in Directory.GetDirectories(sourceDir))
            {
                string destSubDir = Path.Combine(destDir, Path.GetFileName(dir));
                CopyDirectory(dir, destSubDir);
            }
        }

        private async void BtnDownloadAutounattend_Click(object sender, RoutedEventArgs e)
        {
            if (!isIsoExtracted)
            {
                MessageBox.Show("Please extract the ISO first!", "Not Ready", 
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            try
            {
                SetButtonsEnabled(false);
                UpdateStatus("Downloading RaulWin11 autounattend.xml...");
                progressBar.Value = 0;

                string autounattendPath = Path.Combine(extractedIsoPath, "autounattend.xml");

                using (HttpClient client = new HttpClient())
                {
                    progressBar.Value = 30;
                    var response = await client.GetAsync(AUTOUNATTEND_URL);
                    response.EnsureSuccessStatusCode();
                    
                    progressBar.Value = 60;
                    string content = await response.Content.ReadAsStringAsync();
                    
                    progressBar.Value = 80;
                    await File.WriteAllTextAsync(autounattendPath, content);
                    
                    progressBar.Value = 100;
                }

                isAutounattendAdded = true;
                txtAutounattendStatus.Text = "✓ RaulWin11 autounattend.xml added successfully";
                txtAutounattendStatus.Foreground = new System.Windows.Media.SolidColorBrush(
                    System.Windows.Media.Color.FromRgb(16, 124, 16));

                UpdateStatus("✓ RaulWin11 autounattend.xml downloaded and added successfully!");
                MessageBox.Show("Autounattend.xml has been added to the ISO root!", "Success", 
                    MessageBoxButton.OK, MessageBoxImage.Information);

                UpdateButtonStates();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error downloading autounattend.xml: {ex.Message}", "Error", 
                    MessageBoxButton.OK, MessageBoxImage.Error);
                UpdateStatus("Error downloading autounattend.xml");
                SetButtonsEnabled(true);
            }
        }

        private void BtnSelectCustomAutounattend_Click(object sender, RoutedEventArgs e)
        {
            if (!isIsoExtracted)
            {
                MessageBox.Show("Please extract the ISO first!", "Not Ready", 
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            Microsoft.Win32.OpenFileDialog openFileDialog = new Microsoft.Win32.OpenFileDialog
            {
                Filter = "XML Files (*.xml)|*.xml",
                Title = "Select Your Custom Autounattend.xml"
            };

            if (openFileDialog.ShowDialog() == true)
            {
                try
                {
                    string sourceFile = openFileDialog.FileName;
                    string destFile = Path.Combine(extractedIsoPath, "autounattend.xml");

                    File.Copy(sourceFile, destFile, true);

                    isAutounattendAdded = true;
                    txtAutounattendStatus.Text = $"✓ Custom autounattend.xml added: {Path.GetFileName(sourceFile)}";
                    txtAutounattendStatus.Foreground = new System.Windows.Media.SolidColorBrush(
                        System.Windows.Media.Color.FromRgb(16, 124, 16));

                    UpdateStatus($"✓ Custom autounattend.xml added successfully!");
                    MessageBox.Show("Your custom autounattend.xml has been added!", "Success", 
                        MessageBoxButton.OK, MessageBoxImage.Information);

                    UpdateButtonStates();
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Error copying autounattend.xml: {ex.Message}", "Error", 
                        MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }

        private async void BtnCreateIso_Click(object sender, RoutedEventArgs e)
        {
            if (!isIsoExtracted || !isAutounattendAdded)
            {
                MessageBox.Show("Please complete all previous steps first!", "Not Ready", 
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            Microsoft.Win32.SaveFileDialog saveFileDialog = new Microsoft.Win32.SaveFileDialog
            {
                Filter = "ISO Files (*.iso)|*.iso",
                Title = "Save Custom Windows 11 ISO",
                FileName = "RaulWin11_Custom.iso"
            };

            if (saveFileDialog.ShowDialog() == true)
            {
                string outputIso = saveFileDialog.FileName;
                txtOutputIso.Text = outputIso;

                try
                {
                    SetButtonsEnabled(false);
                    UpdateStatus("Creating bootable ISO... This may take several minutes.");
                    progressBar.Value = 0;

                    await Task.Run(() => CreateBootableIso(outputIso));

                    progressBar.Value = 100;
                    UpdateStatus($"✓ Custom ISO created successfully: {Path.GetFileName(outputIso)}");
                    
                    var result = MessageBox.Show(
                        $"Custom Windows 11 ISO created successfully!\n\n{outputIso}\n\nDo you want to open the folder?", 
                        "Success", 
                        MessageBoxButton.YesNo, 
                        MessageBoxImage.Information);

                    if (result == MessageBoxResult.Yes)
                    {
                        Process.Start("explorer.exe", $"/select,\"{outputIso}\"");
                    }

                    SetButtonsEnabled(true);
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Error creating ISO: {ex.Message}", "Error", 
                        MessageBoxButton.OK, MessageBoxImage.Error);
                    UpdateStatus("Error creating ISO.");
                    SetButtonsEnabled(true);
                }
            }
        }

        private void CreateBootableIso(string outputPath)
        {
            UpdateProgress(10, "Preparing to create ISO...");

            // Check if oscdimg.exe exists (Windows ADK tool)
            string oscdimgPath = FindOscdimg();

            if (string.IsNullOrEmpty(oscdimgPath))
            {
                throw new Exception("oscdimg.exe not found! Please install Windows ADK.\n\n" +
                    "Download from: https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install");
            }

            UpdateProgress(30, "Creating bootable ISO with oscdimg...");

            // Find boot files
            string etfsboot = Path.Combine(extractedIsoPath, "boot", "etfsboot.com");
            string efisys = Path.Combine(extractedIsoPath, "efi", "microsoft", "boot", "efisys.bin");

            if (!File.Exists(etfsboot) || !File.Exists(efisys))
            {
                throw new Exception("Boot files not found in extracted ISO!");
            }

            // Create the ISO using oscdimg
            string arguments = $"-m -o -u2 -udfver102 -bootdata:2#p0,e,b\"{etfsboot}\"#pEF,e,b\"{efisys}\" \"{extractedIsoPath}\" \"{outputPath}\"";

            ProcessStartInfo psi = new ProcessStartInfo
            {
                FileName = oscdimgPath,
                Arguments = arguments,
                UseShellExecute = false,
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                CreateNoWindow = true
            };

            UpdateProgress(50, "Building ISO image...");

            using (Process process = Process.Start(psi))
            {
                process.WaitForExit();

                if (process.ExitCode != 0)
                {
                    string error = process.StandardError.ReadToEnd();
                    throw new Exception($"oscdimg failed with exit code {process.ExitCode}\n{error}");
                }
            }

            UpdateProgress(90, "Finalizing ISO...");
        }

        private string FindOscdimg()
        {
            // Common locations for oscdimg.exe
            string[] possiblePaths = new string[]
            {
                @"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\oscdimg.exe",
                @"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\x86\Oscdimg\oscdimg.exe",
                @"C:\Program Files\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\oscdimg.exe",
            };

            foreach (string path in possiblePaths)
            {
                if (File.Exists(path))
                {
                    return path;
                }
            }

            // Try to find in PATH
            string pathEnv = Environment.GetEnvironmentVariable("PATH");
            if (pathEnv != null)
            {
                string[] paths = pathEnv.Split(';');
                foreach (string path in paths)
                {
                    string fullPath = Path.Combine(path, "oscdimg.exe");
                    if (File.Exists(fullPath))
                    {
                        return fullPath;
                    }
                }
            }

            return null;
        }

        private string ExecutePowerShell(string script)
        {
            ProcessStartInfo psi = new ProcessStartInfo
            {
                FileName = "powershell.exe",
                Arguments = $"-NoProfile -ExecutionPolicy Bypass -Command \"{script}\"",
                UseShellExecute = false,
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                CreateNoWindow = true
            };

            using (Process process = Process.Start(psi))
            {
                string output = process.StandardOutput.ReadToEnd();
                string error = process.StandardError.ReadToEnd();
                process.WaitForExit();

                if (process.ExitCode != 0 && !string.IsNullOrEmpty(error))
                {
                    throw new Exception($"PowerShell error: {error}");
                }

                return output;
            }
        }

        private void UpdateButtonStates()
        {
            bool hasIso = !string.IsNullOrEmpty(isoPath);
            bool hasWorkDir = !string.IsNullOrEmpty(workingDirectory);

            btnExtractIso.IsEnabled = hasIso && hasWorkDir && !isIsoExtracted;
            btnDownloadAutounattend.IsEnabled = isIsoExtracted && !isAutounattendAdded;
            btnSelectCustomAutounattend.IsEnabled = isIsoExtracted && !isAutounattendAdded;
            btnCreateIso.IsEnabled = isIsoExtracted && isAutounattendAdded;
        }

        private void SetButtonsEnabled(bool enabled)
        {
            btnSelectIso.IsEnabled = enabled;
            btnSelectWorkDir.IsEnabled = enabled;
            btnExtractIso.IsEnabled = enabled && !string.IsNullOrEmpty(isoPath) && !string.IsNullOrEmpty(workingDirectory);
            btnDownloadAutounattend.IsEnabled = enabled && isIsoExtracted;
            btnSelectCustomAutounattend.IsEnabled = enabled && isIsoExtracted;
            btnCreateIso.IsEnabled = enabled && isIsoExtracted && isAutounattendAdded;
        }

        private void UpdateStatus(string message)
        {
            Dispatcher.Invoke(() =>
            {
                txtStatus.Text = message;
            });
        }

        private void UpdateProgress(int value, string message)
        {
            Dispatcher.Invoke(() =>
            {
                progressBar.Value = value;
                txtProgressPercent.Text = $"{value}%";
                txtStatus.Text = message;
            });
        }
    }
}
