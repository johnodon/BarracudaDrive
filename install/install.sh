#!/bin/bash
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
