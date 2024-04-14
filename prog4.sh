#!/bin/bash

directory_name="$1"

# check one argument only
if [[ $# -ne 1 ]]; then 
  echo "score directory missing"
  exit 1
fi

# check valid directory
if [[ ! -d $directory_name ]]; then 
  echo "$directory_name is not a directory"
  exit 1
fi

calculate_grade() {
  student_id=$1
  raw_grade=$2

  # 5 questions, 10 points each
  max_points=50
  percentage=$(awk -v n1="$raw_grade" -v n2="$max_points" 'BEGIN{ print (n1 * 100)/ n2 }')
  
  # # calculate letter grade
  if [[ $percentage -ge 93 ]]; then
    echo "$student_id:A"
  elif [[ $percentage -ge 80 ]]; then 
    echo "$student_id:B"
  elif [[ $percentage -ge 65 ]]; then 
    echo "$student_id:C"
  else
    echo "$student_id:D"
  fi
}

dir_files_list=$(ls $directory_name)
for file in $dir_files_list; do
  result=$(awk -F[,] '
  NR>1{
    # printf "NR = %d\n%s\n", NR, $0
    # printf "Num fields... %d\n", NF
    student_id = $1

    # iterate through scores
    for (i=2; i<=NF; i++) {
      score += $i
    }
  }
  END {
    printf "%d,%d",student_id,score
  }
  ' "$directory_name/$file")

  # extract student id, score using cut command
  student_id=$(echo $result | cut -d ',' -f 1)
  student_score=$(echo $result | cut -d ',' -f 2)

  calculate_grade $student_id $student_score
  

done