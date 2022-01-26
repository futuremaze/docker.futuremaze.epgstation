#!/bin/bash

mode=$1

if [ "$mode" = "" ]; then
    mode="main"
fi

function getHeight() {
    echo $VIDEORESOLUTION | sed -e "s/[^0-9]//g"
}


# -map 0 -ignore_unknown -max_muxing_queue_size 1024 -sn 
if [ `getHeight` -gt 720 ]; then
    eval `$FFMPEG -dual_mono_mode $mode -i "$INPUT" -c:v h264_omx -b:v 3000k -f mp4 -s 1280x720 -c:a aac -ar 48000 -ab 192k -ac 2 "$OUTPUT"`
else
    eval `$FFMPEG -dual_mono_mode $mode -i "$INPUT" -c:v h264_omx -b:v 1500k -f mp4 -s 720x480 -c:a aac -ar 48000 -ab 128k -ac 2 "$OUTPUT"`
fi
