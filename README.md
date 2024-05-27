# Sticky Nodes Photo Importer Workflow

This AutoHotkey (AHK) script automates the process of importing images from a USB-connected camera, sorting them by date, and importing them into Adobe Lightroom. 

## Features

- **Automatic Detection**: Detects when a camera is plugged in via USB.
- **Image Import**: Copies images from the camera to a new folder on your computer.
- **Sorting**: Sorts the images by their creation date and renames them accordingly.
- **Lightroom Integration**: Opens Adobe Lightroom and imports the sorted images.

## Requirements

- [AutoHotkey 1.1](https://www.autohotkey.com/) installed on your Windows PC.
- Adobe Lightroom installed.

## Setup

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/mataleogml/sticky-nodes-photo-importer.git
   cd sticky-nodes-photo-importer
   ```

2. **Edit the Script**:
   - Open `sticky-nodes-photo-importer.ahk` in a text editor.
   - Update the following paths as needed:
     ```ahk
     ImportFolder := "C:\CameraImports"
     LightroomPath := "C:\Program Files\Adobe\Adobe Lightroom CC\lightroom.exe"
     ```

3. **Run the Script**:
   - Double-click `sticky-nodes-photo-importer.ahk` to start the script.
   - A message box will appear indicating that the script is running.

## Usage

1. **Connect Your Camera**:
   - Plug in your camera via USB.
   - The script will automatically detect the camera, copy the images to a new folder, sort them, and open Lightroom for import.

2. **Import Images in Lightroom**:
   - Once Lightroom opens, you can proceed with the import process as usual.

## Customization

- **File Types**:
  - The script is currently set to handle `.jpg` files. To handle other file types, modify the `Loop, Files` patterns in the script:
    ```ahk
    Loop, Files, %DriveLetter%:\*.jpg, R
    {
        FileCopy, %A_LoopFileFullPath%, %TargetFolder%
    }
    ```

- **Folder Naming**:
  - The folder is named with the current date and time by default. This can be customized by modifying the `FormatTime` line in the script.

## Contributing

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [AutoHotkey](https://www.autohotkey.com/)
- [Adobe Lightroom](https://www.adobe.com/products/photoshop-lightroom.html)

## Support

If you encounter any issues or have any questions, please open an issue in this repository.