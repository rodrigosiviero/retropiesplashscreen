### BEGIN INIT INFO
# Provides:          splashcreen
# Required-Start:    
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: splashscreen randomizer 
### END INIT INFO
#/bin/bash
rm dirs.txt
for path in /home/pi/RetroPie-Setup/supplementary/splashscreens/*; do
    [ -d "${path}" ] || continue # if not a directory, skip
    dirname="$(basename "${path}")"
    echo $dirname >> dirs.txt
done

temp=$(shuf -n 1 dirs.txt)

echo "$(ls /home/pi/RetroPie-Setup/supplementary/splashscreens/$temp/*)" > /etc/splashscreen.list 
