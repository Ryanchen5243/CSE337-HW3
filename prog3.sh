#!/bin/bash

# check for valid input file
if [[ (! -e $1) || ($# -eq 0) ]]; then 
  echo "missing data file"
  exit 1
fi

# array of command line args
cmd_line_args=("$@") # array
weights=${cmd_line_args[@]:1} # extract weights

awk -F[,] -v cmd_weights="$weights" '
BEGIN {
  # extract weights
  split(cmd_weights,weights," ")

  numWeights = 0
  for (w in weights){ 
    numWeights += 1 
  }

}



# skip header record
NR > 1 {

  # per student calculations
  student_weighted_avg = 0
  sum_weights = 0
  total_num_students += 1

  # loop through record, skipping id
  for (i = 2; i <= NF; i++){
    question_weight = (length(weights[i-1]) > 0) ? weights[i-1] : 1
    # print $i " has weight " question_weight
    student_weighted_avg += ($i * question_weight)
    sum_weights += question_weight
  }
  student_weighted_avg = student_weighted_avg / sum_weights
  all_students_sum_scores += student_weighted_avg
  
}

END {
  # take average of all weighted scores across all students
  result = all_students_sum_scores / total_num_students
  printf "%d\n", result
}

' "$1"