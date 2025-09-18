;
; Runs `msedge` and wait for its window.
;
RunMsedge() {
    static msedge := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
    static filter := "ahk_exe msedge.exe"

    ; Zero or current active msedge window
    hwnd := WinWaitActive(filter, , 0)
    Run(msedge)
    ; Ensures the active msedge window is a new one
    hwnd2 := WinWaitActive(filter)
    while(hwnd2 == hwnd) {
        hwnd2 := WinWaitActive(filter)
    }
}

;
; Runs `msedge` end snap it to the left side.
;
^!e::
{
    RunMsedge()
    Send("#{Left}")
}


;
; Runs `msedge` end snap it to the right side.
;
^!+e::
{
    RunMsedge()
    Send("#{Right}")
}
