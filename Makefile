all: install

check:
	if ! getent group cg 2> /dev/null; then echo "ERROR: cg group does not exist" >&2; false; fi

install: check
	install -d -m750 -gcg /etc/cg
	install -d -m770 -gcg /var/lib/cg
	install -m750 -gcg cg /usr/local/bin/cg
	install -m640 -gcg ignore /etc/cg/ignore

init:
	cg init
	cg config --add core.excludesfile /etc/cg/ignore
	cg config --add core.sharedrepository true
	cg config --add core.bare true
	cg add /etc/cg/ignore
	cg commit -m "Initial"
	cg branch deploy
	cg checkout deploy
	chgrp -R cg /var/lib/cg
	chmod -R g+rwX /var/lib/cg
	echo "*** SUCCESS ***"
