#!/bin/bash

curl -s https://content.guardianapis.com/search\?section\=environment\&api-key\=${GU_API_KEY}\&page\=1\&page-size\=100 > tmp/current-search-result.json
pages=$(jq -r '.response.pages' <tmp/current-search-result.json)
for page in $(seq 1 "$pages")
do
	curl -s https://content.guardianapis.com/search\?section\=environment\&api-key\=${GU_API_KEY}\&page\-size=100\&page\=${page} > tmp/current-search-result.json
	jq -r '.response.results | .[].apiUrl' <tmp/current-search-result.json >>environment_urls.csv
	echo ${page}
done

