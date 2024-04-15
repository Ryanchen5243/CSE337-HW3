#!/bin/bash

# check for input validation

if [[ $# -ne 2 ]]; then
  echo "input file and dictionary missing"
  exit 1
fi

input_file=$1
dictionary_file=$2

if [[ ! -f $input_file ]]; then 
  echo "$input_file is not a file"
  exit 1
fi

if [[ ! -f $dictionary_file ]]; then 
  echo "$dictionary_file is not a file"
  exit 1
fi 

# store dictionary file as string
all_words=$(<"$dictionary_file")

awk -v dict="$all_words" '
BEGIN {
  split(dict,new_dict,"\n")
}

{
  for (i=1; i<=NF; i++) {
    # printf "%s is of len %d\n", $i, length($i)
    # remove puncuation
    gsub(/[[:punct:]]/,"",$i)
    # print $i
    
    if (length($i) == 4){
      found = 0
      # perform checking
      # print "checking %s",$i
      for(j in new_dict){
        if (new_dict[j]==$i){
          # printf "found %s",$i
          found = 1
          break
        }
      }
      if (found == 0){
        print $i
      }
    }
  }
}

' "$input_file"