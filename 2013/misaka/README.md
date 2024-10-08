## To build:

``` <!---sh-->
    make
```

This will build a bunch of versions of the code. See the author's details for
information on all of these builds.


## To use:

``` <!---sh-->
    ./horizontal_cat [files...] > [output]
    ./vertical_cat [files...] > [output]
```


## Try:

To understand the various intermediate source files that are built, try:

``` <!---sh-->
    make understanding
```

Also try:

``` <!---sh-->
    ./try.sh
```

**NOTE**: Use - for standard input.  For example:

``` <!---sh-->
    ./vertical_cat - -
```


## Judges' remarks:

There is more to cat than [mere cats](http://cheezburger.com/1680494336).  Be
they tall, fat, long or squat, this source code is sure to amuse.


#### Slight diversion

While one of the judges was reviewing this entry on the stern of the
[Island Sky](http://www.noble-caledonia.co.uk/information/detail.asp?id=2&spid=76)
in the middle of the Atlantic Ocean waiting for the
[total solar eclipse of 2013](http://en.wikipedia.org/wiki/Solar_eclipse_of_November_3,_2013)
the judge was struck by a
[flying fish](http://en.wikipedia.org/wiki/Flying_fish).
While the result of the impact was that the
[Port](http://en.wikipedia.org/wiki/Port_wine) from Portugal was lost, the
[Grog](https://web.archive.org/web/20130702003043/http://www.travelforpassion.com/grog-factory-cape-verde-santo-antao-cape-verde-1602-photo)
from Cape Verde and the laptop containing this entry was saved.

While I'm sure most [cats](https://rationalwiki.org/wiki/Fun:Cat) would have
preferred otherwise, the flying fish was returned to *swim with the fishes*. :-)
No [cats](https://rationalwiki.org/wiki/Fun:Cat) were harmed in the process of
judging this entry.


## Author's remarks:

### Overview

`Misaka` is a file concatenation utility, with at least two modes of
operation:

``` <!---sh-->
    cc misaka.c -o horizontal_cat
    ./horizontal_cat [files...] > [output]

    ./horizontal_cat misaka.c misaka.c > misaka2.c
    cc misaka2.c -o vertical_cat
    ./vertical_cat [files...] > [output]
```

Where `[files...]` is a list of text file names.  Use `-` to read from `stdin`.


### Details

### Horizontal cat

One of my favorite unix utilities is `cat`.  The best thing about it was that it
was named "[cat](https://rationalwiki.org/wiki/Fun:Cat)".  That, and it's useful
for quickly showing contents of a file.  Though it was primary meant for
concatenating files, that function only seem to work if I wanted to concatenate
files vertically.

I thought the lack of horizontal concatenation must have been an oversight,
so I implemented this utility:

``` <!---sh-->
    cc misaka.c -o horizontal_cat
    ./horizontal_cat files...
```

`horizontal_cat` concatenates files horizontally and write the output to
`stdout`.  Each input file is padded with spaces on the right so that the
original text alignments are preserved.

If `-` is specified as a file name, `horizontal_cat` will read from `stdin`.
Unlike `cat`, `horizontal_cat` loads all input to memory first.  Thus you
can specify `-` multiple times to get `stdin` multiplied horizontally.  For
example, if you have `seq(1)` in your shell, you can add line numbers to both
sides of [misaka.c](%%REPO_URL%%/2013/misaka/misaka.c) like this:

``` <!---sh-->
    seq -f '  %.0f  ' 45 | ./horizontal_cat - misaka.c -
```


### Vertical cat

Because `horizontal_cat` must know the maximum width of all files before
writing any output, all files must be processed at least twice.  To support
`stdin`, file must be buffered to memory.  This lead to the feature that
`horizontal_cat` can be used to duplicate `stdin`.

Seems like the `stdin` doubling feature might be useful even for concatenating
files vertically, so I included a vertical mode.  But supporting vertical
mode with command line options would be no fun.  Instead, vertical mode is
enabled by concatenating the source code horizontally:

``` <!---sh-->
    ./horizontal_cat misaka.c misaka.c > misaka2.c
    gcc misaka2.c -o vertical_cat
    ./vertical_cat files...
```

`vertical_cat` works more or less like `cat`, except you can use
`vertical_cat` to duplicate `stdin`:

``` <!---sh-->
    ./vertical_cat - -
```


### Long cat

After `horizontal_cat` and `vertical_cat`, I thought, maybe all I really wanted
was just more [cats](https://rationalwiki.org/wiki/Fun:Cat).  So I implemented
one more mode, this one is enabled by concatenating [misaka.c](%%REPO_URL%%/2013/misaka/misaka.c)
vertically:

``` <!---sh-->
    ./vertical_cat misaka.c misaka.c > misaka3.c
    gcc misaka3.c -o long_cat
    ./long_cat
```

`long_cat` outputs ASCII art of a cat to `stdout`.  You can make this cat
exponentially longer by concatenating more files vertically (up to 31 levels
high, depending on `sizeof(int)` for your compiler):

``` <!---sh-->
    ./vertical_cat misaka.c misaka.c misaka.c > misaka4.c
    gcc misaka4.c -o loong_cat

    ./vertical_cat misaka.c misaka.c misaka.c misaka.c > misaka5.c
    gcc misaka5.c -o loooong_cat

    ./vertical_cat misaka.c misaka.c misaka.c misaka.c misaka.c > misaka6.c
    gcc misaka6.c -o loooooooong_cat
```

If your terminal has really thin fonts, you can also make this output fatter
by concatenating files horizontally:

``` <!---sh-->
    ./vertical_cat misaka.c misaka.c | ./horizontal_cat - - > misaka7.c
    gcc misaka7.c -o long_fat_cat

    ./vertical_cat misaka.c misaka.c | ./horizontal_cat - - - > misaka8.c
    gcc misaka8.c -o long_faat_cat
```

Output width is determined by the first level of stacked programs, so a
triangle like the following will not have horizontally expanded output:

``` <!---sh-->
    ./horizontal_cat misaka.c misaka.c | ./vertical_cat misaka.c - > misaka9.c
    gcc misaka9.c -o same_as_long_cat
```

Finally, if you lost track of how many [misaka.c](%%REPO_URL%%/2013/misaka/misaka.c) you have stacked
together, you can feed the source to a
[brainfuck](https://en.wikipedia.org/wiki/Brainfuck) interpreter to get an
overview of how the programs are stacked.  Example:

``` <!---sh-->
    perl bf.pl misaka9.c
```

This outputs:

```
    MISAKA
    MISAKA MISAKA
```


### Return value

`horizontal_cat` and `vertical_cat` will exit with zero status on success.

If any input file fails to open, `horizontal_cat` and `vertical_cat` will
report the offending file name to `stdout`, and exit with nonzero status.

If `horizontal_cat` and `vertical_cat` ran out of memory, they will exit
with nonzero status without outputting anything.


### Compatibility

`horizontal_cat` makes the following assumptions about input files:

* ASCII with LF end of line sequences.  If CR-LF sequences are used, CR
 characters will appear in the middle of output lines.
* All characters are of equal width, even tab characters.

`Misaka` has been verified to work on these following compiler+OS combinations:

* gcc 4.6.3 on Linux 3.5.0-41
* gcc 4.4.5 on Linux 2.6.32-5
* gcc 4.3.5 on JS/Linux 2.6.20
* gcc 4.8.1 on Windows (Cygwin and MingW)

`Misaka` requires a C99 compiler due to the use of single line comments.
`Misaka` does not depend on any other C99 features.


### Obfuscation

Main obfuscation is in having a C program that compiles when tiled
horizontally and vertically, while using single line comments in less than
half of the lines *and* maintaining a meaningful layout while doing that.

There are other challenges too, of course, like getting a Brainfuck program
to tile horizontally and vertically.  Really, tiling code of any sort
horizontally is an interesting exercise, I encourage everyone to try this
once.

Other features to look for:

* Peculiar bits that switches horizontal cat to vertical cat.
* Run-length encoded long cat.
* Symmetric and recycled variable names.
* CRC of the source code in the source code.

`gcc -Wall` should provide a hint to where the mode switch happens, it
does not output any irrelevant other warnings (verified on 4.6.3).


### Extra files

Extra files included in my submission are informational only, they are not
needed for the program to work.

* [bf.pl](%%REPO_URL%%/2013/misaka/bf.pl) - a perl brainfuck interpreter, in case you don't have one
handy.
* [obfuscation.html](obfuscation.html) - making of this program.


### About `Misaka`

The name, layout, and functionality of `Misaka` is inspired by a particular
stackable figure:

* [Google images](http://google.co.jp/search?q=%E3%83%9F%E3%82%B5%E3%82%AB%E7%9B%9B%E3%82%8A&tbm=isch)
* [Kotobukiya](https://web.archive.org/web/20140325175014/http://main.kotobukiya.co.jp/figure/tsubucole_tmi_misakamori/)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
