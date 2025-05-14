#!/bin/bash


type=$1
if [ "${type}" == "out" ]; then
  flag="--list-sinks"
elif [ "${type}" == "in" ]; then
  flag="--list-sources"
fi

pamixer ${flag} |
tail -n +2 |
gawk  -F ' "|" "' 'BEGIN {
  printf "{\n"
}
{
  printf "\t\"%s\": {\n", $1
  printf "\t\t\t\"name\": \"%s,\n", $4
  printf "\t\t\t\"status\": \"%s\"\n", $3
  print "\t},"
}
END {
  printf "}"
}'|
sed -E ':a;N;$!ba;s/},\n}/}\n}/g'|
jaq 'to_entries | map({ id: .key } + .value)'
