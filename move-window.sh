#!/usr/bin/env bash
# $1 ... top | bottom | left | right
#
 
xprop -root |
    sed -rne 's/^_NET_WORKAREA\(CARDINAL\) = ([0-9]+), ([0-9]+), ([0-9]+), ([0-9]+).*/\1 \2 \3 \4/p' |
    {
        # (x,y) is topleft corner, (w,h) is space (width, height)
        # available. for me x = 0 but y = 25 because of the gnome
        # menubar which sticks to the top.
        read x y w h
        # Now decide where you want your active window:
        case "$1" in
            top    ) ((h=h/2));;
            bottom ) ((h=h/2));((y=y+h));;
            left   ) ((w=w/2));;
            right  ) ((w=w/2));((x=x+w));;
        esac
        # unmaximize, otherwise nothing happens.
        wmctrl -r ':ACTIVE:' -b remove,maximized_vert,maximized_horz
        # change geometry:
        wmctrl -r ':ACTIVE:' -e 0,$x,$y,$w,$h
    }