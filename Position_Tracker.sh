#!/bin/bash
# Jennie's tracker

# oat commands gives list of everything it can do
# oat command --help gives help

# view data, & means runs in background
oat view Raw &

# look at mask overlaid on video to make sure it's ok
oat view Aoi &

oat view Sub &

oat framefilt bsub Raw Sub &

# apply mask to determine area of interest, path to mask file is in config
oat framefilt mask Raw Aoi -c Tracker_config.toml -k mask &


# read file, get data, use settings under [video] in config file (sets frame rate)
oat frameserve file Raw -f ./open_field.mpg -c Tracker_config.toml -k video

