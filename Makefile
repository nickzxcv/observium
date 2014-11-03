# Nick Schmalenberger
# November 2, 2014

PARENTDIR=/data/nicks
# /opt/observium is a symlink to /data/nicks/observium
OBSERVIUMDIR=/data/nicks/observium
DBPASSWORD=password

init:
# This sets up a fresh observium source tree from the local svn mirror
# to make it easier to test patches without other changes on the tree
	echo " \
	DROP DATABASE IF EXISTS observium; \
	CREATE DATABASE observium; \
	GRANT ALL PRIVILEGES ON observium.* TO 'observium'@'localhost' IDENTIFIED BY '$(DBPASSWORD)'; \
		" | mysql -u root

	rm -rf $(PARENTDIR)/observium
	svn checkout file:///$(PARENTDIR)/observium-mirror/observium/trunk $(OBSERVIUMDIR)
	cp ~/observium/observium-config.php $(OBSERVIUMDIR)/config.php
	cd $(OBSERVIUMDIR); php includes/update/update.php
	mkdir -p $(OBSERVIUMDIR)/logs # may have already been created in update.php
	mkdir $(OBSERVIUMDIR)/rrd
	sudo chown www-data:www-data $(OBSERVIUMDIR)/rrd

