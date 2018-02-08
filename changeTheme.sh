#!/bin/bash

# Dependencies:
# * libalglib-dev

# Set the variables

printf 'Enter the path to the background you want: '
read -r imagedir
workdir=$PWD/shell-theme
backgroundString="resource:///org/gnome/shell/theme/background.jpg"
gst=/usr/share/gnome-shell/gnome-shell-theme.gresource

# Code from GDM page from ArchLinux
if [ ! -d ${workdir}/theme ]; then
    mkdir -p ${workdir}/theme/icons
fi

for r in `gresource list $gst`; do
    gresource extract $gst $r >$workdir/${r#\/org\/gnome\/shell/}
done

cd $workdir
#  Copy the image in the new folder
cp $imagedir theme/
cd theme
# New xml with the background

echo "<?xml version="1.0" encoding="UTF-8"?>
<gresources>
  <gresource prefix=\"/org/gnome/shell/theme\">
    <file>calendar-arrow-left.svg</file>
    <file>calendar-arrow-right.svg</file>
    <file>calendar-today.svg</file>
    <file>checkbox-focused.svg</file>
    <file>checkbox-off-focused.svg</file>
    <file>checkbox-off.svg</file>
    <file>checkbox.svg</file>
    <file>close-window-active.svg</file>
    <file>close-window-hover.svg</file>
    <file>close-window.svg</file>
    <file>close.svg</file>		
    <file>corner-ripple-ltr.png</file>
    <file>corner-ripple-rtl.png</file>
    <file>dash-placeholder.svg</file>
    <file>filter-selected-ltr.svg</file>
    <file>filter-selected-rtl.svg</file>		
    <file>gnome-shell-high-contrast.css</file>
    <file>gnome-shell.css</file>
    <file>icons/message-indicator-symbolic.svg</file>
    <file>logged-in-indicator.svg</file>
    <file>no-events.svg</file>
    <file>no-notifications.svg</file>
    <file>${imagedir##*/}</file>
    <file>pad-osd.css</file>
    <file>page-indicator-active.svg</file>		
    <file>page-indicator-checked.svg</file>
    <file>page-indicator-hover.svg</file>
    <file>page-indicator-inactive.svg</file>
    <file>process-working.svg</file>
    <file>running-indicator.svg</file>
    <file>source-button-border.svg</file>
    <file>summary-counter.svg</file>
    <file>toggle-off-hc.svg</file>
    <file>toggle-off-intl.svg</file>
    <file>toggle-off-us.svg</file>		
    <file>toggle-on-hc.svg</file>		
    <file>toggle-on-intl.svg</file>
    <file>toggle-on-us.svg</file>		
    <file>ws-switch-arrow-down.png</file>
    <file>ws-switch-arrow-up.png</file>
  </gresource>
</gresources>" >> gnome-shell-theme.gresource.xml

# replace the uri from the file with a new one
sedcommand="s#$backgroundString#$imagedir#g"
sed -i "${sedcommand}" gnome-shell.css

# Compile the resource
glib-compile-resources gnome-shell-theme.gresource.xml

# Make a backup of the original theme
if [ ! -f $gst.bak ]; then
  sudo mv $gst $gst.bak

# Copy the new theme to the location
sudo cp gnome-shell-theme.gresource $gst

printf "The background is now active, all you need to do is reboot\n"
printf "Script made by \"-C\""
