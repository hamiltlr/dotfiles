#!/bin/bash
##################################################
# freshtomato_update.sh
#  This script checks for an update to FreshTomato and sends an alert to
#  a Discord webhook if it finds a newer version.
#
# NOTE: Before running this, change SAVE_FILE and WEBHOOK_URL, and remove the exit 99 at the beginning
##################################################

exit 99
#^^^^^^ remove this!

SAVE_FILE="/path/to/file"

function main {
    # Get the latest version from freshtomato.org
    LATEST_VERSION=$(curl -s https://freshtomato.org/version.txt)

    # Get the version we saved last time this was run
    if ! [[ -f $SAVE_FILE ]]; then
        # If this is the first run, set up the saved file
        echo $LATEST_VERSION > $SAVE_FILE
        SAVED_VERSION="$LATEST_VERSION"
    else
        SAVED_VERSION=$(<$SAVE_FILE)
    fi

    
    # Check that they're both valid version strings
    # This is just a sanity check so that we don't potentially pass bad data into the Discord request JSON
    check_valid_version "$LATEST_VERSION"
    check_valid_version "$SAVED_VERSION"

    # Compare them to see if there's a new version
    if [[ $LATEST_VERSION > $SAVED_VERSION ]]; then
        echo New version released!

        # Update our saved version file
        echo $LATEST_VERSION > $SAVE_FILE
        
        # Send an alert on discord
        notify_discord "$SAVED_VERSION" "$LATEST_VERSION"
    fi
}

function notify_discord {
    local old_version=${1}
    local new_version=${2}

    local WEBHOOK_URL="https://discord.com/api/webhooks/xxxxx"
    local WEBHOOK_DATA=$(cat <<EOF
        {
            "content": "New FreshTomato version $new_version available! Old version is $old_version",
            "username": "FreshTomato Update Checker"
        }
EOF
)

    echo "$WEBHOOK_DATA"
    curl --request POST "$WEBHOOK_URL" --header "Content-type: application/json" --data "$WEBHOOK_DATA"
}

function check_valid_version {
    local version=${1}
    if ! [[ $version =~ ^\s*[0-9]+\.[0-9]+\s*$ ]]; then
        echo "Invalid version string '$version', bailing out"
        exit 1
    fi
}

main
