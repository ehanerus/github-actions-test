#!/bin/sh
set -eu

if test -z "$SLACK_BOT_TOKEN"; then
  echo "Set the SLACK_BOT_TOKEN secret."
  exit 1
fi

REVIEW_DATA=$(cat <<-END
    {
      "channel": "$SLACK_CHANNEL_TOKEN",
      "blocks": [{
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": "Your review has been requested by *$PR_AUTHOR* for <$PR_LINK|*$PR_TITLE*>"
        }  
      }] 
    }
END
)

curl -X POST \
     -H "Content-type: application/json; charset=utf-8" \
     -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
     -d "$REVIEW_DATA" \
     https://slack.com/api/chat.postMessage