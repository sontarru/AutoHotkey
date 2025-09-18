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
