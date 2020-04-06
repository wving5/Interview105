
all:
	$(CC) -Wall -g -O3 -ObjC \
		-framework Foundation -framework AppKit \
		-o pngcopy \
		pngcopy.m
install: all
	cp pngcopy /usr/local/bin/
clean:
	find . \( -name '*~' -or -name '#*#' -or -name '*.o' \
		  -or -name 'pngcopy' -or -name 'pngcopy.dSYM' \) \
		-exec rm -rfv {} \;
	rm -rfv *.dSYM/ pngcopy;