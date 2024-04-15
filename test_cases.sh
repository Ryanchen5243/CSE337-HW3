#!/bin/bash

touch input.txt

# Prog 1 test cases

init_prog1_dir(){
  mkdir -p project project/subProj1 project/subProj1/subsubProj1 project/subProj2
  touch project/file1.c project/file1.o project/file2.c project/file2.o \
  project/subProj1/file3.c project/subProj1/file3.o project/subProj1/file4.c project/subProj1/file4.o \
  project/subProj1/file5.c project/subProj1/file5.o project/subProj1/file6.c project/subProj1/file6.o \
  project/subProj1/subsubProj1/file7.c project/subProj1/subsubProj1/file7.o \
  project/subProj2/file8.c project/subProj2/file8.o project/subProj2/file9.c project/subProj2/file9.o \
  project/subProj2/file10.c project/subProj2/file10.o project/subProj2/file11.c project/subProj2/file11.o
}

prog1_setup(){
  if [[ ! -d "project" ]]; then
    init_prog1_dir
  else
    # reset directory
    rm -rf "project"
    init_prog1_dir
  fi
  # reset destination folder
  if [[ -d "project_src_bkup" ]]; then
    rm -rf "project_src_bkup"
  fi
}

prog1_setup
./prog1.sh > output_capture.txt
if diff output_capture.txt <(echo -e "src and dest dirs missing");then
  echo "Prog 1 test_case 1/4 passed"
else
  echo "Prog 1 test_case 1/4 failed"
fi

prog1_setup
./prog1.sh project > output_capture.txt
if diff output_capture.txt <(echo -e "src and dest dirs missing");then
  echo "Prog 1 test_case 2/4 passed"
else
  echo "Prog 1 test_case 2/4 failed"
fi

prog1_setup
./prog1.sh project_src_bkup > output_capture.txt
if diff output_capture.txt <(echo -e "src and dest dirs missing");then
  echo "Prog 1 test_case 3/4 passed"
else
  echo "Prog 1 test_case 3/4 failed"
fi

prog1_setup
./prog1.sh non_existent_source_dir project_src_bkup > output_capture.txt
if [ $? -eq 0 ] && diff output_capture.txt <(echo -e "non_existent_source_dir not found");then
  echo "Prog 1 test_case 4/4 passed"
else
  echo "Prog 1 test_case 4/4 failed"
fi

prog1_setup

# end prog 1 test cases


# prog 2 test cases
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

./prog3.sh non_existent_input_file.txt > output_capture.txt

if diff output_capture.txt <(echo -e "missing data file");then
  echo "Prog 3 test_case 1/7 passed"
else
  echo "Prog 3 test_case 1/7 failed"
fi

./prog3.sh 1 2 3 > output_capture.txt
if diff output_capture.txt <(echo -e "missing data file");then
  echo "Prog 3 test_case 2/7 passed"
else
  echo "Prog 3 test_case 2/7 failed"
fi

./prog3.sh > output_capture.txt
if diff output_capture.txt <(echo -e "missing data file");then
  echo "Prog 3 test_case 3/7 passed"
else
  echo "Prog 3 test_case 3/7 failed"
fi

./prog3.sh input.txt 1 2 3 4 5 > output_capture.txt
if diff output_capture.txt <(echo -e "5");then
  echo "Prog 3 test_case 4/7 passed"
else
  echo "Prog 3 test_case 4/7 failed"
fi

./prog3.sh input.txt > output_capture.txt
if diff output_capture.txt <(echo -e "6");then
  echo "Prog 3 test_case 5/7 passed"
else
  echo "Prog 3 test_case 5/7 failed"
fi

./prog3.sh input.txt 1 2 3 > output_capture.txt
if diff output_capture.txt <(echo -e "6");then
  echo "Prog 3 test_case 6/7 passed"
else
  echo "Prog 3 test_case 6/7 failed"
fi


./prog3.sh input.txt 1 2 3 4 5 9 10 > output_capture.txt

if diff output_capture.txt <(echo -e "5");then
  echo "Prog 3 test_case 7/7 passed"
else
  echo "Prog 3 test_case 7/7 failed"
fi

# end prog 3
>input.txt
# start prog 4

echo "----------------------------"

./prog4.sh > output_capture.txt
if diff output_capture.txt <(echo "score directory missing");then
  echo "Prog 4 test_case 1/3 passed"
else
  echo "Prog 4 test_case 1/3 failed"
fi

./prog4.sh invalid_dir_name > output_capture.txt
if diff output_capture.txt <(echo "invalid_dir_name is not a directory");then
  echo "Prog 4 test_case 2/3 passed"
else
  echo "Prog 4 test_case 2/3 failed"
fi

./prog4.sh data > output_capture.txt
if diff output_capture.txt <(echo -e "101:C\n102:A\n103:D\n101:A"); then
  echo "Prog 4 test_case 3/3 passed"
else
  echo "Prog 4 test_case 3/3 failed"
fi

# end prog 4 test cases

# start prog 5 test cases

