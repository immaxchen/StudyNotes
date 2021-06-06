#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

global Taskbar
WinGetPos, , , , Taskbar, ahk_class Shell_TrayWnd

global W_A = 1024
global H_A = 768
global X_A = A_ScreenWidth/2-W_A/2
global Y_A = (A_ScreenHeight-Taskbar)/2-H_A/2

AlterWindowPosition(dir) {
    WinGetPos, X, Y, , , A
    if dir = lower left
        WinMove, A, , X-50, Y+50
    else if dir = lower center
        WinMove, A, , X, Y+50
    else if dir = lower right
        WinMove, A, , X+50, Y+50
    else if dir = center left
        WinMove, A, , X-50, Y
    else if dir = center
        WinMove, A, , X, Y
    else if dir = center right
        WinMove, A, , X+50, Y
    else if dir = upper left
        WinMove, A, , X-50, Y-50
    else if dir = upper center
        WinMove, A, , X, Y-50
    else if dir = upper right
        WinMove, A, , X+50, Y-50
}

GetWindowSize() {
    WinGetPos, , , W, H, A
    MsgBox, , Window Size, %W% %H%
}

SetWindowSize() {
    WinGetPos, X, Y, , , A
    InputBox, W, Set Window Width, , , 200, 105
    if ! ErrorLevel, return
    InputBox, H, Set Window Height, , , 200, 105
    if ! ErrorLevel, return
    WinMove, A, , X, Y, W, H
}

SetWindowLocation(loc) {
    WinGetPos, , , W, H, A
    if loc = lower left
        WinMove, A, , 0, A_ScreenHeight-Taskbar-H
    else if loc = lower center
        WinMove, A, , A_ScreenWidth/2-W/2, A_ScreenHeight-Taskbar-H
    else if loc = lower right
        WinMove, A, , A_ScreenWidth-W, A_ScreenHeight-Taskbar-H
    else if loc = center left
        WinMove, A, , 0, (A_ScreenHeight-Taskbar)/2-H/2
    else if loc = center
        WinMove, A, , A_ScreenWidth/2-W/2, (A_ScreenHeight-Taskbar)/2-H/2
    else if loc = center right
        WinMove, A, , A_ScreenWidth-W, (A_ScreenHeight-Taskbar)/2-H/2
    else if loc = upper left
        WinMove, A, , 0, 0
    else if loc = upper center
        WinMove, A, , A_ScreenWidth/2-W/2, 0
    else if loc = upper right
        WinMove, A, , A_ScreenWidth-W, 0
}

MemorizeWindowPosition() {
    WinGetPos, X_A, Y_A, W_A, H_A, A
    MsgBox, , , Copied!, 0.5
}

ReproduceWindowSize() {
    WinGetPos, X, Y, , , A
    WinMove, A, , X, Y, W_A, H_A
}

SnapWindowPosition(pos) {
    if pos = lower left
        WinMove, A, , X_A-W_A, Y_A+H_A, W_A, H_A
    else if pos = lower center
        WinMove, A, , X_A, Y_A+H_A, W_A, H_A
    else if pos = lower right
        WinMove, A, , X_A+W_A, Y_A+H_A, W_A, H_A
    else if pos = center left
        WinMove, A, , X_A-W_A, Y_A, W_A, H_A
    else if pos = center
        WinMove, A, , X_A, Y_A, W_A, H_A
    else if pos = center right
        WinMove, A, , X_A+W_A, Y_A, W_A, H_A
    else if pos = upper left
        WinMove, A, , X_A-W_A, Y_A-H_A, W_A, H_A
    else if pos = upper center
        WinMove, A, , X_A, Y_A-H_A, W_A, H_A
    else if pos = upper right
        WinMove, A, , X_A+W_A, Y_A-H_A, W_A, H_A
}

!Numpad1::AlterWindowPosition("lower left")
!Numpad2::AlterWindowPosition("lower center")
!Numpad3::AlterWindowPosition("lower right")
!Numpad4::AlterWindowPosition("center left")
!Numpad5::AlterWindowPosition("center")
!Numpad6::AlterWindowPosition("center right")
!Numpad7::AlterWindowPosition("upper left")
!Numpad8::AlterWindowPosition("upper center")
!Numpad9::AlterWindowPosition("upper right")
^NumpadDot::GetWindowSize()
^Numpad0::SetWindowSize()
^Numpad1::SetWindowLocation("lower left")
^Numpad2::SetWindowLocation("lower center")
^Numpad3::SetWindowLocation("lower right")
^Numpad4::SetWindowLocation("center left")
^Numpad5::SetWindowLocation("center")
^Numpad6::SetWindowLocation("center right")
^Numpad7::SetWindowLocation("upper left")
^Numpad8::SetWindowLocation("upper center")
^Numpad9::SetWindowLocation("upper right")
#NumpadDot::MemorizeWindowPosition()
#Numpad0::ReproduceWindowSize()
#Numpad1::SnapWindowPosition("lower left")
#Numpad2::SnapWindowPosition("lower center")
#Numpad3::SnapWindowPosition("lower right")
#Numpad4::SnapWindowPosition("center left")
#Numpad5::SnapWindowPosition("center")
#Numpad6::SnapWindowPosition("center right")
#Numpad7::SnapWindowPosition("upper left")
#Numpad8::SnapWindowPosition("upper center")
#Numpad9::SnapWindowPosition("upper right")
