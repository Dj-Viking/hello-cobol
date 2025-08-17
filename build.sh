set -e

FILENAME=hello

# clean up
if ! [ -z "./build/$FILENAME"]; then
	rm "./build/$FILENAME";
fi

# make build dir if not exist
if ! [ -d "build" ]; then
	mkdir build;
	pushd build;
else 
	pushd build;
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
