
# set -xe

set -e

if [ -z "$1" ]; then
	echo "[ERROR]: missing first arg to script 
	 please provide name of file to compile and run
	 e.g. 'sh build.sh math'"
	exit 1;
fi

FILENAME="$1"

# clean up
if [ -d "./dist" ]; then
	if [ -z "./dist/$FILENAME" ]; then
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
