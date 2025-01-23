#!/usr/bin/env osascript

tell application "System Events"
	set darkMode to get dark mode of appearance preferences
end tell

tell application "Terminal"
	if darkMode then
		set settingsSet to first settings set whose name is "Chromatine Dark"
	else
		set settingsSet to first settings set whose name is "Chromatine Light"
	end if
	
	repeat with aWindow in windows
		repeat with aTab in tabs of aWindow
			set current settings of aTab to settingsSet
		end repeat
	end repeat
end tell
