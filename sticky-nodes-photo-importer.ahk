#Persistent
#NoEnv
SetBatchLines, -1
SetTitleMatchMode, 2
SendMode, Input

ImportFolder := "C:\CameraImports"

OnDeviceChange(wParam, lParam) {
    static DBT_DEVICEARRIVAL := 0x8000
    if (wParam = DBT_DEVICEARRIVAL) {
        DriveLetter := GetDriveLetterFromGUID()
        if (DriveLetter) {
            MsgBox, Camera connected. Drive letter: %DriveLetter%
            ImportImages(DriveLetter)
        } else {
            MsgBox, No removable drive detected.
        }
    }
    return true
}

GetDriveLetterFromGUID() {
    DriveList := ""
    DriveGet, List, List
    Loop, Parse, List
    {
        DriveGet, Type, Type, %A_LoopField%:
        if (Type = "Removable") {
            DriveList := A_LoopField ":"
        }
    }
    return DriveList
}

ImportImages(DriveLetter) {
    FormatTime, FolderName,, yyyyMMdd_HHmmss
    TargetFolder := "C:\CameraImports\" . FolderName
    FileCreateDir, %TargetFolder%
    
    MsgBox, Importing images from camera... Please wait.

    ImageCount := 0

    Loop, Files, %DriveLetter%\*.jpg, R
    {
        FileCopy, %A_LoopFileFullPath%, %TargetFolder%
        ImageCount++
    }

    Loop, Files, %TargetFolder%\*.jpg
    {
        FileGetTime, FileTime, %A_LoopFileFullPath%, C
        FileMove, %A_LoopFileFullPath%, %TargetFolder%\%FileTime%_%A_LoopFileName%
    }

    MsgBox, %ImageCount% images imported from the camera.

    Run, "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Adobe Lightroom.lnk"
}

OnMessage(0x219, "OnDeviceChange")

MsgBox, Script is running. Plug in your camera to import images.
return
