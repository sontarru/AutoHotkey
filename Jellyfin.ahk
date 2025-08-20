;
; Watches for the "Picture in picture" window and set the
; "Show this window on all desktops" status on it.
;

titlePictureInPicture := "Picture in picture"

; Get `IServiceProvider`
CLSID_ImmersiveShell := "{C2F03A33-21F5-47FA-B4BB-156362A2F239}"
IID_IServiceProvider := "{6D5140C1-7436-11CE-8034-00AA006009FA}"
serviceProvider := ComObject(CLSID_ImmersiveShell, IID_IServiceProvider)

; Call `QueryService` for `IVirtualDesktopPinnedApps` on `serviceProvider`
CLSID_VirtualDesktopPinnedApps := "{B5A399E7-1C87-46B8-88E9-FC5747B171BD}"
IID_IVirtualDesktopPinnedApps := "{4CE81583-1E4C-4632-A621-07A53543148F}"
pinnedApps := ComObjQuery(serviceProvider, CLSID_VirtualDesktopPinnedApps, IID_IVirtualDesktopPinnedApps)

; Call `QueryService` for `IApplicationViewCollection` on `serviceProvider`
IID_IApplicationViewCollection := "{1841C6D7-4F9D-42C0-AF41-8747538F10E5}"
appViews := ComObjQuery(serviceProvider, IID_IApplicationViewCollection, IID_IApplicationViewCollection)

PinPictureInPicture() {
    hwnd := WinExist(titlePictureInPicture)
    if hwnd {
        view := 0
        ; Call `IApplicationViewCollection.GetViewFromHwnd`
        ComCall(6, appViews, "ptr", hwnd, "ptr*", &view)
        ; Call `IVirtualDesktopPinnedApps.PinView`
        ComCall(7, pinnedApps, "ptr", view)
        ; Call `Release` on `view`
        ComCall(2, view)
    }
}

; Chek every 2 second
SetTimer(PinPictureInPicture, 2000)
