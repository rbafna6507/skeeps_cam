#!/bin/bash

WEBSITE_DIR="/home/rbafna/skeeps"
HTML_FILE="$WEBSITE_DIR/templates/index.html"

rpicam-jpeg -o ricks.jpg
mv ricks.jpg "${WEBSITE_DIR}/static/ricks.jpg"

current_time=$(TZ="EST5EDT" date +"%r")

update_timestamp() {
    local cam_name=$1
    local image_file="${cam_name}.jpg"
    # The text pattern we are looking for in the HTML file
    local search_pattern="<h4>${cam_name} cam updated at:"
    # The new HTML line we want to insert or update to
    local new_line="<h4>${cam_name} cam updated at: ${current_time}</h4>"

    # Check if the "updated at" line already exists for this cam
    if grep -q "${search_pattern}" "$HTML_FILE"; then
        # If it exists, replace the whole line using sed's substitute command 's'
        sed -i "s|${search_pattern}.*</h4>|${new_line}|" "$HTML_FILE"
    else
        # If it doesn't exist, add it right after the corresponding image tag
        sed -i "/${image_file}/a ${new_line}" "$HTML_FILE"
    fi
}

update_timestamp "ricks"