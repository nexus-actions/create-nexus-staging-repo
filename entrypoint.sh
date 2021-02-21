#!/bin/sh -l
# inspired by https://gist.github.com/romainbsl/4ab6d8c1e92d3f916eaacf77eb27e361

if [ -z $INPUT_BASE_URL ]
then
  INPUT_BASE_URL="https://oss.sonatype.org/service/local/"
fi

jsonOutput=$(
  curl -s --request POST -u "$INPUT_USERNAME:$INPUT_PASSWORD" \
    --url ${INPUT_BASE_URL}staging/profiles/"${STAGING_PROFILE_ID}"/start \
    --header 'Accept: application/json' \
    --header 'Content-Type: application/json' \
    --data '{ "data": {"description" : "'"$INPUT_DESCRIPTION"'"} }'
)

stagedRepositoryId=$(echo "$jsonOutput" | jq -r '.data.stagedRepositoryId')

if [ -z "$stagedRepositoryId" ]; then
  echo "Error while creating the staging repository."
  exit 1
else
  echo "::set-output name=repository-id::$stagedRepositoryId"
fi