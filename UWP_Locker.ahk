#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

toggle := false

|::
toggle := !toggle

if (toggle) {
    ; Bloquear cursor en ventana activa con bordes ajustados para UWP
    WinGet, hwnd, ID, A
    WinGetPos, winX, winY, winW, winH, ahk_id %hwnd%

    ; Ajustes de bordes para UWP
    border := 8
    topBar := 33

    left := winX + border
    top := winY + topBar
    right := (winX + winW) - border
    bottom := (winY + winH) - border

    VarSetCapacity(rect, 16, 0)
    NumPut(left, rect, 0, "Int")
    NumPut(top, rect, 4, "Int")
    NumPut(right, rect, 8, "Int")
    NumPut(bottom, rect, 12, "Int")
    DllCall("ClipCursor", "Ptr", &rect)
} else {
    ; Liberar cursor
    DllCall("ClipCursor", "Ptr", 0)
}

SetTimer, RemoveToolTip, -1000
return

RemoveToolTip:
ToolTip
return
