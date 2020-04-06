#! /bin/bash

# 0. Requirements: 
# 0.1 ImageMagick
## For old macOS version which `brew install imagemagick` wont work
## 0.1.1 Install old version manually using MacPorts, as described in https://trac.macports.org/wiki/howto/InstallingOlderPort
## 0.1.2 proxy settings: /opt/local/etc/macports/macports.conf ( `sudo` reset env)
## 0.1.3 cd ${git_root}/graphics/ImageMagick & sudo port -v install -- -x11 (use -f if dependency conflicts happen)
# 0.2 pngcopy / pngpaste
## make & install

time_stamp=`date +%Y_%m_%d_%H%M%S.png`
screenshot_path="${HOME}/Desktop/screencapture_${time_stamp}"
exe_pngpaste=/usr/local/bin/pngpaste
exe_pngcopy=/usr/local/bin/pngcopy
exe_convert=/opt/local/bin/convert

# 1. try clipboard
$exe_pngpaste -t
if [[ $? -ne 0 ]]; then
	# 1.1 clipboard not image. screenshot to clipboard
	screencapture -ic && :
fi

# 2. clipboard -> .png -> resize .png -> clipboard
$exe_pngpaste "$screenshot_path"
$exe_convert  "$screenshot_path" -resize 60% "$screenshot_path"
$exe_pngcopy  "$screenshot_path"
rm -f "$screenshot_path"

# 3. make TextEdit frontmost and paste
osascript <<'EOF'
tell application "System Events"
	reopen application "TextEdit"
	activate application "TextEdit"
	keystroke (ASCII character 31) using {command down}
	keystroke "v" using {command down}
end tell
EOF

