#cd Transformations
uname=$(date +'%m-%d-%Y'+"%H:%M")

user_auth=$1

somevar1=$(curl -X POST \
  --url 'https://staging.apimatic.io/api/transformations' \
  -H "$user_auth" \
  -H 'Accept: application/json'\
  -H 'content-type: application/vnd.apimatic.urlTransformDto.v1+json' \
  --data @transform.json | jq '.generatedFile' | sed -e 's/^"//' -e 's/"$//')

echo $somevar1
download_path1="https://staging.apimatic.io/${somevar1}"
echo $download_path1

echo "::set-output name=specurl::$download_path1"







