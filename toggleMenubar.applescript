## Confirmed to work for macOS Sequoia 15.3.1.
## Created by: Archon Fung on December 22, 2023
## Updated and modified for Alfred by: Emad Abdelmaksoud on March 1, 2025

set tType to (system attribute "toggleType")
set neverOption to (system attribute "never")
set fsOption to (system attribute "fullscreenOnly")
set desktopOption to (system attribute "desktopOnly")
set alwaysOption to (system attribute "always")

if tType = "1" then
    set firstToggle to neverOption
    set secondToggle to fsOption
else if tType = "2" then
    set firstToggle to neverOption
    set secondToggle to alwaysOption
else if tType = "3" then
    set firstToggle to neverOption
    set secondToggle to desktopOption
else if tType = "4" then
    set firstToggle to fsOption
    set secondToggle to alwaysOption
else if tType = "5" then
    set firstToggle to fsOption
    set secondToggle to desktopOption
else if tType = "6" then
    set firstToggle to alwaysOption
    set secondToggle to desktopOption
else
    set firstToggle to neverOption
    set secondToggle to fsOption
end if

##open the system settings app in background
do shell script "open -j x-apple.systempreferences:com.apple.ControlCenter-Settings.extension"

tell application "System Events"
    
    tell application process "System Settings"
        delay 1
        ## get the current value of "Automatically hide and show the menu bar" dropdown list and put it inside 'currentMenubarValue' variable
        set currentMenubarValue to value of pop up button 1 of group 9 of scroll area 1 of group 1 of group 2 of splitter group 1 of group 1 of window "Control Center"
        if (currentMenubarValue is firstToggle) then
            set newMenubarValue to secondToggle
        else
            set newMenubarValue to firstToggle
        end if

        tell pop up button 1 of group 9 of scroll area 1 of group 1 of group 2 of splitter group 1 of group 1 of window "Control Center"
            click
            ##need delays to allow the menu items to populate
            delay 0.5
            click menu item newMenubarValue of menu 1
            delay 0.5
        end tell

    end tell
end tell
quit application "System Settings"