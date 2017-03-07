#!/bin/bash

. $(dirname $0)/lemonbar_config

PANEL_FIFO="/tmp/i3_lemonbar_${USER}"

if [ $(pgrep -cx $(basename $0)) -gt 1 ] ; then
    printf "%s\n" "The status bar is already running." >&2
    exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "${PANEL_FIFO}" ] && rm "${PANEL_FIFO}"
mkfifo "${PANEL_FIFO}"

$(dirname $0)/i3_workspaces.py > "${PANEL_FIFO}" &

while :; do
    echo "VOL$(amixer get Master | awk -F"[]%[]" '/%/ { sum += $2; n++ } END { if (n > 0) print sum/n;}')"
    sleep 1
done > $PANEL_FIFO &

while :; do
    echo "DATE$(date +"%A, %d %B %Y")"
    echo "TIME$(date +"%R")"
    sleep 5
done > $PANEL_FIFO &

while :; do
    echo "SSID$(iw dev ${DEVICE} link | grep SSID | awk '{print $2}')"
    sleep 5
done > $PANEL_FIFO &

cat "${PANEL_FIFO}" | $(dirname $0)/lemonbar_parser.sh | lemonbar -g ${BAR_LENGTH}x${BAR_HEIGHT}+${H_GAP}+${V_GAP} -d -f "${FONT1}" -f "${FONT2}" | sh

