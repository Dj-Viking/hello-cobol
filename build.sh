set -xe

FILENAME=hello

# clean up
if [ -z "./$FILENAME" ]; then 
	rm "$FILENAME"
fi 

cobc -x "$FILENAME.cob" && "./$FILENAME"

