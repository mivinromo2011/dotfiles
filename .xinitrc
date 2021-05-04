lxpolkit &
picom -f --experimental-backends --config /home/mivin/.config/picom/picom.conf &
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources &

exec dbus-launch i3 
