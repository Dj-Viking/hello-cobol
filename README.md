# Dependencies
- cobc: gnucobol compiler at [github](https://github.com/OCamlPro/gnucobol)

- NOTE: on my arch linux pc I had to change ltversion.m4 file
after running:

```sh
$ test -f configure || ./bootstrap 
$ ./configure
```
	
- I had to change ltversion.m4 file 'macro_version' to 2.5.3
or whatever version the build error said that it wanted to build libtool with.

and then run
```sh
$ make && make install;
```

- set LD_LIBRARY_PATH in your bashrc
```sh
$ echo "export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH" >> ~/.bashrc
```

- resource your bashrc
```sh
source ~/.bashrc
```

# Build and run this project
```sh
sh build.sh
```
