; AutoHotkey v2 Script to Open Alacritty as "Terminal 1" with Ctrl+Shift+1

#Requires AutoHotkey v2.0+

; Hotkey for Ctrl + Shift + 1 (Terminal 1)
^+1:: {
    title := "Terminal 1"
    
    if WinExist(title) 
        WinActivate 
    else 
        Run('alacritty.exe -t "' title '"')
}

; Hotkey for Ctrl + Shift + 2 (Terminal 2)
^+2:: {
    title := "Terminal 2"
    
    ; Check if a window with the title "Terminal 1" already exists
    if WinExist(title) 
        WinActivate 
    else 
        Run('alacritty.exe -t "' title '"')
}

; Hotkey for Ctrl + Shift + 3 (Terminal 3)
^+3:: {
    title := "Terminal 3"
    if WinExist(title)
        WinActivate(title)
    else
        Run('alacritty.exe -t "' title '"')
}

; Hotkey for Ctrl + Shift + 4 (Terminal 4)
^+4:: {
    title := "Terminal 4"
    if WinExist(title)
        WinActivate(title)
    else
        Run('alacritty.exe -t "' title '"')
}

; Hotkey for Ctrl + Shift + 5 (Terminal 5)
^+5:: {
    title := "Terminal 5"
    if WinExist(title)
        WinActivate(title)
    else
        Run('alacritty.exe -t "' title '"')
}

; Hotkey for Ctrl + Shift + 6 (Terminal 6)
^+6:: {
    title := "Terminal 6"
    if WinExist(title)
        WinActivate(title)
    else
        Run('alacritty.exe -t "' title '"')
}

; Hotkey for Ctrl + Shift + 7 (Terminal 7)
^+7:: {
    title := "Terminal 7"
    if WinExist(title)
        WinActivate(title)
    else
        Run('alacritty.exe -t "' title '"')
}

; Hotkey for Ctrl + Shift + 8 (Terminal 8)
^+8:: {
    title := "Terminal 8"
    if WinExist(title)
        WinActivate(title)
    else
        Run('alacritty.exe -t "' title '"')
}

; Hotkey for Ctrl + Shift + 9 (Terminal 9)
^+9:: {
    title := "Terminal 9"
    if WinExist(title)
        WinActivate(title)
    else
        Run('alacritty.exe -t "' title '"')
}

; Hotkey for Ctrl + Shift + 0 (Terminal 10)
^+0:: {
    title := "Terminal 10"
    if WinExist(title)
        WinActivate(title)
    else
        Run('alacritty.exe -t "' title '"')
}

