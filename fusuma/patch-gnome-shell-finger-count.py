#!/usr/bin/env python3
# Since GNOME 47, 4-finger gestures are mapped to the same standard
# GNOME gestures as 3-finger gestures. See
# https://gitlab.gnome.org/GNOME/gnome-shell/-/merge_requests/3275.
#
# This script patches gnome-shell to disable 3-finger gestures and only
# enable 4-finger gestures for standard GNOME, so you can assign
# 3-finger gestures to your own custom actions (e.g. using
# libinput-gestures). Simply run this as sudo/root then log out and back
# in, or restart. You will have to run it again if gnome-shell is
# updated.
#
# sudo python3 patch-gnome-shell-finger-count.py
#
# Get the latest version of this script at
# https://gist.github.com/bulletmark/0630478f98363adf584bbcfe8e527cb1.
#
# M.Blakeney, Sep 2024.
import sys
from pathlib import Path

BASEDIR = Path('/usr/lib/gnome-shell/')
files = sorted(BASEDIR.glob('libshell-*.so'))
if not files:
    sys.exit(f'ERROR: gnome-shell library not found at {BASEDIR}.')

with files[-1].open('r+b') as fp:
    content = fp.read()
    new_content = content.replace(b'GESTURE_FINGER_COUNT = 3',
                                  b'GESTURE_FINGER_COUNT = 4')
    if new_content != content:
        fp.seek(0)
        fp.write(new_content)
        print('Patched successfully. Now restart gnome-shell.')
    else:
        print('Already patched.')