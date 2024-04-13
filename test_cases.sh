#!/bin/bash

# prog 2 test cases
touch input.txt
echo -e "1;2;3;4;5\n11:4:23:12\n18,4,17,13,21,19,25" > input.txt

./prog2.sh input.txt output.txt
expected_output="Col 1 : 30\nCol 2 : 10\nCol 3 : 43\nCol 4 : 29\nCol 5 : 26\nCol 6 : 19\nCol 7 : 25"
if diff output.txt <(echo -e $expected_output);then
  echo "Prog 2 test case 1/4 passed"
else
  echo "Prog 2 test case 1/4 failed"
fi

./prog2.sh input.txt > output_capture.txt
if diff output_capture.txt <(echo -e "data file or output file not found");then
  echo "Prog 2 test_case 2/4 passed"
else
  echo "Prog 2 test_case 2/4 failed"
fi

./prog2.sh output.txt > output_capture.txt
if diff output_capture.txt <(echo -e "data file or output file not found");then
  echo "Prog 2 test_case 3/4 passed"
else
  echo "Prog 2 test_case 3/4 failed"
fi

./prog2.sh bad_input.txt output.txt > output_capture.txt
if diff output_capture.txt <(echo -e "bad_input.txt not found");then
  echo "Prog 2 test_case 4/4 passed"
else
  echo "Prog 2 test_case 4/4 failed"
fi

# clear files for next test
>input.txt

# Prog 3 test cases
echo "----------------------------"
echo -e "ID,Q1,Q2,Q3,Q4,Q5\n101,8,6,9,4,4\n102,9,9,9,10,4\n103,5,6,2,4,4\n104,1,2,2,1,4\n105,10,10,10,9,4\n106,10,10,10,10,4\n107,7,7,8,9,4\n108,5,6,5,6,5\n109,10,9,9,4,4" > input.txt

./prog3.sh input.txt




