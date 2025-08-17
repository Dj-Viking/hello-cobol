set -e
# set -xe

FILENAME=math

# clean up
if [ -d "./dist" ]; then
	if ! [ -z "./dist/$FILENAME" ]; then
		rm "./dist/$FILENAME";
	fi
fi

# make dist dir if not exist
if ! [ -d "dist" ]; then
	mkdir dist;
	pushd dist;
else 
	pushd dist;
fi 

#compile and run
cobc -x "../$FILENAME.cob" \
	&& echo "" \
	&& echo "running..." \
	&& echo "" \
	&& "./$FILENAME" \
	&& echo "" \
	&& echo "done..." \
	&& echo ""; 

popd
