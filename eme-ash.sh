#!/bin/sh
#
# This version works in the ASH shell provided by busybox

metadataroot=http://169.254.169.254/latest

function walk(){
  root=$1 # Takes the next path to 'walk' via wget

  sublisting=$(wget -O- -q $root)

  for li in $sublisting; do
    if [[ "$li" == */  ]]; then
      walk "$root$li"
    else
      printout "$li" "$root"
    fi
  done  
}

function printout() {
  entry=$1        # entry name
  pathprefix=$2   # Shows where this item lives in the metadata tree

  entrydetails=$(wget -O- -q $pathprefix$entry)

  echo ""
  echo ""
  echo -e "\033[1m$pathprefix$entry:\033[0m"
  echo "$entrydetails"
}

walk "$metadataroot/"
walk "$metadataroot/meta-data/"
walk "$metadatarooti/dynamic/"
walk "$metadatarooti/user-data/"
