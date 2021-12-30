#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

EnvGet, ComputerName, COMPUTERNAME

GetScoopManagedAppPath(app_path)
{
    EnvGet, home_path, userprofile

    scoop_app_path := "" . home_path . "\scoop\apps\" . app_path

    return scoop_app_path
}

; C:\Users\ningzou\AppData\Local\Microsoft\Teams\Update.exe --processStart "Teams.exe"
GetLocalApp(app_path, parameters:="") {
    EnvGet, home_path, userprofile

    app_path := "" . home_path . "\AppData\Local\" . app_path . " " . parameters

    return app_path
}

BringUpFrontApp(app, app_path)
{
    if WinExist(app)
        WinActivate
    else
        Run, %app_path%
}

; find all apps that can be opened directly via win+r: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths
LAlt & c::BringUpFrontApp("ahk_exe chrome.exe", "C:\Program Files\Google\Chrome\Application\chrome.exe")
LAlt & f::BringUpFrontApp("ahk_exe msedge.exe", "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")
; LAlt & Esc::BringUpFrontApp("ahk_exe explorer.exe ahk_class CabinetWClass", "explorer")
LAlt & Esc::BringUpFrontApp("ahk_exe explorer.exe ahk_class CabinetWClass", "C:\Windows\explorer.exe")
LAlt & 1::BringUpFrontApp("ahk_exe Code.exe", GetScoopManagedAppPath("vscode\current\Code.exe"))
LAlt & 3::BringUpFrontApp("ahk_exe Notion.exe", GetScoopManagedAppPath("notion\current\Notion.exe"))
LAlt & 4::BringUpFrontApp("ahk_exe Teams.exe", GetLocalApp("Microsoft\Teams\Update.exe", "--processStart ""Teams.exe"""))
LAlt & 6::BringUpFrontApp("ahk_exe OUTLOOK.EXE", "OUTLOOK.exe")
; ; LAlt & v::BringUpFrontApp("ahk_exe ONENOTE.exe", "OneNote.lnk")
; LAlt & v::BringUpFrontApp("ahk_exe onenoteim.exe", "OneNote1.lnk")

LAlt & e::
    if laptop in ComputerName
        BringUpFrontApp("ahk_exe WindowsTerminal.exe", "wt")
    else
        BringUpFrontApp("ahk_exe cmd.exe", "C:\Windows\System32\cmd.exe /k D:\work\OneDrive.Client\init.cmd")
return

; Combinations of three or more keys are not supported.
;; arrows
RAlt & a:: Send {left}
RAlt & d:: Send {right}
RAlt & w:: Send {up}
RAlt & s:: Send {down}
;; window movements
LAlt & o:: Send #{up}
LAlt & j:: Send #+{left}
LAlt & l:: Send #+{right}
;; misc
LAlt & [:: Send {Home}
LAlt & ]:: Send {End}
LShift & Esc:: Send {~}
LCtrl & Esc:: Send ^+{Tab}
;; remapping
CapsLock::Ctrl
;; reload script
^!r::Reload  ; Ctrl+Alt+R
;; debug
^!d::
    ; -------------------------------------------------
    ; WinGetClass, class, A
    ; MsgBox, The active window's class is "%class%".

    ; -------------------------------------------------
    ; WinGet, process_name, ProcessName, A
    ; WinGet, process_path, ProcessPath, A

    ; MsgBox, The active windows's info is [process_name: "%process_name%", process_path: "%process_path%"]

    ; GetScoopManagedAppPath("test/test.Exe")
return

LWin & Esc::    ; Next window
    WinGetClass, current_class, A
    WinGet, current_process, ProcessName , A

    ; WinGetClass, current_class, class, A
    WinGet, windows, List, ahk_exe %current_process% ahk_class %current_class%
    WinGet, current_id, ID, A

    if (windows = 1)
    {
        ; only one window found
        return
    }

    Loop %windows%
    {
        id := windows%A_Index%

        if (id = current_id)
        {
            ; activate next one
            ; remember that the built-in index is not 0 based
            next_index := Mod(A_Index - 1 + 1, windows) + 1
            next_id := windows%next_index%

            WinActivate, ahk_id %next_id%
            return
        }
    }
return

; ===================== 3 finger drag
; https://medium.com/@dakshin.k1/enable-3-finger-gesture-for-click-and-drag-on-windows-and-linux-cd7165b66851
; drag_enabled := 0
;
; +^#F22::
;     if(drag_enabled)
;     {
;         Click up
;         drag_enabled := 0
;     }
;     else
;     {
;         drag_enabled := 1
;         Click down
;     }
;     return
;
; LButton::
;     if(drag_enabled)
;     {
;         Click up
;         drag_enabled := 0
;     }
;     else
;         click
;     return
; ===================== end

; LWin & Esc::    ; Next window
;     WinGet, ExeName, ProcessName , A
;     WinGet, ExeCount, Count, ahk_exe %ExeName%
;     If ExeCount = 1
;         Return
;     Else
;         WinSet, Bottom,, A
;         WinActivate, ahk_exe %ExeName%
; return
; LWin::LCtrl
; LCtrl::LWin

; disable win + l
; #L::LCtrl
; return

; https://www.maketecheasier.com/disable-lock-screen-shortcut-key-windows/
; RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 1
; RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 0

; list of keys
; https://www.autohotkey.com/docs/KeyList.htm

; ^ - ctrl
; + - shift
; ! - Alt
; # - Win
