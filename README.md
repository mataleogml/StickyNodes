# Photo Importer Workflow for Sticky Nodes

This AutoHotkey (AHK) script automates the process of importing images from a USB-connected camera, and importing them into Adobe Lightroom.

This script was developed for Martin Botero's senior capstone project, Sticky Nodes, as part of his physical prototype.

## Features

- **Automatic Detection**: Detects when a camera is plugged in via USB.
- **Image Import**: Copies images from the camera to a new folder on your computer.
- **Lightroom Integration**: Opens Adobe Lightroom and imports the images through Auto Imports.

## Requirements

- [AutoHotkey 1.1](https://www.autohotkey.com/) installed on your Windows PC.
- Adobe Lightroom installed.

## Setup

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/mataleogml/sticky-nodes-photo-importer.git
   cd sticky-nodes-photo-importer
   ```

2. **Setup Auto Import in Adobe Lightroom Classic**:
   - Open `sticky-nodes-photo-importer.ahk` in a text editor.
   - Update the following paths as needed:
     ```ahk
     ImportFolder := "C:\CameraImports"
     LightroomPath := "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Adobe Lightroom Classic.lnk"
     ```
     
3. **Edit the Script**:
   - Navigate to ```File > Auto Import > Auto Import Settings```.
   - Set the Watchfolder to ```C:\CameraImports```.
   - Click ```OK``` to confirm.
   - Navigate to ```File > Auto Import > Auto Import Settings``` and check ```Enable Auto Import```

4. **Run the Script**:
   - Double-click `sticky-nodes-photo-importer.ahk` to start the script.
   - A message box will appear indicating that the script is running.

## Usage

1. **Connect Your Camera**:
   - Plug in your camera via USB.
   - The script will automatically detect the camera, copy the images to a new folder, sort them, and open Lightroom for import.

2. **Import Images in Lightroom**:
   - Once Lightroom opens, you images will be imported.

## Customization

- **File Types**:
  - The script is currently set to handle `.jpg` files. To handle other file types, modify the `Loop, Files` patterns in the script:
    ```ahk
    Loop, Files, %DriveLetter%:\*.jpg, R
    {
        FileCopy, %A_LoopFileFullPath%, %TargetFolder%
    }
    ```

## Known Issue
- This script does not handle duplicates, it will import every picture to Lightroom.
