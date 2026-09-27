#!/bin/bash

WEBSITE_DIR="/home/rbafna/website_v2"
HTML_FILE="$WEBSITE_DIR/skeeps.html"

rpicam-jpeg -o ricks.jpg
mv ricks.jpg "${WEBSITE_DIR}/ricks.jpg"

current_time=$(TZ="EST5EDT" date +"%r")

sed -i "s|^<h4>ricks cam updated at:.*</h4>$|<h4>ricks cam updated at: ${current_time}</h4>|" "$HTML_FILE"

cd "$WEBSITE_DIR"

git add .
git commit -m 'updated cams at ${current_time}'
git push