# https://unix.stackexchange.com/questions/269077/tput-setaf-color-table-how-to-determine-color-codes

# number of colors available
tput colors


# -- 8 colors --
# Color       #define       Value       RGB
# black     COLOR_BLACK       0     0, 0, 0
# red       COLOR_RED         1     max,0,0
# green     COLOR_GREEN       2     0,max,0
# yellow    COLOR_YELLOW      3     max,max,0
# blue      COLOR_BLUE        4     0,0,max
# magenta   COLOR_MAGENTA     5     max,0,max
# cyan      COLOR_CYAN        6     0,max,max
# white     COLOR_WHITE       7     max,max,max

# using tput
COLOR_GREEN="$(tput setaf 2)"
COLOR_DEFAULT="$(tput sgr0)"

echo -e "${COLOR_GREEN}All executables ran succesfully${COLOR_DEFAULT}"
printf "${COLOR_GREEN}All executables ran succesfully${COLOR_DEFAULT}\n"

# using escape codes
BLACK='\033[0;30m'
RED ='\033[0;31m'
GREEN='\033[0;32m'
YELLLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAYlIGHT='\033[0;37m'
DEFCLR:='\033[0;39m'
GRAYDARK='\033[0;90m'
REDLIGHT='\033[0;91m'
GREENLIGHT='\033[0;92m'
YELLOWLGIHT='\033[0;93m'
BLUELIGHT='\033[0;94m'
MAGNETALIGHT='\033[0;95m'
CYANLIGHT='\033[0;96m'
WHITE='\033[0;97m'

BOLDON:='\e[0;1m'
BOLDOFF:='\e[0;0m'

UNDERLINEON:='\e[0;4m'
UNDERLINEOFF:='\e[0;0m'

echo -e "${GREEN}All executables ran succesfully${DEFCLR}"
printf "${GREEN}All executables ran succesfully${DEFCLR}\n"



#--- 256 colors ---

# To see the extended 256 colors (as used by setaf in urxvt):
printf '\e[48;5;%dm ' {0..255}; printf '\e[0m \n'

#If you want numbers and an ordered output
color(){
    for c; do
        printf '\e[48;5;%dm%03d' $c $c
    done
    printf '\e[0m \n'
}

IFS=$' \t\n'
color {0..15}
for ((i=0;i<6;i++)); do
    color $(seq $((i*36+16)) $((i*36+51)))
done
color {232..255}

fromhex(){
    hex=${1#"#"}
    r=$(printf '0x%0.2s' "$hex")
    g=$(printf '0x%0.2s' ${hex#??})
    b=$(printf '0x%0.2s' ${hex#????})
    printf '%03d' "$(( (r<75?0:(r-35)/40)*6*6 + 
                       (g<75?0:(g-35)/40)*6   +
                       (b<75?0:(b-35)/40)     + 16 ))"
}

#!/bin/dash
tohex(){
    dec=$(($1%256))   ### input must be a number in range 0-255.
    if [ "$dec" -lt "16" ]; then
        bas=$(( dec%16 ))
        mul=128
        [ "$bas" -eq "7" ] && mul=192
        [ "$bas" -eq "8" ] && bas=7
        [ "$bas" -gt "8" ] && mul=255
        a="$((  (bas&1)    *mul ))"
        b="$(( ((bas&2)>>1)*mul ))" 
        c="$(( ((bas&4)>>2)*mul ))"
        printf 'dec= %3s basic= #%02x%02x%02x\n' "$dec" "$a" "$b" "$c"
    elif [ "$dec" -gt 15 ] && [ "$dec" -lt 232 ]; then
        b=$(( (dec-16)%6  )); b=$(( b==0?0: b*40 + 55 ))
        g=$(( (dec-16)/6%6)); g=$(( g==0?0: g*40 + 55 ))
        r=$(( (dec-16)/36 )); r=$(( r==0?0: r*40 + 55 ))
        printf 'dec= %3s color= #%02x%02x%02x\n' "$dec" "$r" "$g" "$b"
    else
        gray=$(( (dec-232)*10+8 ))
        printf 'dec= %3s  gray= #%02x%02x%02x\n' "$dec" "$gray" "$gray" "$gray"
    fi
}

