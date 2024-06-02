# define the list of applications and their download URLs
$applications = @{
    "Google Chrome" = "https://dl.google.com/chrome/install/ChromeSetup.exe"; # URL for Google Chrome installer
    "Adobe Reader" = "http://ardownload.adobe.com/pub/adobe/reader/win/AcrobatDC/2000920068/AcroRdrDC1900820071_en_US.exe"; # URL for Adobe Reader installer
    "Microsoft Office" = "https://go.microsoft.com/fwlink/p/?linkid=2009112"; # URL for Microsoft Office installer
    "7-Zip" = "https://www.7-zip.org/a/7z1900-x64.exe"; # URL for 7-Zip installer
    "VLC Media Player" = "https://get.videolan.org/vlc/3.0.11.1/win64/vlc-3.0.11.1-win64.exe"; # URL for VLC Media Player installer
    "Notepad++" = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.1.9.2/npp.8.1.9.2.Installer.x64.exe" # URL for Notepad++ installer
}

# create a directory to store installers if it doesn't exist
$installerPath = "C:\Temp\Installers"
if (!(Test-Path -Path $installerPath)) {
    # create the directory
    New-Item -ItemType Directory -Force -Path $installerPath
}

# function to download and install an application
function Install-Application {
    param (
        [string]$appName, # name of the application
        [string]$url, # download URL for the application installer
        [string]$installerFileName # name for the installer file
    )

    # path where the installer will be downloaded
    $installerFilePath = "$installerPath\$installerFileName"

    # download the installer
    Write-Output "Downloading $appName..."
    Invoke-WebRequest -Uri $url -OutFile $installerFilePath

    # run the installer
    Write-Output "Installing $appName..."
    Start-Process -FilePath $installerFilePath -ArgumentList "/silent" -Wait
}

# loop through each application and install it
foreach ($app in $applications.GetEnumerator()) {
    # call the function to install each application
    Install-Application -appName $app.Key -url $app.Value -installerFileName "$($app.Key.Replace(' ', ''))Setup.exe"
}

# indicate that all applications have been installed
Write-Output "All applications have been installed successfully."
