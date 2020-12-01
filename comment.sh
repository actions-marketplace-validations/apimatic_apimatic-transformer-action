#Arguments
user_auth=$1
input=$2
export=$3

echo $input
echo $export

sed 's/^[[:space:]]*//' <<< "$input"
sed 's/^[[:space:]]*//' <<< "$export"

echo $input
echo $export


file=0
FILE=transform.json

if [ -f "$FILE" ]; then
    file=1
else 
    file=-1
fi


if [[ $file -gt 0 ]]
then
  transformedfile=$(curl -X POST \
  --url 'https://www.apimatic.io/api/transformations' \
  -H "$user_auth" \
  -H 'Accept: application/json'\
  -H 'content-type: application/vnd.apimatic.urlTransformDto.v1+json' \
  --data @transform.json | jq '.generatedFile' | sed -e 's/^"//' -e 's/"$//')
else
  transformedfile=$(curl -X POST \
  --url 'https://www.apimatic.io/api/transformations' \
  -H "$trimmed_auth" \
  -H 'Accept: application/json'\
  -H 'content-type: application/vnd.apimatic.urlTransformDto.v1+json' \
  --data '{
  "fileUrl": "'"${trimmed_input}"'",
  "exportFormat": "'"${trimmed_export}"'",
  "codeGenVersion": 1
  }' | jq '.generatedFile' | sed -e 's/^"//' -e 's/"$//')
fi

download_path1="https://www.apimatic.io${transformedfile}"

echo "::set-output name=specurl::$download_path1"







