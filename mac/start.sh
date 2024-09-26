#disable spotlight indexing
sudo mdutil -i off -a
#Create new account
sudo dscl . -create /Users/phaa
sudo dscl . -create /Users/phaa UserShell /bin/bash
sudo dscl . -create /Users/phaa RealName PHAA
sudo dscl . -create /Users/phaa UniqueID 1001
sudo dscl . -create /Users/phaa PrimaryGroupID 80
sudo dscl . -create /Users/phaa NFSHomeDirectory /Users/tcv
sudo dscl . -passwd /Users/phaa P@ssw0rd!
sudo createhomedir -c -u phaa > /dev/null
sudo dscl . -append /Groups/admin GroupMembership phaa
#Enable VNC
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -clientopts -setvnclegacy -vnclegacy yes
echo runnerrdp | perl -we 'BEGIN { @k = unpack "C*", pack "H*", "1734516E8BA8C5E2FF1C39567390ADCA"}; $_ = <>; chomp; s/^(.{8}).*/$1/; @p = unpack "C*", $_; foreach (@k) { printf "%02X", $_ ^ (shift @p || 0) }; print "\n"' | sudo tee /Library/Preferences/com.apple.VNCSettings.txt
#Start VNC/reset changes
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent -console
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate
#install ngrok
brew install --cask ngrok
#configure ngrok and start it
ngrok authtoken $1
ngrok tcp 5900 --region=in &