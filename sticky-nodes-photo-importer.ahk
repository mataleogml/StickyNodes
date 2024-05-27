#Requires AutoHotkey v2.0

#Persistent
#NoEnv

; Change these paths to your needs
ImportFolder := "C:\CameraImports"
LightroomPath := "C:\Program Files\Adobe\Adobe Lightroom\lightroom.exe"

; Function to handle the device change
OnDeviceChange(wParam, lParam) {
    if (wParam = 0x8000) { ; DBT_DEVICEARRIVAL
        DriveLetter := GetDriveLetterFromGUID()
        if (DriveLetter) {
            ImportImages(DriveLetter)
        }
    }
    return true
}

; Function to get drive letter from GUID
GetDriveLetterFromGUID() {
    Loop, File, %A_Temp%\*.*, D
    {
        if (InStr(A_LoopFileName, "{") && InStr(A_LoopFileName, "}")) {
            return A_LoopFileDrive
        }
    }
    return ""
}

; Function to import images
ImportImages(DriveLetter) {
    ; Create a new folder named with current date and time
    FormatTime, FolderName,, yyyyMMdd_HHmmss
    TargetFolder := ImportFolder "\" FolderName
    FileCreateDir, %TargetFolder%

    ; Copy images from the camera to the target folder
    Loop, Files, %DriveLetter%:\*.jpg, R
    {
        FileCopy, %A_LoopFileFullPath%, %TargetFolder%
    }

    ; Sort images by date
    Loop, Files, %TargetFolder%\*.jpg
    {
        FileGetTime, FileTime, %A_LoopFileFullPath%, C
        FileMove, %A_LoopFileFullPath%, %TargetFolder%\%FileTime%_%A_LoopFileName%
    }

    ; Open Lightroom and import the images
    Run, %LightroomPath% "%TargetFolder%"
}

; Register for device change notifications
OnMessage(0x219, "OnDeviceChange")

MsgBox, Script is running. Plug in your camera to import images.
return

