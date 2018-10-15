#!/bin/sh
# Licensed for use under Apache 2.0
#
# ec2 metadata extractor (eme.sh) for almquist shell (ASH)
#   v0.2
#
# This version works in the ASH shell provided by busybox
#
#   To disable 'bolded' output headers, pass in the '-noformat' flag
#

if [ $1 == "-noformat" ]; then
  outputformatting=false
else
  outputformatting=true
fi


metadataroot=http://169.254.169.254/latest
function walk(){
  local root=$1 # Takes the next path to 'walk' via wget
  #echo "DEBUG: WALK: wgetting: $root"
  sublisting=$(wget -O- -q $root 2>/dev/null)
  sublisting="$sublisting
"
  #echo "==DEBUG: start sublisting=="
  #echo "$sublisting"
  #echo "==DEBUG: done sublisting=="
  for li in $sublisting; do
    #
    # [[ "${li: -1}" == "/"  ]] is a little more explicit about checking if the last character is a slash
    #
    if [[ "${li: -1}" == "/"  ]]; then
      #echo "DEBUG: WALK: enumerating $root$li"
      walk "$root$li"
    else
      printout "$li" "$root"
    fi
  done
}
function printout() {
  local entry=$1        # entry name
  local pathprefix=$2   # Shows where this item lives in the metadata tree
  #echo "DEBUG: PRINT: wgetting details: $pathprefix$entry"
  entrydetails=$(wget -O- -q $pathprefix$entry 2>/dev/null)
  echo ""
  echo ""
  if [[ "$outputformatting" == "true" ]]; then
    echo -e "\033[1m$pathprefix$entry:\033[0m"
  else
    # No formatting
    echo -e "$pathprefix$entry:"
  fi
  echo "$entrydetails"
}

#walk "$metadataroot/"              # Doesn't work since amazon 'conveniently' leaves out the trailing slashes
walk "$metadataroot/meta-data/"
walk "$metadataroot/dynamic/"
walk "$metadataroot/user-data"
