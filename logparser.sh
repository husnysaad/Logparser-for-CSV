#!/bin/bash

#name : husny saad
#student id : 10687033



# check if two arguments are provided
if [ "$#" -ne 2 ]; then #if not equal to 2 arguements then execute the echo
    echo "error: invalid number of arguments. please name the raw input file first followed by the filename you wish to create like so : ./logparser.sh raw.csv processed.csv"
    exit 1
fi

# input and output file names from arguments
input_file="$1" #input raw file
output_file="$2" #output processed file




# check if input file exists
if [ ! -f "$input_file" ]; then #if the input file doesnt exist then execute the echo
    echo "error:input file '$input_file' not found."
    exit 2
fi

#check if input file exists
if [ ! -r "$input_file" ]; then #if the input file is not readable then execute the echo
    echo "error:input file '$input_file' is not readable"
    exit 3
fi

# check if input and output files are CSV files by checking if the file names end with '.csv'
if [[ "$input_file" != *.csv ]]; then #if the input filename is not equal csv at the end
    echo "error:input file '$input_file' is not a CSV file."
    exit 4
fi

if [[ "$output_file" != *.csv ]]; then #if the output filename is not equal csv at the end
    echo "error:output file '$output_file' is not a CSV file."
    exit 5
fi

# display processing message
echo "Processing..."

# add headers to the output CSV
echo "IP,Date,Method,URL,Protocol,Status" > "$output_file"

# start from the second line of the file
tail -n +2 "$input_file" | while IFS=',' read -r ip date request status; do #seperate based on the comma and reads the line while splitting the variables
    #request variable is needed to fill in the method, url and protocol
    method=$(echo "$request" | awk '{print $1}') # print the first field from the request variable to method like GET or POST
    url=$(echo "$request" | awk '{print $2}') # print the second field from the request variable to url 
    protocol=$(echo "$request" | awk '{print $3}') # print the first field from the request variable to protocol like HTTP/1.1

    # write the values into the output file
    echo "$ip,$date,$method,$url,$protocol,$status" >> "$output_file"
done

# show the number of records processed
processed_count=$(wc -l < "$output_file")
# subtract 1 for the header line

echo "total records processed: $processed_count"

# exit successfully
exit 0
