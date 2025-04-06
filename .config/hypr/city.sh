#!/bin/bash

# Make the API request to ip-api.com
response=$(curl -s "http://ip-api.com/json")

# Parse the city and region from the JSON response
city=$(echo $response | jq -r '.city')
country=$(echo $response | jq -r '.country'| awk '{print toupper($0)}')


# Capitalize the city name
#
location=$(echo "$country, $city")

# Output the capitalized city name
echo $location
