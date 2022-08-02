#!/bin/sh
set -eu

if test -z "$SLACK_BOT_TOKEN"; then
  echo "Set the SLACK_BOT_TOKEN secret."
  exit 1
fi

#grep -rl matchstring somedir/ | xargs sed -i 's/string1/string2/g'
grep -o '"github: "'

curl -X POST \
     -H "Content-type: application/json; charset=utf-8" \
     -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
     -d "$DATA" \
     https://slack.com/api/chat.postMessage