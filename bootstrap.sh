# Bootstrap a new site.

if [ $1 == "init" ] ; then
	# create bootstrapping directory
	mkdir $2
	cd $2

	# init guard file, hiding unimportant messages. should still
	# report a bad outcome
	guard init livereload 2>&1 | grep -v INFO

	# make public dir andcopy other webby bootstrapping things
	# into this directory
	mkdir public
	cp -r ~/.web-bootstrap/template/* ./public

	# init a git repository
	git init && git add . && git commit -m "- Initial commit"

	# put us back where we were
	cd ..

	echo "Done bootstrapping!"

elif [ $1 == "serve" ] ; then
	# start the web server
	heel -p 8080 -r ./public -d

	# sleep half a second to allow guard to start, then refresh
	# for livereload
	(sleep .5 && osascript ~/.web-bootstrap/refresh-safari.scpt)&

	# start guard
	guard

	# kill the web server
	heel -k -p 8080

elif [ $1 == "kill" ] ; then
	heel -k -p 8080
fi

