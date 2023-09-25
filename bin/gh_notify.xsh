#!/usr/bin/env xonsh

resp = $(gh api \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /notifications)
  
comment = $(@(lambda: print(resp)) | jq -c '.[] | select ( .reason | contains("comment"))' | wc -l).strip() or "0"
author = $(@(lambda: print(resp)) | jq -c '.[] | select ( .reason | contains("author"))' | wc -l).strip() or "0"
mention = $(@(lambda: print(resp)) | jq -c '.[] | select ( .reason | contains("mention"))' | wc -l).strip() or "0"
subscribed = $(@(lambda: print(resp)) | jq -c '.[] | select ( .reason | contains("subscribed"))' | wc -l).strip() or "0"

echo @(f"A: {author} C: {comment} M: {mention} S: {subscribed}")
