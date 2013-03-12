#!/bin/zsh
shorturl=$(curl -s --data "login=lightningdb&apiKey=$BITLY_API_KEY&longUrl=$1&format=txt" http://api.bitly.com/v3/shorten)
echo "$shorturl" | pbcopy
