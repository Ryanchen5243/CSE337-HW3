#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "src and dest dirs missing"
  exit 1
fi

original_dir=$1
destination_dir=$2

# check source directory exists
if [[ ! -d $original_dir ]]; then 
  echo "$original_dir not found"
  exit 0
fi

# if dest dir exist don't recreate, else init
if [[ ! -d $destination_dir ]]; then 
  mkdir -p $destination_dir
fi

countNumberCFiles(){
  # input is directory
  res=$(find $1 -maxdepth 1 -type f -name "*.c" | wc -l)
  return $res
}


sleep 2

# the main function
move_src_files(){
  source_dir=$1
  destination_dir=$2

  # get c files at current level
  countNumberCFiles $source_dir
  numOfCFiles=$?
  c_files=$(find "$source_dir" -maxdepth 1 -type f -name "*.c")
  should_move=0 # true initially

  # confirm move of all c files
  if [[ $numOfCFiles -ge 3 ]]; then 
    for file in $c_files; do 
      echo $file
    done
    read -p "Confirm transfer (y/n)?" confirm
    if [[ ! ($confirm == "y" || $confirm == "Y") ]]; then 
      echo "Transfer cancelled for $source_dir\n"
      should_move=1
    fi
  fi
  
  # perform src files move
  for content in $source_dir/*; do
    if [[ -f $content && $should_move -eq 0 ]]; then 
      extension="${content##*.}"
      # move only c files
      if [[ $extension == "c" ]]; then
        # echo "Moving > $content"
        # remove src file from original
        rm $content
        # add src file to destination
        destination_path=${content//$original_dir/$destination_dir}
        # echo "The destination path is $destination_path"
        # add file to dest
        touch $destination_path
      fi
    elif [[ -d $content ]]; then 
      newDestDir=${content//$original_dir/$destination_dir}
      mkdir -p $newDestDir
      move_src_files $content $destination_dir
    fi
  done
}

move_src_files $original_dir $destination_dir
