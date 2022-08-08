#!/bin/sh
set -eu

if test -z "$SLACK_BOT_TOKEN"; then
  echo "Set the SLACK_BOT_TOKEN secret."
  exit 1
fi

DATA=$(cat <<-END
    {
      "channel": "$SLACK_CHANNEL_TOKEN",
      "blocks": [{
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": ":android: *NEW ANDROID PULL REQUEST*\n published by *$PR_AUTHOR*\n\n <$PR_LINK|*$PR_TITLE*>\n status: *$PR_STATE*"
        }
      },
        {
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": "<$PR_LINK|View Pull Request>"
        }
      }] 
    }
END
)

curl -X POST \
     -H "Content-type: application/json; charset=utf-8" \
     -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
     -d "$DATA" \
     https://slack.com/api/chat.postMessage