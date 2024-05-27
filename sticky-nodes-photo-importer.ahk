#Persistent
#NoEnv
SetBatchLines, -1
SetTitleMatchMode, 2
SendMode, Input

ImportFolder := "C:\CameraImports"

OnDeviceChange(wParam, lParam) {
    if (wParam = 0x8000) {
        DriveLetter := GetDriveLetterFromGUID()
        if (DriveLetter) {
            Run, "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Adobe Lightroom Classic.lnk"
            ImportImages(DriveLetter)
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
        TargetFolder := "C:\CameraImports\"
        FileCreateDir, %TargetFolder%
        Loop, Files, %DriveLetter%\*.jpg, R
        {
            FileCopy, %A_LoopFileFullPath%, %TargetFolder%
        }
    }

    OnMessage(0x219, "OnDeviceChange")

    MsgBox, Script is running. Plug in your camera to import images.
    return
