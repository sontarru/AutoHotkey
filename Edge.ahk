;
; Запускает два экземпляра msedge и размещает его окна по горизонтали.
;
^!e::
{
    msedge := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
    StartExe(msedge)
    Send("#{Left}")
    StartExe(msedge)
    Send("#{Right}")
}
