# GDM3 Login Background Changer
Bash script that replaces the original login background from the distro with your own.


# Disclaimer

**Use at your own *risk*! This was tested with Debian 4.14.13-1kali1**\
The script will make a backup, but make sure you make one as well in any case.\
If you use multiple monitors, you might want to learn css and do this manually.\
Feel free to improve it and open a pull request.

## Dependencies
 - libalglib-dev
 
## References
 This script was created with snippets of code from [ArchWiki](https://wiki.archlinux.org/index.php/GDM#Log-in_screen_background_image).
## How does it work?

  - It unpacks the /usr/share/gnome-shell/gnome-shell-theme.gresource.
  - It adds the new background to the css and xml files contained in the gresource.
  - It compiles the gresource.
  - It makes a backup of the original gresource and replaces it with the newly created one.


## Usage
Please use .jpg files, it would make everything much more easyer

    chmod x changeTheme.sh
    ./changeTheme.sh
    
## *FAQ*
**Why it asks me for 'sudo'?** \
 Well, we need to change stuff in /usr/share/gnome-shell/ and we need root privileges to use `cp` and `mv` there.

**My distro uses gdm3 but the script dosen't work.**\
 Technically not a question, but open the script and change the variables so that they match your distro.\
 The variables you need to change are `backgroundString` and `gst`.

**`x.svg` was not found.**\
I can't do anything about that, my solution is to make your own svg file with the name specified that it dosen't exist and paste it in shell-theme/theme folder.\
And while inside shell-theme/theme manually running:

    glib-compile-resources gnome-shell-theme.gresource.xml
    sudo cp gnome-shell-theme.gresource /usr/share/gnome-shell/gnome-shell-theme.gresource
