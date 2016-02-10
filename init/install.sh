#!/bin/bash
cd /tmp

# If BD is already installed the upgrade
if [ -f "/home/nobody/bdd" ]; then
	sleep 1
	chown -R nobody:users /home/nobody
	rm -f bd&&mkdir bd&&cd bd
	wget http://barracudadrive.com/BarracudaDrive.linux-x64.tar.gz || abort
	tar xvzf BarracudaDrive.linux-x64.tar.gz
	rm BarracudaDrive.linux-x64.tar.gz
    	chmod +x bdd
    	#Remove files that should not be upgraded
    	rm -rf cmsdocs data disk InstallDaemon
    	cd applications
    	rm -f Config-Wizard.zip
    	wget http://barracudadrive.com/unix/backup.zip || abort
    	cd ..
    	chown -R nobody:users ./*
    	/etc/init.d/bdd stop
    	sleep 2
    	mv bdd.conf bdd.conf.NEW
    	cp -p -r ./* /home/nobody
    	cd ..
    	rm -rf bd
    	/etc/init.d/bdd start
    	exit 0
fi

useradd -G users -m -s /bin/bash nobody || abort
chown -R nobody:users /home/nobody
cd /home/nobody || abort
wget http://barracudadrive.com/BarracudaDrive.linux-x64.tar.gz || abort
tar xvzf BarracudaDrive.linux-x64.tar.gz || abort
chmod +x bdd
rm -f BarracudaDrive.linux-x64.tar.gz
rm -f *.txt
cd InstallDaemon || abort
sed -i 's/BDUSER=bd/BDUSER=nobody/g' /home/nobody/InstallDaemon/bdd.sh
sed -i 's+BDHOME=/home/bd+BDHOME=/home/nobody+g' /home/nobody/InstallDaemon/bdd.sh
chmod +x *.sh
./install.sh
#sleep 5
#cd ..
#rm -rf InstallDaemon || abort
#ln -s /home/nobody/cmsdocs disk/cmsdocs
#ln -s /home/nobody/applications disk/applications
#cd applications
#wget http://barracudadrive.com/unix/sslcert.zip || abort
chown -R nobody:users /home/nobody
#/etc/init.d/bdd start
exit 0
