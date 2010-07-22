all: install

check:
	if ! getent group cg 2> /dev/null; then echo "ERROR: cg group does not exist" >&2; false; fi

install: check
	install -d -m750 -gcg /etc/cg
	install -m750 -gcg cg /usr/local/bin/cg
	install -d -m750 -gcg /var/lib/cg
	install -d -m750 -gcg /var/lib/cg/vservers
	ln -s /usr/local/bin/cg /usr/local/bin/vcg
	install -m640 -gcg ignore /etc/cg/ignore
