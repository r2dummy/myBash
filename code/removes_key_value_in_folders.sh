#!/bin/bash

#$1 - Path_to_file_with_key_value_string
#$2 - Path_to_folder_where_need_change
#--------------------
# Example of file:
# key value
# key1 value1
# key2 value2
#--------------------

rm -rf /tmp/lists_of_files.txt
for file in $2
  do
    find $file -type f >> /tmp/lists_of_files.txt
done

 declare -A main_file
 while read line; do
  key=$(echo $line | cut -d " " -f1)
  data=$(echo $line | cut -d " " -f2)
  main_file[$key]=$data
 done < $1

  for each_file in $(cat /tmp/lists_of_files.txt )
    do
    echo "Working with $each_file file now"
      for i in "${!main_file[@]}"
        do
          search=$i
          replace=${main_file[$i]}
          sed -i "/^${search} /s/[[:blank:]].*$/ ${replace}/" $each_file
      done
  done
