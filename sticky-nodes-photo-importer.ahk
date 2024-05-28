#Persistent
#NoEnv
SetBatchLines, -1
SetTitleMatchMode, 2
SendMode, Input

ImportFolder := "C:\CameraImports"
DriveLetter := ""

OnDeviceChange(wParam, lParam) {
    if (wParam = 0x8000) {
        DriveLetter := GetDriveLetterFromGUID()
        if (DriveLetter) {
            Run, "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Adobe Lightroom Classic.lnk"
            MsgBox, Press PageDown to import images from %DriveLetter%
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
    TargetFolder := ImportFolder . "\" . FolderName
    FileCreateDir, %TargetFolder%
    Loop, Files, %DriveLetter%\*.jpg, R
    {
        FileCopy, %A_LoopFileFullPath%, %TargetFolder%
    }
    MsgBox, Images have been imported to %TargetFolder%
}

OnMessage(0x219, "OnDeviceChange")

; Define a hotkey for PageDown to trigger the image import
.::
if (DriveLetter) {
    ImportImages(DriveLetter)
    DriveLetter := "" ; Reset drive letter after import
} else {
    MsgBox, No removable drive detected. Please plug in a device first.
}
return

MsgBox, Script is running. Plug in your camera and press PageDown to import images.
return
