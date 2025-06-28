picom --config $HOME/.config/picom/picom.conf &
xwallpaper --stretch ~/pics/wp/lainroom.png
xinput --set-prop 10 "libinput Accel Speed" -0.2 &
xinput --set-prop 16 "libinput Accel Speed" 0.3 &
xinput --set-prop 16 286 1 &
xrdb -merge $HOME/.Xresources
dunst &
dwmblocks &
exec dwm
