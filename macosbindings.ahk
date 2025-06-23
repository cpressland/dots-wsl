#Requires AutoHotkey v2.0

#InputLevel 1
^a:: Send("{Home}")                      ; CTRL + A = Home
^e:: Send("{end}")                       ; CTRL + E = End

WheelUp:: Send("{WheelDown}")            ; Reverse mouse wheel direction
WheelDown:: Send("{WheelUp}")            ; Reverse mouse wheel direction

#InputLevel 0
#a:: Send("^a")                          ; Win + A = Ctrl + A
#s:: Send("^s")                          ; Win + S = Ctrl + S
#f:: Send("^f")                          ; Win + F = Ctrl + F
#c:: Send("^c")                          ; Win + C = Ctrl + C
#x:: Send("^x")                          ; Win + X = Ctrl + X
#v:: Send("^v")                          ; Win + V = Ctrl + V
#w:: Send("^w")                          ; Win + W = Ctrl + W
#t:: Send("^t")                          ; Win + T = Ctrl + T
#y:: Send("^y")                          ; Win + Y = Ctrl + Y
#z:: Send("^z")                          ; Win + Z = Ctrl + Z
#q:: Send("!{F4}")                       ; Win + Q = Alt + F4
!3:: SendText("#")                       ; Alt + 3 = Win + #
~LWin:: Send "{Blind}{vkE8}"             ; Block Left Win key alone

#Tab::                                   ; Win + Tab = Alt + Tab
{
    Send("{Alt down}{Tab}")
    KeyWait("LWin")                      ; Wait until the Windows key is released
    Send("{Alt up}")
    return
}

#HotIf WinActive("ahk_class Chrome_WidgetWin_1") && WinGetTitle("") ~= "Visual Studio Code"
#+p:: Send("^+p")
#.:: Send("^.")
#/:: Send("^/")
#[:: Send("^[")
#]:: Send("^]")
#HotIf

#HotIf WinActive("ahk_exe wezterm-gui.exe")
#t:: Send("^+t")  ; Win + T = Ctrl + Shift + T in WezTerm
#c:: Send("^+c")  ; Win + C = Ctrl + Shift + C in WezTerm
#HotIf
