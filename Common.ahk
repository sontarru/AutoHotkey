;
; Запускает приложение по его path и ждет когда появится новое окно
; этого приложения
;
StartExe(cmdline, options := "", winfilter := "") {
    if(winfilter == "") {
        SplitPath(cmdline, &name)
        winfilter := Format("ahk_exe {1}", name)
    }

    ; тут мы сразу получим 0, если активно окно не этого приложения
    ; либо HWND окна если активно окно уже запущенного этого приложения
    hwnd := WinWaitActive(winfilter, , 0)

    Run(cmdline, , options)

    ; а теперь в цикле ждём когда появится окно приложения отличное от того
    ; что было активно до этого - если прежнее окно это было окно другого
    ; приложения, то hwnd == 0 и мы сразу выйдем из цикла
    hwnd2 := WinWaitActive(winfilter)
    while(hwnd2 == hwnd) {
        hwnd2 := WinWaitActive(winfilter)
    }
}
