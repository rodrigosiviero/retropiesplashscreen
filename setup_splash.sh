#!/bin/bash

Boot_install () {
   echo "Copying script to init.d"
   cp splashscreen.sh /etc/init.d/
   echo "Update-rc.d splashscreen.sh"
   update-rc.d splashscreen.sh defaults
   echo "Please do: sudo shutdown -r now"
}

Update () {
##Check for git
git status &> /dev/null
OUT=$?
echo "Updating images and script"
if [ $OUT == 0 ]; then
   echo "Updating with git"
   git reset --hard
   git clean -f
   echo "Making sure there's not change on this dir"
   git pull https://github.com/sur0x/retropiesplashscreen.git 
elif [ $OUT == 128 ]; then
   echo "Updating without git"
   wget --no-check-certificate -qO tmp.zip https://github.com/sur0x/retropiesplashscreen/archive/master.zip
   unzip -qq -o tmp.zip
   rsync -a retropiesplashscreen-master/* .
   rm -rf  retropiesplashscreen-master/
   rm tmp.zip
fi
sudo cp -r splashscreens/* /opt/retropie/supplementary/splashscreen/
}

CopySplashs () {
#Copy Splashs over
sudo cp -r splashscreens/* /opt/retropie/supplementary/splashscreen/
}

CopyVideos () {
echo "Copying Videos"
wget --no-check-certificate https://bitbucket.org/sur0x/retropie-videos-splashscreens/get/master.tar.gz -P videos/
tar xf videos/master.tar.gz -C videos/
sudo cp -rf videos/sur0x*/videos/* /opt/retropie/supplementary/splashscreen/
sudo rm -rf videos/
}

####
PS3='Select the Option: '
options=("Boot Install" "Update" "Copy Splashs" "Copy Video" "Quit")
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
	"Copy Splashs")
            CopySplashs
            break
	    ;;
	"Copy Video")
	    CopyVideos
            break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
