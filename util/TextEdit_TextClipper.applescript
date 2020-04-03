---------- copy selected text to TextEdit.app and restore front window ----------

tell application "System Events"
	keystroke "c" using {command down} -- copy rich text selected
	reopen application "TextEdit" -- unminimizes the 1st minimized window or makes a new one
	activate application "TextEdit" -- makes the app frontmost
	
	keystroke (ASCII character 31) using {command down} -- move cursor to last line
	keystroke "v" using {command down} -- paste rich text -- for "paste & match style" use {option down, shift down, command down}
	tell application "TextEdit"
		make new paragraph at end of front document with data (ASCII character 10) & (ASCII character 10) -- insert new line
	end tell
	keystroke (ASCII character 31) using {command down} -- move cursor to last line
end tell
activate front window