(*

----------- for convinience ------------------
-----------------------------------------------
-- set sel_Color to choose color default color {65535, 0, 0}
-- log sel_Color
-----------------------------------------------


---------- code block as reminder ----------
-----------------------------------------------
-- tell front window of process "TextEdit"
-- set frontmost to true
-- get the clipboard as «class RTF » (or 《class RTF 》 )
-- tell front document to set its text to its text & (the clipboard) 
--	ignoring application responses
--	end ignoring
-- error number -128
-- quit
-- tell me to "exit"
-----------------------------------------------


----- restore last frontmost window -----
-----------------------------------------------
tell application "System Events"
	set lastFrontAppID to bundle identifier of first process whose frontmost is true
end tell
activate application id lastFrontAppID
-----------------------------------------------


----- workaround "System Events" is not running? -----
---------------------------------------------------------
tell application "System Events" to set thePID to (unix id of process "System Events")
set killCMD to ("kill -9 " & thePID) as text
do shell script killCMD with administrator privileges
---
set app_name to "System Events"
set the_pid to (do shell script "ps ax | grep " & (quoted form of app_name) & "$ | cut -d' ' -f1")
if the_pid is not "" then do shell script ("kill -9 " & the_pid)
---------------------------------------------------------


----- The historic 'MacRoman' encoding issue with  '/Applications/Utilities/Script Editor.app' -----
----- Refer: http://www.alanwood.net/demos/charsetdiffs.html (ISO-8859-1 vs MacRoman vs ANSI)
-----------------------------------------------------------------------------------------------------
# UTF-8 
-- $ iconv -f MAC -t UTF-8 < file > file.new  # MAC short for macintosh, see `iconv -l`
-- Note: 
	 -f MAC -t UTF-16/32   # auto-preappend bom info, Big Endian
	 -f MAC -t UTF-16/32BE # *NO* bom info
	 -f MAC -t UTF-16/32BE # *NO* bom info
	 `file -I utf32_file` returns "charset=binary"

------------------------------------
Encoding 				BOM
------------------------------------
UTF-8					EF BB BF (This is not literally a "byte order" mark)
UTF-16（BE）				FE FF
UTF-16（LE）				FF FE
UTF-32（BE）				00 00 FE FF
UTF-32（LE）				FF FE 00 00
UTF-7					...
UTF-1					...
UTF-EBCDIC				...
SCSU					0E FE FF
BOCU-1					FB EE 28
GB-18030				84 31 95 33
------------------------------------

# UTF-16 with explicit BOM header
## insert bytes
$ printf "\xfe\xff" | cat - oldfile > newfile
$ { head -c M file; printf %0Ns | tr \0 '\x34'; tail -c +(N+M) file; } > new_file # inserting N repeated instances of \x34 starting at position M

## overwrite bytes
$ printf '\xa1' | dd conv=notrunc of=Yourfile bs=1 seek=$((0xoffset)) # dd
$ cat small-file 1<> big-file >#((12345)) # ksh93
$ zmodload zsh/system; {sysseek -u1 12345 && cat small-file} 1<> big-file # zsh

------------------------------------
set theFile to POSIX path of (choose file)

set newFileName to (do shell script "str=" & quoted form of theFile & ";echo ${str%.*}") & "_iconv.txt"

set enc to "UTF-16BE"
set cmd to "xxd -p -r <<< xfeff "
do shell script cmd & " > " & quoted form of newFileName # write the BOM : FE FF in the new file

do shell script "iconv -f UTF-8 -t " & enc & space & quoted form of theFile & " >> " & quoted form of newFileName # write the UTF16-BE encoded text after the BOM
-----------------------------------------------------------------------------------------------------

*)


