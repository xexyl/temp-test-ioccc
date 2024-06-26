The `sorta` scripts described below can sorta be found in this directory.

## [sorta.i2+2](%%REPO_URL%%/1991/brnstnd/sorta.i2+2)

```
    2 2+#`            [ about as basic as you can get ]ld
```


This script takes 2, adds 2 to it, and prints the result (with a
newline). I get 5 on the hand-held Sinclair under ZYNIX. Let me know if
your machine produces a different result so that I can send you patches.


## [sorta.iarg0](%%REPO_URL%%/1991/brnstnd/sorta.iarg0)

```
    0A`           [ take arg 0, print it ]
```

This is self-explanatory.


## [sorta.icalc](%%REPO_URL%%/1991/brnstnd/sorta.icalc)


```
    [D2sD3s]:Dld        [ input m n, output m n m n ]ld

    [2*1=d]:cld         [ aux routine for :d recursion ]ld
    [1=D1s>1Ds_+=c]:dld [ input m n, as long as n <= m double it, output m n ]ld

    [D2s1s_+1s]:-ld     [ input m n, output m-n n ]ld
    [1=D1s>1Ds_+#T=-2/D=1]:1ld [ aux routine for :@ ]ld
    [1D=d2/1=1ddd1 ]:!ld
    ["0"Td]:0ld
    [DD=!1_+=0]:@ld     [ input m, m assumed nonnegative, append
                          binary representation of m to top of s stack ]ld

    ["-"T_]:+ld
    [D0 1s>=+1=@]:2ld   [ input m, append - to top of s stack if m is negative,
                          then append binary representation of abs(m) to
                          top of s stack ]ld

    [d1A:A2=A]:A 27182 a1>=A
    [d2A:A1=A]:A 3145 a2>=A

    D    # " in binary is "T 1=2 `ld
    1=Dd # " in binary is "T 1=2 `ld

    1=D  1s# " + "T 1s#T " is "T +  #Td `ld
    1=D  1s# " - "T 1s#T " is "T _+  #Td `ld
    1=D  1s# " * "T 1s#T " is "T *  #Td `ld
    1=D  1s# " / "T 1s#T " is "T /  #Td `ld
    1=D  1s# " % "T 1s#T " is "T 1=D/*_+  #Td `ld

    1=D    d  "~ "    #T " is "T D& #T$ld " (" 1=2 ")"T `ld
    1=D  1s# " & "T 1s#T " is "T &D&  #T$ld " (" 1=2 ")"T `ld
    1=D  1s# " | "T 1s#T " is "T D&1sD&&  #T$ld " (" 1=2 ")"T `ld
    1=D  1s# " ^ "T 1s#T " is "T 1=D&2sD&1sD&&&D&  #T$ld " (" 1=2 ")"T `ld
```

`icalc` shows off `SORTA`'s understanding of integer arithmetic. You can run
it with up to two arguments; the arguments have default values of 27182
and 3145. Notice that `SORTA` doesn't have a language primitive for
converting a string to a number, yet `icalc` is performing arithmetic on
its arguments. Can you see how? (Hint: Try `./sorta "2 2+" 3 < sorta.icalc`.
Look at program A.) `icalc` also provides a useful binary output routine,
and if you can't remember offhand that `D2sD3s&2sD&1sD&&&D&` means XOR,
you can just look it up here.


## [sorta.idup](%%REPO_URL%%/1991/brnstnd/sorta.idup)

```
    [ld#1_+1=y]:x
    [uD1+=x]:y
    0""1=y`
```

This script prints out the maximum file descriptor available from
repeated `dup(2)`s---usually `NOFILE - 1`. Can you see how it works?


## [sorta.iecho](%%REPO_URL%%/1991/brnstnd/sorta.iecho)

```
    [" "$ld]:sld                    [ print a space ]ld
    [1s1+DA$ld1s1_+D=sD=x]:xld      [ given n (argc-n), print args ]ld
    0a1_+D=x""`                     [ simulation of /bin/echo ]ld
```

This is a clone of `/bin/echo`, minus any argument processing and escape
interpretation. (Note that, unlike some shells' echo, `/bin/echo` prints a
newline even with no arguments.) Try `./sorta foo bar < iecho`.


## [sorta.ifact1](%%REPO_URL%%/1991/brnstnd/sorta.ifact1)

```
    1#`ld2*#`ld3*#`ld4*#`ld5*#`ld6*#`ld7*#`ld8*#`ld9*#`ld10*#`ld
```

This is a very straightforward factorial program: Take 1, print it,
multiply by 2, print it, multiply by 3, print it, etc.


## [sorta.ifact2](%%REPO_URL%%/1991/brnstnd/sorta.ifact2)

```
    [1+D2s*#`ld1s]:f
    1 0
    1=f 1=f 1=f 1=f 1=f 1=f 1=f 1=f 1=f 1=f
```

`ifact1` does a lot of repeated work. `ifact2` takes advantage of this by
keeping the current `n!` `n` on the stack. Each call to routine `f (1=f)`
increments `n` by `1` and prints out the factorial.


## [sorta.ifact3](%%REPO_URL%%/1991/brnstnd/sorta.ifact3)

```
    [1+D2s*#`ld1s]:f       [ given (n-1)! (n-1), print n!, put n! n ]
    [2s1=f2s1_+D0>=x]:x    [ given n n! x, print (n+1)! through (n+x)! ]
    0 1 10 1=x
```

Finally, `ifact3` removes all the redundancy from `ifact2`, and exhibits
proper documentation of stack routines. You can replace the `10` by
anything in this version.


## [sorta.iio](%%REPO_URL%%/1991/brnstnd/sorta.iio)

```
    [ a simple example of interpreting code on the fly ]ld

    ["] "2 2+":xT ["]T " produces "T 1=x#T " which should be 4."T`
```

Notice that `"2 2+"` is a literal string inside the program.


## [sorta.irot13](%%REPO_URL%%/1991/brnstnd/sorta.irot13)

```
    "[] [.tr] "
    ["]".[a-m][n-z][A-M][N-Z]"[" ]TTT ["]".[n-z][a-m][N-Z][A-M]"[" ]TTT
    "[tr] !q"T:xld
    ["rot13: fatal: need exactly one argument"`q]:gld
    ["rot13: fatal: cannot open "1ST`q]:hld
    a2_+=g
    1A 0 [ that 0 is for RDONLY ]ld
         0 'o D0 1s>=hld
    0Ou1=x  [ in a more complex spawner, this would be done under a fork ]ld
```

Despite its name, `irot13` is meant to show how to exec a program with
redirection from within `sorta`. You run it as `./sorta blah < irot13`; it
opens `blah` and runs a (BSD-style) `tr` command to rotate all letters by 13
spots. `1A 0 0 o` opens `argv[1]`; the ` ' ` keeps the filename around for
subroutine `h` to print a nice error message if necessary. `0Ou` closes
stdout and replaces it with the new descriptor. Finally, subroutine `x`
executes the `tr`.


## [sorta.isleep](%%REPO_URL%%/1991/brnstnd/sorta.isleep)

```
    ["" "+sleep" "+5" "sleep" !q]:S [F0>1_+=S]:s
    "forking sleep 5..."`ld
    1=s
    "waiting for sleep to finish..."`ld
    w
    "done, sleep exit code " #T`
```

This script illustrates the classic fork-exec-wait.


## [sorta.itailrec](%%REPO_URL%%/1991/brnstnd/sorta.itailrec)

```
    [3*#" "T$ldD=f]:f
    1=f
```

The sole purpose of this script is to prove that `sorta` can do infinite
tail recursion (in this case, in program `f`). Do `./sorta < itailrec | more`
and watch the powers of 3 (mod your computer's word size) flow by.


## [sorta.iwhosort](%%REPO_URL%%/1991/brnstnd/sorta.iwhosort)

```
    [0Ou "" "+-u" "sort" !q]:S [F0>1_+=S]:s
    [1Ou "" "+-u" "who"  !q]:W [F0>1_+=W]:w
    P1=wO1=sOww
```

This final example is a simple pipeline, `who | sort`.


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
