#!/usr/bin/env bash
function get_volume {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ print int($2 * 100) }'
}

function send_notification {
    volume=$(get_volume)
    volume=${volume:-0}  # Default to 0 if empty
    $(dirname "$0")/notify-send.sh "Volume $volume%" -t 2000 -h int:value:"$volume" --replace=555
}

case $1 in
    up)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+
        send_notification
        ;;

    down)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-
        send_notification
        ;;

    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED; then
            $(dirname "$0")/notify-send.sh "Muted" -t 2000 --replace=555
        else
            send_notification
        fi
        ;;
esac