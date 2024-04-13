#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "data file or output file not found"
  exit 1
fi

data_file=$1
output_file=$2

# if input file not found
if [ ! -e $data_file ]; then
  echo "$data_file not found"
  exit 1
fi

awk -F'[;:,]' '
{
  if (NF > maxNF) { maxNF = NF} # keep track of max num fields
  for(i=1;i<=NF;i++) {
    sum[i] += $i
  }
}

END {
  for (i = 1; i <= maxNF; i++){
    print "Col " i " : " sum[i]
  }
}
' $data_file > $output_file