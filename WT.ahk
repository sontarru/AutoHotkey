;
; Runs Windows Terminal and wait for its window.
;
RunWT() {
    static wtexe := Format("{1}\Microsoft\WindowsApps\wt.exe", EnvGet("LocalAppData"))
    static wtcmd := Format("`"{1}`" --window new", wtexe)
    static filter := "ahk_exe WindowsTerminal.exe"

    ; Zero or current active terminal window
    hwnd := WinWaitActive(filter, , 0)
    Run(wtcmd)
    ; Ensures the active terminal window is a new one
    hwnd2 := WinWaitActive(filter)
    while(hwnd2 == hwnd) {
        hwnd2 := WinWaitActive(filter)
    }
}

;
; Runs `msedge` end snap it to the left side.
;
^!t::
{
    RunWT()
    Send("#{Left}")
}


;
; Runs `msedge` end snap it to the right side.
;
^!+t::
{
    RunWT()
    Send("#{Right}")
}
