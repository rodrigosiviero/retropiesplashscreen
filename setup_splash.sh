#!/bin/bash


Boot_install () {
   echo "Copying script to init.d"
   cp splashscreen.sh /etc/init.d/
   echo "Update-rc.d splashscreen.sh"
   update-rc.d splashscreen.sh defaults
   echo "Please do: sudo shutdown -r now"
}

Update () {
   echo "Updating images and script"
   git pull --rebase https://github.com/sur0x/retropiesplashscreen.git 
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
