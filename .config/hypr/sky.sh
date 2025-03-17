response=$(curl -s "http://ip-api.com/json")

# Parse the city and region from the JSON response
city=$(echo $response | jq -r '.city')

echo $(curl "wttr.in/$city?format=%c+%C")
