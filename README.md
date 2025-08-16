# dependencies
	- cobc: gnucobol compiler

	- NOTE: on my arch linux pc I had to change ltversion.m4 file
	after running:

```sh
     test -f configure || ./bootstrap
     ./configure
     make
     make install
```

	to change the macro version of libtool library to 2.5.3
	in order for the make commands to work and be able to compile

# build and run
```sh
sh build.sh
```
