#!/usr/bin/env bash
set -x
cat $GITHUB_EVENT_PATH
COMMENT=$(jq  -r '.payload.comment.body' "$GITHUB_EVENT_PATH")
if [[ $COMMENT == /label* ]]; then
    LABEL=$(echo $COMMENT | awk '{print $2}')
    LABEL_URL=$(jq -r '.payload.issue.labels_url' "$GITHUB_EVENT_PATH" | sed 's/{\/name}//g')
    curl --header "authorization: Bearer GITHUB_TOKEN" -X POST --data  "{\"labels\": [\"$LABEL\"]}" $LABEL_URL
fi
