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

__p no 'System Preferences:General:Accent colour' Blue
defaults write -g AppleAccentColor -int 4
__p no 'System Preferences:General:Highlight colour' Blue
defaults write -g AppleHighlightColor -string '0.698039 0.843137 1.000000 Blue'
__p no 'System Preferences:General:Sidebar icon size' Small
defaults write -g NSTableViewDefaultSizeMode -int 1
__p no 'System Preferences:General:Allow wallpaper tinting in windows' NO
defaults write -g AppleReduceDesktopTinting -bool true
__p no 'System Preferences:General:Ask to keep changes when closing documents' YES
defaults write -g NSCloseAlwaysConfirmsChanges -bool true
__p yes 'System Preferences:General:Alow Handoff between this Mac and your iCloud devices' NO

__p yes 'System Preferences:Desktop & Screen Saver:Screen Saver:Start after' Never

__dock_item() {
	app_path="$(mdfind "kMDItemKind==Application \
	                    && kMDItemDisplayName==\"$1*\"")"
	printf '%s%s%s%s%s' \
	       '<dict><key>tile-data</key><dict><key>file-data</key><dict>' \
	       '<key>_CFURLString</key><string>' \
	       "${app_path}" \
	       '</string><key>_CFURLStringType</key><integer>0</integer>' \
	       '</dict></dict></dict>'
}

__p no 'Hidden:Arrange dock items' 'Activity Monitor, Terminal, Safari'
defaults write com.apple.dock persistent-apps -array \
	"$(__dock_item 'Activity Monitor')" \
	"$(__dock_item Terminal)" \
	"$(__dock_item Safari)"
__p no 'System Preferences:Dock & Menu Bar:Size' 40
defaults write com.apple.dock tilesize -int 40
__p no 'System Preferences:Dock & Menu Bar:Show recent applications in Dock' NO
defaults write com.apple.dock show-recents -bool no
__p no 'Hidden:Fix Dock size' YES
defaults write com.apple.dock size-immutable -bool yes
__p no 'Hidden:Fix Dock contents' YES
defaults write com.apple.dock contents-immutable -bool yes

__p no 'System Preferences:Mission Control:Automatically rearrange Spaces based on most recent use' NO
defaults write com.apple.dock mru-spaces -bool false

__p yes 'System Preferences:Siri:Enable Ask Siri' NO

__p yes 'System Preferences:Spotlight:Search Results' 'Applications, Calculator, Contacts, Conversion, Definition and System Preferences'
__p yes 'System Preferences:Spotlight:Privacy' '~/Projects'

__p yes 'System Preferences:Notifications:Do Not Disturb:Turn on Do Not Disturb' 'From 22:00 to 07:00'

__p no 'System Preferences:Accessibility:Display:Display:Reduce transparency' YES
defaults write com.apple.universalaccess reduceTransparency -bool true
__p yes 'System Preferences:Accessibility:Pointer Control:Mouse & Trackpad:Trackpad Options...:Enable dragging' 'YES, with three finger drag'

__p yes 'System Preferences:Security & Privacy:Privacy:Full Disk Access:Terminal' YES
__p no 'System Preferences:Security & Privacy:Privacy:Apple Advertising:Personalised Ads' NO
defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false

__p yes 'System Preferences:Sound:Show volume in menu bar' YES

__p no 'System Preferences:Keyboard:Keyboard:Key Repeat' 100%
defaults write -g KeyRepeat -int 2
__p no 'System Preferences:Keyboard:Keyboard:Delay Until Repeat' Shortest-1
defaults write -g InitialKeyRepeat -int 25
__p yes 'System Preferences:Keyboard:Keyboard:Adjust keyboard brightness in low light' NO
__p yes 'System Preferences:Keyboard:Keyboard:Press Fn key to' 'Do Nothing'
__p yes 'System Preferences:Keyboard:Keyboard:Modifier Keys...:Caps Lock' Control
__p no 'System Preferences:Keyboard:Text:Correct spelling automatically' NO
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
__p no 'System Preferences:Keyboard:Text:Capitalise words automatically' NO
defaults write -g NSAutomaticCapitalizationEnabled -bool false
__p no 'System Preferences:Keyboard:Text:Add full stop with double-space' NO
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
__p no 'System Preferences:Keyboard:Text:Use smart quotes and dashes' NO
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
__p no 'System Preferences:Keyboard:Input Sources:Show Input menu in menu bar' YES
defaults write com.apple.TextInputMenu visible -bool true
__p yes 'System Preferences:Keyboard:Dictation:Shortcut' Off

__p yes 'System Preferences:Trackpad:Point & Click:Look up & data detectors' NO
__p yes 'System Preferences:Trackpad:Point & Click:Tap to click' NO
__p yes 'System Preferences:Trackpad:More Gestures:Launchpad' NO

__p yes 'System Preferences:Mouse:Tracking speed' 90%
__p yes 'System Preferences:Mouse:Scrolling speed' 20%

__p yes 'System Preferences:Displays:Display:Automatically adjust brightness' NO


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
__p no 'Safari:Preferences:Tabs:Show website icons in tabs' NO
defaults write com.apple.Safari ShowIconsInTabs -bool false
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
__p no 'Safari:View' 'Show Status Bar'
defaults write com.apple.Safari ShowOverlayStatusBar -bool true


__p no 'Hidden:Screenshot' 'Disable shadow'
defaults write com.apple.screencapture disable-shadow -bool true
__p no 'Screenshot:Options' 'Show Floating Thumbnail'
defaults write com.apple.screencapture show-thumbnail -bool false

__p no 'Hidden:Terminal' 'Remove copy style'
defaults write com.apple.Terminal \
               CopyAttributesProfile com.apple.Terminal.no-attributes

killall Dock Finder Activity\ Monitor && open -jga Activity\ Monitor
