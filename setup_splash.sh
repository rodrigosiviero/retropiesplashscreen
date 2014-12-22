#!/bin/bash

##Check for git
git --version
OUT=$?

Boot_install () {
   echo "Copying script to init.d"
   cp splashscreen.sh /etc/init.d/
   echo "Update-rc.d splashscreen.sh"
   update-rc.d splashscreen.sh defaults
   echo "Please do: sudo shutdown -r now"
}

Update () {
##Check for git
git --version
OUT=$?
echo "Updating images and script"
if [ $OUT == 0 ]; then
   echo "Updating with git"
   git pull --rebase https://github.com/sur0x/retropiesplashscreen.git
elif [ $OUT == 127 ]; then
   echo "Updating without git"
   wget --no-check-certificate -qO tmp.zip https://github.com/sur0x/retropiesplashscreen/archive/master.zip
   unzip -o tmp.zip
   mv retropisplashscreen-master/* .
   rm -rf  retropisplashscreen-master/
   rm tmp.zip
fi
cp -r splashscreens/ /home/pi/RetroPie-Setup/supplementary/
}

####
PS3='Select the Option: '
options=("Boot Install" "Update" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Boot Install")
	    Boot_install
	    break	
            ;;
        "Update")
            Update
	    break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
