#SingleInstance Force
#include .\Lib\UIA_Interface.ahk
SetTitleMatchMode 2

~!f::
    ; Get active Explorer path
    currentPath := GetExplorerPath()

    Loop, Files, % currentPath "\*", D  ; Loop through all directories
    {
        folderPath := A_LoopFileFullPath
        OpenFolderProperties(folderPath)

        Sleep, 400

        ; Wait for Properties dialog
        if !WinWait, "ahk_class #32770",, 3 {
            Continue
        }
        WinActivate "ahk_class #32770"

        ; Initialize UIA for Properties window
        UIA := UIA_Interface()
        propWin := UIA.ElementFromHandle("A")

        ; Navigate to Customize tab
        try {
            contextTab := propWin.FindFirstBy("AutomationId=12320")
            contextTab.FindByPath("5").Click()
        } catch {
            MsgBox, Failed to find Customize tab.
            Continue
        }
        Sleep, 500

        ; Click Change Icon button
        try {
            propWin.FindFirstBy("AutomationId=14182").Click()
        } catch {
            MsgBox, Failed to find Change Icon button.
            Continue
        }
        Sleep, 600

        UIA := UIA_Interface()
        iconWin := UIA.ElementFromHandle("A")

        ; Select first icon in list
        try {
            shellpane := iconWin.WaitElementExist("AutomationId=listview",,,, 2000)
            if !shellpane {
                throw Exception("Listview not found")  
            }
            
            firstItem := shellpane.WaitElementExist("ControlType=ListItem",,,, 2000)
            if !firstItem {
                throw Exception("List item not found")  
            }
            
            firstItem.Click()
            Sleep, 500
        } catch {
            WinClose, ahk_class #32770
            WinClose, ahk_class #32770
            Continue
        }

        Sleep, 500

        UIA := UIA_Interface()
        propWin := UIA.ElementFromHandle("A")

        ; Confirm icon selection
        propWin.FindFirstBy("AutomationId=12321").Click()  ; Apply button
        Sleep, 300
        propWin.FindFirstBy("Name='OK' AND ControlType=Button").Click()
    }
return

GetExplorerPath() {
    activeHwnd := WinExist("A")
    shell := ComObjCreate("Shell.Application")
    for window in shell.Windows {
        if InStr(window.FullName, "explorer.exe") && (window.HWND == activeHwnd) {
            if (path := window.Document.Folder.Self.Path)
                return path
        }
    }
    return ""
}

OpenFolderProperties(folderPath) {
    shell := ComObjCreate("Shell.Application")
    folder := shell.NameSpace(folderPath).Self
    folder.InvokeVerb("Properties")
}

+Esc::ExitApp
