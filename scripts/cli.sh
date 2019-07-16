#!/bin/bash

# Outputs the contetns for content/reference/api/cli.md from the locally installed go-ipfs

echo "*Generated on $(date +"%Y-%m-%d %T"), from go-ipfs $(ipfs version -n).*"
printf "\n"
ipfs commands | while read line ; do
  echo "- [$line](#$(echo $line | tr -s ' ' -))"
done
printf "\n"
ipfs commands | while read line ; do
  printf "## $line\n\n\`\`\`\n"
  $line --help
  printf "\`\`\`\n\n"
done
