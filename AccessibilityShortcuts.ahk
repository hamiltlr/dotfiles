#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#singleinstance force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Shortcuts to center the mouse on the monitors
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Set the CoordMode to the entire desktop to allow for moving the mouse between monitors
CoordMode, Mouse, Screen

SysGet, NumScreens, MonitorCount
SysGet, PrimaryScreen, MonitorPrimary
SecondaryScreen := PrimaryScreen + 1

;; Center the mouse on the primary monitor when Win+F is pressed
#f::CenterOnMonitor(PrimaryScreen)

;; Move Mouse to left monitor when Win+Shift+F is pressed ;;
#+f::CenterOnMonitor(SecondaryScreen)

;; Move the mouse through all the monitors
#^f::CenterOnMonitorRelative(1)

;; Center the mouse on the given monitor
CenterOnMonitor(N) {
    SysGet, Mon, Monitor, %N%
    x := (MonRight+MonLeft) // 2
    y := (MonBottom+MonTop) // 2
    MouseMove, x, y
}

;; Center the mouse on the monitor n-monitors away from the current
CenterOnMonitorRelative(n) {
    global NumScreens
    x := GetActiveMonitor()+n

    if (x <= 0) {
        x = NumScreens 
    } else if (x > NumScreens){
        x = 1
    }

    if (x > 0 and x <= NumScreens) {
        CenterOnMonitor(x)
    }
}

;; Get the monitor number that the mouse is currently on
GetActiveMonitor() {
    global NumScreens
    MouseGetPos, MouseX, MouseY

    loop, %NumScreens% {
        SysGet, Mon, Monitor, %A_Index%

        ;MsgBox, 
        ;(LTrim
        ;I %A_Index%
        ;MouseX %MouseX% 
        ;MouseY %MouseY% 
        ;MonRight %MonRight% 
        ;MonLeft %MonLeft% 
        ;MonTop %MonTop% 
        ;MonBottom %MonBottom%
        ;)
        
        if (MouseX <= MonRight and MouseX >= MonLeft and MouseY >= MonTop and MouseY <= MonBottom) {
            return %A_Index%
        }
    }
    return 0
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Magnifier Shortcuts
;
; These magnifier shortcuts use the "zoom" button on my Logitech mouse.
; Since this isn't a standard button, I had to map it to a key in the Logitech software and then use that key here.
; I mapped it to F13. Since there isn't an F13 key on the keboard (usually), you can create an AHK script with
;     F1::F13
; to let you "press" the F13 key to set it as a mapping in the Logitech software.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Zoom in
F13::
Send, #=
return

; Zoom out
F13 & XButton1::
Send, #-
return

; Quit magnifier
F13 & XButton2::
Send, #{Esc}
return

