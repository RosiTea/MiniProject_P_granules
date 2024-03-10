#!/bin/bash

# The header row to be added
header_row="Location,Name,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30"

for file in *.csv; do
 
    # Create a new file starting with the header row
    echo "$header_row" > temp.csv

    # Use awk to remove the last column from each file and append the result to temp.csv
    awk -F, 'BEGIN{OFS=","}{NF--; print}' "$file" >> temp.csv

    # Replace the original file with the modified one
    mv temp.csv "$file"

done

echo "CSV files have been processed."
