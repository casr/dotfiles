#!/bin/sh

set -e

# Aim to set most settings, if possible, unless they are too complicated or
# dependent on a particular hardware setup

__p() {
	manual="$1"
	option="$2"
	value="$3"
	if [ "${manual}" = yes ]; then
		printf '\e[07m[MANUAL]\e[0m %s = %s\n' "${option}" "${value}"
	else
		printf '[ DONE ] %s = %s\n' "${option}" "${value}"
	fi
}

__p no 'System Settings:Appearance:Accent colour' Blue
defaults write -g AppleAccentColor -int 4
__p no 'System Settings:Appearance:Highlight colour' Blue
defaults write -g AppleHighlightColor -string '0.698039 0.843137 1.000000 Blue'
__p no 'System Settings:Appearance:Sidebar icon size' Small
defaults write -g NSTableViewDefaultSizeMode -int 1
__p no 'System Settings:Appearance:Allow wallpaper tinting in windows' NO
defaults write -g AppleReduceDesktopTinting -bool true
__p no 'System Settings:Desktop & Dock:Ask to keep changes when closing documents' YES
defaults write -g NSCloseAlwaysConfirmsChanges -bool true
__p yes 'System Settings:General:AirDrop & Handoff:Allow Handoff between this Mac and your iCloud devices' NO

__p yes 'System Settings:General:AirDrop & Handoff:AirPlay Receiver' NO

__p yes 'System Settings:Lock Screen:Start Screen Saver when inactive' Never

__dock_app_item() {
	app_path="$(readlink -f "$(mdfind "kMDItemKind==Application \
	                    && kMDItemDisplayName==\"$1*\"")")"
	printf '%s' \
	       '<dict>' \
	         '<key>tile-data</key><dict>' \
	           '<key>file-data</key><dict>' \
	             "<key>_CFURLString</key><string>${app_path}</string>" \
	             '<key>_CFURLStringType</key><integer>0</integer>' \
	           '</dict>' \
	         '</dict>' \
	       '</dict>'
}

__dock_directory_item() {
	file_path="$1"
	printf '%s' \
	       '<dict>' \
	         '<key>tile-data</key><dict>' \
	           '<key>file-data</key><dict>' \
	             "<key>_CFURLString</key><string>file://${file_path}</string>" \
	             '<key>_CFURLStringType</key><integer>15</integer>' \
	           '</dict>' \
	         '</dict>' \
	         '<key>tile-type</key><string>directory-tile</string>' \
	       '</dict>'
}

__p no 'Hidden:Arrange dock items' 'Activity Monitor, Terminal, Safari, System Settings'
defaults write com.apple.dock persistent-apps -array \
	"$(__dock_app_item 'Activity Monitor')" \
	"$(__dock_app_item 'System Settings')" \
	"$(__dock_app_item Terminal)" \
	"$(__dock_app_item Safari)"
__p no 'Hidden:Arrange dock items (other)' 'Downloads, Screenshots'
defaults write com.apple.dock persistent-others -array \
	"$(__dock_directory_item "${HOME}/Downloads")" \
	"$(__dock_directory_item "${HOME}/Pictures/Screenshots")"
__p no 'System Settings:Desktop & Dock:Size' 40
defaults write com.apple.dock tilesize -int 40
__p no 'System Settings:Desktop & Dock:Show suggested and recent applications in Dock' NO
defaults write com.apple.dock show-recents -bool no
__p no 'Hidden:Fix Dock size' YES
defaults write com.apple.dock size-immutable -bool yes
# __p no 'Hidden:Fix Dock contents' YES
# defaults write com.apple.dock contents-immutable -bool yes

__p no 'System Settings:Desktop & Dock:Automatically rearrange Spaces based on most recent use' NO
defaults write com.apple.dock mru-spaces -bool false
__p yes 'System Settings:Desktop & Dock:Hot Corners...' NO

__p yes 'System Settings:Siri & Spotlight:Ask Siri' NO

__p yes 'System Settings:Siri & Spotlight:Search Results' 'Applications, Calculator, Contacts, Conversion, Definition and System Preferences'
__p yes 'System Settings:Siri & Spotlight:Privacy' '~/Projects'

__p yes 'System Settings:Focus:Do Not Disturb' 'From 22:00 to 07:00'

__p no 'System Settings:Accessibility:Display:Reduce transparency' YES
defaults write com.apple.universalaccess reduceTransparency -bool true
__p yes 'System Settings:Accessibility:Pointer Control:Trackpad Options...:Use trackpad for dragging' 'YES, with three finger drag'

__p no 'System Settings:Privacy & Security:Apple Advertising:Personalised Ads' NO
defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false

__p yes 'System Settings:Control Centre:Sound' 'Always Show in Menu Bar'

__p no 'System Settings:Keyboard:Key repeat rate' Fast-1
defaults write -g KeyRepeat -int 2
__p no 'System Settings:Keyboard:Delay until repeat' Short-2
defaults write -g InitialKeyRepeat -int 25
__p yes 'System Settings:Keyboard:Adjust keyboard brightness in low light' NO
__p yes 'System Settings:Keyboard:Press Fn key to' 'Show Emoji & Symbols/Do Nothing'
__p yes 'System Settings:Keyboard:Keyboard Shortcuts...:Modifier Keys:Caps Lock' Control
__p no 'System Settings:Keyboard:Input Sources | Edit...:Correct spelling automatically' NO
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
__p no 'System Settings:Keyboard:Input Sources | Edit...:Capitalise words automatically' NO
defaults write -g NSAutomaticCapitalizationEnabled -bool false
__p no 'System Settings:Keyboard:Input Sources | Edit...:Show inline predictive text' NO
defaults write -g NSAutomaticInlinePredictionEnabled -bool false
__p no 'System Settings:Keyboard:Input Sources | Edit...:Add full stop with double-space' NO
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
__p no 'System Settings:Keyboard:Input Sources | Edit...:Use smart quotes and dashes' NO
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
__p no 'System Settings:Keyboard:Input Sources | Edit...:Show Input menu in menu bar' YES
defaults write com.apple.TextInputMenu visible -bool true
__p yes 'System Settings:Keyboard:Dictation' Off

__p yes 'System Settings:Trackpad:Point & Click:Look up & data detectors' NO
__p yes 'System Settings:Trackpad:Point & Click:Tap to click' NO
__p yes 'System Settings:Trackpad:More Gestures:Mission Control' NO
__p yes 'System Settings:Trackpad:More Gestures:App Exposé' 'Swipe Down with Four Fingers'
__p yes 'System Settings:Trackpad:More Gestures:Launchpad' NO

__p yes 'System Settings:Mouse:Tracking speed' 90%
__p yes 'System Settings:Mouse:Scrolling speed' 20%


__p yes 'Activity Monitor:Dock Icon:Options' 'Open at Login'
__p no 'Activity Monitor:View:Dock Icon' 'Show CPU History'
defaults write com.apple.ActivityMonitor IconType -int 6
__p no 'Activity Monitor:View' 'All Processes'
defaults write com.apple.ActivityMonitor ShowCategory -int 100


__p no 'Finder:Preferences:General:New Finder windows show' '$HOME'
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
defaults write com.apple.finder NewWindowTarget -string PfHm
__p yes 'Finder:Preferences:Sidebar' '$HOME, etc'
__p no 'Finder:Preferences:Sidebar:Recent Tags' NO
defaults write com.apple.finder ShowRecentTags -bool false
__p no 'Finder:Preferences:Advanced:Show all filename extensions' YES
defaults write -g AppleShowAllExtensions -bool true
__p no 'Finder:Preferences:Advanced:When performing a search' 'Search the Current Folder'
defaults write com.apple.finder FXDefaultSearchScope -string SCcf
__p yes 'Finder:View' 'Show Path Bar'
__p no 'Finder:Right click:Show View Options:Always open in list view' YES
defaults write com.apple.finder FXPreferredViewStyle Nlsv


# Opening and closing Safari to force the preferences to be created.
open -gja Safari && sleep 3 && killall Safari
__p no 'Safari:Preferences:General:Safari opens with' 'All windows from last session'
defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool true
__p yes 'Safari:Preferences:General:Homepage' 'about:blank'
__p no 'Safari:Preferences:General:Open "safe" files after downloading' NO
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
__p yes 'Safari:Preferences:Tabs:Separate' YES
__p yes 'Safari:Preferences:Tabs:Always show website titles in tabs' NO
__p yes 'Safari:Preferences:Advanced:Show colour in compact tab bar' NO
__p no 'Safari:Preferences:AutoFill:Using information from my contacts' NO
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
__p no 'Safari:Preferences:AutoFill:Usernames and passwords' NO
defaults write com.apple.Safari AutoFillPasswords -bool false
__p no 'Safari:Preferences:AutoFill:Credit cards' NO
defaults write com.apple.Safari AutoFillCreditCardData -bool false
__p no 'Safari:Preferences:AutoFill:Other forms' NO
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
__p no 'Safari:Preferences:Search:Search engine' Ecosia
defaults write com.apple.Safari SearchProviderIdentifier -string org.ecosia.www
__p no 'Safari:Preferences:Search:Include Safari Suggestions' NO
defaults write com.apple.Safari UniversalSearchEnabled -bool false
__p no 'Safari:Preferences:Search:Preload Top Hit in the background' NO
defaults write com.apple.Safari PreloadTopHit -bool false
__p no 'Safari:Preferences:Search:Show Favourites' NO
defaults write com.apple.Safari ShowFavoritesUnderSmartSearchField -bool false
__p no 'Safari:Preferences:Advanced:Show full website address' YES
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
__p yes 'Safari:Preferences:Advanced:Show Develop menu in menu bar' YES
__p yes 'Safari:View' 'Always Show Tab Bar'
__p no 'Safari:View' 'Show Status Bar'
defaults write com.apple.Safari ShowOverlayStatusBar -bool true


__p no 'Hidden:Screenshot' 'Disable shadow'
defaults write com.apple.screencapture disable-shadow -bool true
__p no 'Screenshot:Options' 'Show Floating Thumbnail'
defaults write com.apple.screencapture show-thumbnail -bool false
__p no 'Screenshot:Options:Other location...' '~/Pictures/Screenshots'
mkdir -p ~/Pictures/Screenshots
defaults write com.apple.screencapture location -string '~/Pictures/Screenshots'

__p yes 'Terminal:Preferences:Profiles:Shell:When the shell exits' 'Close if the shell exited cleanly'
__p no 'Hidden:Terminal' 'Remove copy style'
defaults write com.apple.Terminal \
               CopyAttributesProfile com.apple.Terminal.no-attributes

killall Dock Finder Activity\ Monitor && open -jga Activity\ Monitor
