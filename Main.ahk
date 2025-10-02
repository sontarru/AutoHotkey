;
; Runs Application by it cmdline, waits for its new window by AHK filter,
; and sends to it a key.
;

RunApp(cmd, filter, key) {
    ; Zero or current active msedge window
    hwnd := WinWaitActive(filter, , 0)
    Run(cmd)
    ; Ensures the active msedge window is a new one
    hwnd2 := WinWaitActive(filter)
    while(hwnd2 == hwnd) {
        hwnd2 := WinWaitActive(filter)
    }
    Send(key)
}

;
; Runs `msedge`, waits for its new window and sends a key.
;

RunMsedge(key) {
    static msedge := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
    static filter := "ahk_exe msedge.exe"
    RunApp(msedge, filter, key)
}

;
; Ctl+Alt+e: Runs `msedge` end snap it to the left side.
;

^!e::
{
    RunMsedge("#{Left}")
}

;
; Runs `msedge` end snap it to the right side.
;

^+e::
{
    RunMsedge("#{Right}")
}

;
; Runs `wt`, waits for its new window and sends a key.
;

RunWT(key) {
    static wtexe := Format("{1}\Microsoft\WindowsApps\wt.exe", EnvGet("LocalAppData"))
    static wtcmd := Format("`"{1}`" --window new", wtexe)
    static filter := "ahk_exe WindowsTerminal.exe"
    RunApp(wtcmd, filter, key)
}

;
; Ctl+Alt+t: Runs `wt` end snap it to the left side.
;

^!t::
{
    RunWT("#{Left}")
}

;
; Ctl+Shift+t: Runs `wt` end snap it to the right side.
;

^+t::
{
    RunWT("#{Right}")
}

;
; ----------------
; Jellyfin stuff.
; ----------------
;

;
; Pins the window to all desktops.
;

PinWindow(hwnd) {
    ; Get `IServiceProvider`
    static CLSID_ImmersiveShell := "{C2F03A33-21F5-47FA-B4BB-156362A2F239}"
    static IID_IServiceProvider := "{6D5140C1-7436-11CE-8034-00AA006009FA}"
    static serviceProvider := ComObject(CLSID_ImmersiveShell, IID_IServiceProvider)

    ; Call `QueryService` for `IVirtualDesktopPinnedApps` on `serviceProvider`
    static CLSID_VirtualDesktopPinnedApps := "{B5A399E7-1C87-46B8-88E9-FC5747B171BD}"
    static IID_IVirtualDesktopPinnedApps := "{4CE81583-1E4C-4632-A621-07A53543148F}"
    static pinnedApps := ComObjQuery(serviceProvider, CLSID_VirtualDesktopPinnedApps, IID_IVirtualDesktopPinnedApps)

    ; Call `QueryService` for `IApplicationViewCollection` on `serviceProvider`
    static IID_IApplicationViewCollection := "{1841C6D7-4F9D-42C0-AF41-8747538F10E5}"
    static appViews := ComObjQuery(serviceProvider, IID_IApplicationViewCollection, IID_IApplicationViewCollection)

    view := 0
    ; Call `IApplicationViewCollection.GetViewFromHwnd`
    ComCall(6, appViews, "ptr", hwnd, "ptr*", &view)
    ; Call `IVirtualDesktopPinnedApps.PinView`
    ComCall(7, pinnedApps, "ptr", view)
    ; Call `IUnknown.Release` on `view`
    ComCall(2, view)
}

;
; Watches for the "Picture in picture" window and set the
; "Show this window on all desktops" status on it.
;

PinPictureInPicture() {
    static titlePictureInPicture := "Picture in picture"
    static WS_VISIBLE := 0x10000000

    hwnd := WinExist(titlePictureInPicture)
    if hwnd and (WinGetStyle() & WS_VISIBLE) {
        PinWindow(hwnd)
    }
}

; Check every 2 seconds
SetTimer(PinPictureInPicture, 2000)

