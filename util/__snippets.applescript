----------- for convinience ------------------
-- set sel_Color to choose color default color {65535, 0, 0}
-- log sel_Color
-----------------------------------------------

---------- code block as reminder ----------
-- tell front window of process "TextEdit"
-- set frontmost to true
-- get the clipboard as «class RTF »
-- tell front document to set its text to its text & (the clipboard) 
--	ignoring application responses
--	end ignoring
-- error number -128
-- quit
-- tell me to "exit"
-----------------------------------------------

(* ----- restore last frontmost window -----
tell application "System Events"
	set lastFrontAppID to bundle identifier of first process whose frontmost is true
end tell
activate application id lastFrontAppID
*)

(* ----- workaround "System Events" is not running?
tell application "System Events" to set thePID to (unix id of process "System Events")
set killCMD to ("kill -9 " & thePID) as text
do shell script killCMD with administrator privileges

set app_name to "System Events"
set the_pid to (do shell script "ps ax | grep " & (quoted form of app_name) & "$ | cut -d' ' -f1")
if the_pid is not "" then do shell script ("kill -9 " & the_pid)
*)

