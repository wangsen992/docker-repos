#!/bin/bash

# Install kasmvnc
wget https://github.com/kasmtech/KasmVNC/releases/download/v1.3.0/kasmvncserver_jammy_1.3.0_amd64.deb
sudo apt-get install -y ./kasmvncserver_*.deb
rm ./kasmvncserver_*.deb
# 
# # Add your user to the ssl-cert group
sudo addgroup $USER ssl-cert
echo -e "swang18\nswang18\n" | vncpasswd -u swang18 -row
sudo chmod 777 -R /etc/ssl

# install usable terminal for xfce4
sudo apt-get install -y xfce4 xfce4-terminal

# install firefox
# https://support.mozilla.org/en-US/kb/install-firefox-linux#w_install-firefox-deb-package-for-debian-based-distributions
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla
sudo apt-get update && sudo apt-get install -y firefox


