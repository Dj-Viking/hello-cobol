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
	
- I had to change ltversion.m4 file 'macro_version' to 2.5.3
or whatever version the build error said that it wanted to build libtool with.

# build and run
```sh
sh build.sh
```
