;
; Запускает Windows Terminal, максимизирует его и открывает в нем две
; горизонтальные панели.
;
^!t::
{
    wt := Format("{1}\Microsoft\WindowsApps\wt.exe", EnvGet("LocalAppData"))
    wt := Format("`"{1}`" --window new", wt)
    StartExe(wt, "Max", "ahk_exe WindowsTerminal.exe")
    Send("!+{=}")
    Send("^!{Right}")
}
