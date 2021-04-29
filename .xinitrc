rclone --vfs-cache-mode writes mount \"College-OneDrive\":  ~/College &
lxpolkit &
picom -f --experimental-backends --config /home/mivin/.config/picom/picom.conf &
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources &

exec i3
