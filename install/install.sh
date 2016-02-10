#!/bin/bash
cd /tmp
if [ -f "/home/bd/bdd" ]; then
	sleep 1
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
    chown -R bd:daemon ./*
    /etc/init.d/bdd stop
    sleep 2
	mv bdd.conf bdd.conf.NEW
    cp -p -r ./* /home/bd
    cd ..
    rm -rf bd
    /etc/init.d/bdd start
    exit 0
fi

useradd -G daemon -m -s /bin/bash  bd || abort
cd /home/bd || abort
wget http://barracudadrive.com/BarracudaDrive.linux-x64.tar.gz || abort
tar xvzf BarracudaDrive.linux-x64.tar.gz || abort
chmod +x bdd
rm -f BarracudaDrive.linux-x64.tar.gz
rm -f *.txt
cd InstallDaemon || abort
chmod +x *.sh
./install.sh
cd ..
rm -rf InstallDaemon || abort
ln -s /home/bd/cmsdocs disk/cmsdocs
ln -s /home/bd/applications disk/applications
cd applications
wget http://barracudadrive.com/unix/sslcert.zip || abort
chown -R bd:daemon /home/bd
/etc/init.d/bdd start
