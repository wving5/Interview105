
on equalColors(A, B)
	set retVal to true
	repeat with i from 1 to 3
		if (item i of A) ­ (item i of B) then
			set retVal to false
			exit repeat
		end if
	end repeat
	return retVal
end equalColors

on nextColorAvaliable(currentColor)
	set _cRed to {65535, 0, 0}
	set _cBlue to {7140, 0, 62785} --7140, 0, 52785
	set _cGreen to {0, 29580, 0}
	set _cPurple to {43350, 3315, 36975}
	set _availableColors to {_cRed, _cBlue, _cGreen} --, _cPurple}
	
	set i to 1
	repeat with theColor in _availableColors
		if equalColors(theColor, currentColor) then
			exit repeat
		end if
		set i to i + 1
	end repeat
	if i > (count of _availableColors) then
		set i to 0
	end if
	return item ((i mod (count of _availableColors)) + 1) of _availableColors
end nextColorAvaliable

---------- highlight selected text ----------
if application "TextEdit" is running then
	tell application "System Events"
		if exists (window 1 of process "TextEdit") then
			
			tell application "System Events" to tell window 1 of process "TextEdit"
				--try
				set {x, y} to value of attribute "AXSelectedTextRange" of text area 1 of scroll area 1 -- get selected range
				if y ³ x then
					set curColor to color of character x of document 1 of application "TextEdit" -- get 1st char's color
					set nextColor to my nextColorAvaliable(curColor) -- calling function inside tell stmt -- find next color in array
					set color of characters x thru y of document 1 of application "TextEdit" to nextColor -- apply new color
				end if
				--end try
			end tell
		end if
	end tell
end if