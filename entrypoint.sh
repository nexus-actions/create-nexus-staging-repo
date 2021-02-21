#!/bin/sh -l

if [ -z $INPUT_BASE_URL ]
then
  INPUT_BASE_URL="https://oss.sonatype.org/service/local/"
fi

STAGING_PROFILE_ID=$1

JSON=$(curl -d "{\"data\": {\"description\": \"$INPUT_DESCRIPTION\"}}" -u "$INPUT_USERNAME":"$INPUT_PASSWORD" ${INPUT_BASE_URL}staging/profiles/${STAGING_PROFILE_ID}/start  -H "Content-Type: application/json")

# TODO proper json parsing 😅
REPOSITORY_ID=$(echo $JSON | sed 's/.*stagedRepositoryId":"\([^"]*\)".*/\1/g')

echo "::set-output name=repository-id::$REPOSITORY_ID"