#!/bin/bash

mkdir -p tmp
mkdir -p $1  # place to put output

while read p; do
  echo $p
  #fn=$(echo $p | sed 's/https:\/\/content.guardianapis.com\///g' | sed 's/\//-/g')
  curl -s $p\?api-key\=${GU_API_KEY}\&show-blocks\=all > ./tmp/current_content.json
  id=$(jq -r '.response.content.blocks.body[0].id' <./tmp/current_content.json)
  echo '-->' $id
  jq -r '{id: .response.content.id, bodyId:.response.content.blocks.body[0].id,bodyTextSummary:.response.content.blocks.body[0].bodyTextSummary,publishedDate:.response.content.blocks.body[0].publishedDate,lastModifiedDate:.response.content.blocks.body[0].lastModifiedDate}' > $1/$id.json <./tmp/current_content.json
done < /dev/stdin