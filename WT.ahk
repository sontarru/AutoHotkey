;
; Запускает Windows Terminal и делает Snap.
;
StartWT(snap) {
    wt := Format("{1}\Microsoft\WindowsApps\wt.exe", EnvGet("LocalAppData"))
    wt := Format("`"{1}`" --window new", wt)
    StartExe(wt, "", "ahk_exe WindowsTerminal.exe")
    Send("#{" . snap . "}")
}

;
; Запускает Windows Terminal и делает Snap влево
;
^!t::
{
    StartWT("Left")
}


;
; Запускает Windows Terminal и делает Snap вправо.
;
^+t::
{
    StartWT("Right")
}
