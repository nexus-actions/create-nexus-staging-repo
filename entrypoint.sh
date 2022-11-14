#!/bin/sh -l
# inspired by https://gist.github.com/romainbsl/4ab6d8c1e92d3f916eaacf77eb27e361

jsonOutput=$(
  curl -s --request POST -u "$INPUT_USERNAME:$INPUT_PASSWORD" \
    --url ${INPUT_BASE_URL}staging/profiles/"${INPUT_STAGING_PROFILE_ID}"/start \
    --header 'Accept: application/json' \
    --header 'Content-Type: application/json' \
    --data '{ "data": {"description" : "'"$INPUT_DESCRIPTION"'"} }'
)

stagingRepositoryId=$(echo "$jsonOutput" | jq -r '.data.stagedRepositoryId')

if [ -z "$stagingRepositoryId" ]; then
  echo "Error while creating the staging repository."
  exit 1
else
echo "repository_id=$stagingRepositoryId" >> $GITHUB_OUTPUT
fi
