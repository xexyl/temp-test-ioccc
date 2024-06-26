# FIRST & THIRD (almost FORTH)

FORTH is a language mostly familiar to users of "small" machines.
FORTH programs are small because they are interpreted--a function
call in FORTH takes two bytes.  FORTH is an extendable language--
built-in primitives are indistinguishable from user-defined
_words_.  FORTH interpreters are small because much of the system
can be coded in FORTH--only a small number of primitives need to
be implemented.  Some FORTH interpreters can also compile defined
words into machine code, resulting in a fast system.

FIRST is an incredibly small language which is sufficient for
defining the language THIRD, which is mostly like FORTH.  There are
some differences, and THIRD is probably just enough like FORTH for
those differences to be disturbing to regular FORTH users.

The only existing FIRST interpreter is written in obfuscated C,
and rings in at under 800 bytes of source code, although through
deletion of both whitespace and obfuscation it can be brought to about 650
bytes.

This document FIRST defines the FIRST environment and primitives,
with relevant design decision explanations.  It secondly documents
the general strategies we will use to implement THIRD.  The THIRD
section demonstrates how the complete THIRD system is built up
using FIRST.


## Section 1:  FIRST


### Environment

FIRST implements a virtual machine.  The machine has three chunks
of memory: "main memory", "the stack", and "string storage".  When
the virtual machine wishes to do random memory accesses, they come
out of main memory--it cannot access the stack or string storage.

The stack is simply a standard LIFO data structure that is used
implicitly by most of the FIRST primitives.  The stack is made up
of `int`s, whatever size they are on the host machine.

String storage is used to store the names of built-in and defined
primitives.  Separate storage is used for these because it allows
the C code to use C string operations, reducing C source code size.

Main memory is a large array of `int`s.  When we speak of
addresses, we actually mean indices into main memory.  Main memory
is used for two things, primarily: the return stack and the dictionary.

The return stack is a LIFO data structure, independent of
the above-mentioned "stack", which is used by FIRST to keep
track of function call return addresses.

The dictionary is a list of words.  Each word contains a header
and a data field.  In the header is the address of the previous word,
an index into the string storage indicating where the name of this
word is stored, and a "code pointer".  The code pointer is simply
an integer which names which "machine-language-primitive" implements
this instruction.  For example, for defined words the code pointer
names the "run some code" primitive, which pushes the current program
counter onto the return stack and sets the counter to the address of
the data field for this word.

There are several important pointers into main memory.  There is
a pointer to the most recently defined word, which is used to start
searches back through memory when compiling words.  There is a pointer
to the top of the return stack.  There is a pointer to the current
end of the dictionary, used while compiling.

For the last two pointers, namely the return stack pointer and
the dictionary pointer, there is an important distinction: the pointers
themselves are stored in main memory (in `FIRST`'s main memory).  This
is critical, because it means FIRST programs can get at them without
any further primitives needing to be defined.


### Instructions

There are two kinds of FIRST instructions, normal instructions and
immediate instructions.  Immediate instructions do something significant
when they are used.  Normal instructions compile a pointer to their
executable part onto the end of the dictionary.  As we will see, this
means that by default FIRST simply compiles things.


####  Integer Operations

```
        SYMBOL  NAME            FUNCTION

          -     binary minus    pop top 2 elements of stack, subtract, push

          *     multiply        pop top 2 elements of stack, multiply, push

          /     divide          pop top 2 elements of stack, divide, push

          <0    less than 0     pop top element of stack, push 1 if < 0 else 0
```

Note that we can synthesize addition and negation from binary minus,
but we cannot synthesize a time efficient divide or multiply from it.
`<0` is synthesize-able, but only in a non-portable way.


####  Memory Operations

```
        SYMBOL  NAME            FUNCTION

          @     fetch           pop top of stack, treat as address to push contents of

          !     store           top of stack is address, 2nd is value; store to memory
                                and pop both off the stack
```


####  Input/Output Operations

```
        NAME                    FUNCTION

        echo                    output top of stack through C's putchar()

        key                     push C's getchar() onto top of stack

        _read                   read a space-delimited word, find it in the
                                dictionary, and compile a pointer to
                                that word's code pointer onto the
                                current end of the dictionary
```

Although `_read` could be synthesized from key, we need `_read` to be able
to compile words to be able to start any syntheses.


####  Execution Operations

```
        NAME                    FUNCTION

        exit                    leave the current function: pop the return stack
                                into the program counter
```


####  Immediate (compilation) Operations

```
        SYMBOL  NAME            FUNCTION

          :     define          read in the next space-delimited word, add it to
                                the end of our string storage, and generate
                                a header for the new word so that when it
                                is typed it compiles a pointer to itself
                                so that it can be executed.

        immediate immediate     when used immediately after a name following a ':',
                                it makes the word being defined run whenever
                                it is typed.
```

`:` cannot be synthesized, because we could not synthesize anything.
`immediate` has to be an immediate operation, so it could not be
synthesized unless by default operations were immediate; but that
would preclude our being able to do any useful compilation.


####  Stack Operations

```
        NAME                    FUNCTION

        pick                    pop top of stack, use as index into stack and copy up
                                that element
```

If the data stack were stored in main memory, we could synthesize `pick`;
but putting the stack and stack pointer in main memory would significantly
increase the C source code size.

There are three more primitives, but they are "internal only"--
they have no names and no dictionary entries.  The first is
`pushint`.  It takes the next integer out of the instruction stream
and pushes it on the stack.  This could be synthesized, but probably
not without using integer constants.  It is generated by `_read` when
the input is not a known word.  The second is `compile me`.  When
this instruction is executed, a pointer to the word's data field is
appended to the dictionary.  The third is `run me`--the word's data
field is taken to be a stream of pointers to words, and is executed.

One last note about the environment: FIRST builds a very small
word internally that it executes as its main loop.  This word calls
`_read` and then calls itself.  Each time it calls itself, it uses
up a word on the return stack, so it will eventually trash things.
This is discussed some more in section 2.


Here's a handy summary of all the FIRST words:

```
        WORD            DESCRIPTION

        - * /           binary integer operations on the stack
        <0              is top of stack less than 0?
        @ !             read from or write to memory
        echo key        output or input one character
        _read           read a word from input and compile a pointer to it
        exit            stop running the current function
        :               compile the header of a definition
        immediate       modify the header to create an immediate word
```

Here is a sample FIRST program.  I'm assuming you're using
the ASCII character set.  FIRST does not depend upon ASCII, but
since FIRST has no syntax for character constants, one normally has
to use decimal values.  This can be avoided using `getchar(3)`, though.
Oh.  One other odd thing.  FIRST initially builds its symbol table
by calling `:` several times, so it needs to get the names of the base
symbols as its first 13 words of input.  You could even name them
differently if you wanted.

These FIRST programs have FORTH comments in them: they are contained
inside parentheses.  FIRST programs cannot have FORTH comments; but I need
some device to indicate what's going on.  (THIRD programs are an entirely
different subject.)

```
                ( Our first line gives the symbols for the built-ins )
        : immediate _read @ ! - * / <0 exit echo key _pick

                ( now we define a simple word that will print out a couple characters )

        : L                     ( define a word named 'L' )
          108 echo              ( output an ascii 'l' )
          exit

        : hello                 ( define a word named 'hello')
          72 echo               ( output an ascii 'H' )
          101 echo              ( output an ascii 'e' )
          111                   ( push ascii 'o' onto the stack )
          L L                   ( output two ascii 'l's )
          echo                  ( output the 'o' we pushed on the stack before )
          10 echo               ( print a newline )
          exit                  ( stop running this routine )

        : test immediate        ( define a word named 'test' that runs whenever typed )
          hello                 ( call hello )
          exit

        test

        ( The result of running this program should be:
        Hello
        )
```

## Section 2: Motivating THIRD

What is missing from FIRST?  There are a large number of
important primitives that aren't implemented, but which are
easy to implement.  `drop`, which throws away the top of the
stack, can be implemented as `{ 0 * + }` -- that is, multiply
the top of the stack by `0` (which turns the top of the stack
into a `0`), and then add the top two elements of the stack.

`dup`, which copies the top of the stack, can be easily
implemented using temporary storage locations.  Conveniently,
FIRST leaves memory locations `3`, `4`, and `5` unused.  So we can
implement `dup` by writing the top of stack into `3`, and then
reading it out twice: `{ 3 ! 3 @ 3 @ }`.

We will never use the FIRST primitive `pick` in building THIRD,
just to show that it can be done; `pick` is only provided because
`pick` itself cannot be built out of the rest of `FIRST`'s building
blocks.

So, instead of worrying about stack primitives and the
like, what else is missing from FIRST?  We get recursion, but
no control flow--no conditional operations.  We cannot at the
moment write a looping routine which terminates.

Another glaring dissimilarity between FIRST and FORTH is
that there is no "command mode"--you cannot be outside of a
`:` definition and issue some straight commands to be executed.
Also, as we noted above, we cannot do comments.

FORTH also provides a system for defining new data types,
using the words (in one version of FORTH) `builds and does`.
We would like to implement these words as well.

As the highest priority thing, we will build control flow
structures first.  Once we have control structures, we can
write recursive routines that terminate, and we are ready to
tackle tasks like parsing, and the building of a command mode.

By the way, location `0` holds the dictionary pointer, location
`1` holds the return stack pointer, and location `2` should always
be `0`--it's a fake dictionary entry that means `pushint`.


## Section 3: Building THIRD

In this section we'll eventually have real comments.

The first thing we have to do is give the symbols for our built-ins.

```
        : immediate _read @ ! - * / < exit echo key _pick
```

Next we want to be mildly self commenting, so we define the word `r` to push
the *address of the return stack pointer* onto the stack--NOT the value of the
return stack pointer.  (In fact, when we run `r`, the value of the return stack
pointer is temporarily changed.)

```
        : r 1 exit
```

Next, we're currently executing a short loop that contains `_read` and
recursion, which is slowly blowing up the return stack.  So let's define a new
word, from which you can never return.  What it does is drops the top value off
the return stack, calls `_read`, then calls itself.  Because it kills the top of
the return stack, it can recurse indefinitely.

```
        : ]
          r @                   Get the value of the return stack pointer
          1 -                   Subtract one
          r !                   Store it back into the return stack pointer
          _read                 Read and compile one word
          ]                     Start over
```

Notice that we don't need to exit, since we never come back.  Also, it's
possible that an immediate word may get run during `_read`, and that `_read`
will never return!

Now let's get compile running.

```
        : main immediate ]
        main
```

Next off, I'm going to do this the easy but non-portable way, and put some
character constant definitions in.  I wanted them at the top of the file, but
that would have burned too much of the return stack.

```
        : '"'   34      exit
        : ')'   41      exit
        : '\n'  10      exit
        : 'space' 32    exit
        : '0'   48      exit
        : '-'   45      exit

        : cr '\n' echo exit
```

Next, we want to define some temporary variables for locations `3`, `4`, and
`5`, since this'll make our code look clearer.


```
        : _x 3 @ exit
        : _x! 3 ! exit
        : _y 4 @ exit
        : _y! 4 ! exit
```

OK.  Now, we want to make THIRD look vaguely like FORTH,
so we're going to define `;`.  What `;` ought to do is
terminate a compilation, and turn control over to the
command-mode handler.  We don't have one, so all we want
`;` to do for now is compile `exit` at the end of the
current word.  To do this we'll need several other words.

Swap by writing out the top two elements into temps, and
then reading them back in the other order.

```
        : swap _x! _y! _x _y exit
```

Take another look and make sure you see why that works,
since it LOOKS like I'm reading them back in the same
order--in fact, it not only looks like it, but I AM!

Addition might be nice to have.  To add, we need to
negate the top element of the stack, and then subtract.
To negate, we subtract from `0`.

```
        : +
          0 swap -
          -
          exit
```

Create a copy of the top of stack.

```
        : dup _x! _x _x exit
```

Get a mnemonic name for our dictionary pointer--we need
to compile stuff, so it goes through this.

```
        : h 0 exit
```

We're going to need to advance that pointer, so let's
make a generic pointer-advancing function.
Given a pointer to a memory location, increment the value
at that memory location.

```
        : inc
          dup @                 Get another copy of the address, and get the value
                                so now we have value, address on top of stack.
          1 +                   Add one to the value
          swap                  Swap to put the address on top of the stack
          ! exit                Write it to memory
```

`,` is a standard FORTH word.  It should write the top of
stack into the dictionary, and advance the pointer

```
        : ,
          h @                   Get the value of the dictionary pointer
          !                     Write the top of stack there
          h inc                 And increment the dictionary pointer
          exit
```

`'` is a standard FORTH word.  It should push the address
of the word that follows it onto the stack.  We could
do this by making `'` immediate, but then it'd need to
parse the next word.  Instead, we compile the next word
as normal.  When `'` is executed, the top of the return
stack will point into the instruction stream immediately
after the `'`.  We push the word there, and advance the
return stack pointer so that we don't execute it.

```
        : '
          r @                   Get the address of the top of return stack
                                We currently have a pointer to the top of return stack
          @                     Get the value from there
                                We currently have a pointer to the instruction stream
          dup                   Get another copy of it--the bottom copy will stick
                                around until the end of this word
          1 +                   Increment the pointer, pointing to the NEXT instruction
          r @ !                 Write it back onto the top of the return stack
                                We currently have our first copy of the old pointer
                                to the instruction stream
          @                     Get the value there--the address of the "next word"
          exit
```

Now we're set.  `;` should be an immediate word that pushes
the address of `exit` onto the stack, then writes it out.

```
        : ; immediate
          ' exit                Get the address of exit
          ,                     Compile it
          exit                  And we should return
```

Now let's test out `;` by defining a useful word:

```
        : drop 0 * + ;
```

Since we have `inc`, we ought to make `dec`:

```
        : dec dup @ 1 - swap ! ;
```

Our next goal, now that we have `;`, is to implement
`if-then`.  To do this, we'll need to play fast and
loose with the return stack, so let's make some
words to save us some effort.

First we want a word that pops off the top of the normal
stack and pushes it on top of the return stack.  We'll
call this `tor`, for TO-Return-stack.   It sounds easy,
but when `tor` is running, there's an extra value on the
return stack--`tor`'s return address!  So we have to pop
that off first...  We better just bite the bullet and
code it out--but we can't really break it into smaller
words, because that'll trash the return stack.

```
        : tor
          r @ @                 Get the value off the top of the return stack
          swap                  Bring the value to be pushed to the top of stack
          r @ !                 Write it over the current top of return stack
          r @ 1 + r !           Increment the return stack pointer--but can't use inc
          r @ !                 Store our return address back on the return stack
        ;
```

Next we want the opposite routine, which pops the top
of the return stack, and puts it on the normal stack.

```
        : fromr
          r @ @                 Save old value
          r @ 1 - r !           Decrement pointer
          r @ @                 Get value that we want off
          swap                  Bring return address to top
          r @ !                 Store it and return
        ;
```

Now, if we have a routine that's recursing, and we
want to be polite about the return stack, right before
we recurse we can run `{ fromr drop }` so the stack won't
blow up.  This means, though, that the first time we
enter this recursive routine, we blow our *real* return
address--so when we're done, we'll return up two levels.
To save a little, we make `tail` mean `{ fromr drop }`;
however, it's more complex since there's a new value on
top of the return stack.

```
        : tail fromr fromr drop tor ;
```

Now, we want to do `if`.  To do this, we need to convert
values to boolean values.  The next few words set this
up.

`minus` gives us unary negation.

```
        : minus 0 swap - ;
```

If top of stack is boolean, `bnot` gives us inverse

```
        : bnot 1 swap - ;
```

To compare two numbers, subtract and compare to `0`.

```
        : < - <0 ;
```

`logical` turns the top of stack into either `0` or `1`.

```
        : logical
          dup                   Get two copies of it
          0 <                   1 if < 0, 0 otherwise
          swap minus            Swap number back up, and take negative
          0 <                   1 if original was > 0, 0 otherwise
          +                     Add them up--has to be 0 or 1!
        ;
```

`not` returns 1 if top of stack is 0, and 0 otherwise

```
        : not logical bnot ;
```

We can test equality by subtracting and comparing to `0`.

```
        : = - not ;
```

Just to show how you compute a branch:  Suppose you've
compiled a call to branch, and immediately after it is
an integer constant with the offset of how far to branch.
To branch, we use the return stack to read the offset, and
add that on to the top of the return stack, and return.

```
        : branch
          r @                   Address of top of return stack
          @                     Our return address
          @                     Value from there: the branch offset
          r @ @                 Our return address again
          +                     The address we want to execute at
          r @ !                 Store it back onto the return stack
        ;
```

For conditional branches, we want to branch by a certain
amount if true, otherwise we want to skip over the branch
offset constant--that is, branch by one.  Assuming that
the top of the stack is the branch offset, and the second
on the stack is `1` if we should branch, and `0` if not, the
following computes the correct branch offset.

```
        : computebranch 1 - * 1 + ;
```

Branch if the value on top of the stack is `0`.

```
        : notbranch
          not
          r @ @ @               Get the branch offset
          computebranch         Adjust as necessary
          r @ @ +               Calculate the new address
          r @ !                 Store it
        ;
```

`here` is a standard FORTH word which returns a pointer to
the current dictionary address--that is, the value of
the dictionary pointer.

```
        : here h @ ;
```

We're ALL SET to compile `if...else...then` constructs!
Here's what we do.  When we get `if`, we compile a call
to `notbranch`, and then compile a dummy offset, because
we don't know where the `then` will be.  On the *stack*
we leave the address where we compiled the dummy offset.
`then` will calculate the offset and fill it in for us.

```
        : if immediate
          ' notbranch ,         Compile notbranch
          here                  Save the current dictionary address
          0 ,                   Compile a dummy value
        ;
```

`then` expects the address to `fixup` to be on the stack.

```
        : then immediate
          dup                   Make another copy of the address
          here                  Find the current location, where to branch to
          swap -                Calculate the difference between them
          swap !                Bring the address to the top, and store it.
        ;
```

Now that we can do `if...then` statements, we can do
some parsing!  Let's introduce real FORTH comments.
`find-)` will scan the input until it finds a `)`, and
exit.

```
        : find-)
          key                   Read in a character
          ')' =                 Compare it to close parentheses
          not if                If it's not equal
            tail find-)         repeat (popping R stack)
          then                  Otherwise branch here and exit
        ;

        : ( immediate
          find-)
        ;

        ( we should be able to do FORTH-style comments now )

        ( now that we've got comments, we can comment the rest of the code
          in a legitimate [self parsing] fashion.  Note that you can't
          nest parentheses... )

        : else immediate
          ' branch ,            ( compile a definite branch )
          here                  ( push the backpatching address )
          0 ,                   ( compile a dummy offset for branch )
          swap                  ( bring old backpatch address to top )
          dup here swap -       ( calculate the offset from old address )
          swap !                ( put the address on top and store it )
        ;

        : over _x! _y! _y _x _y ;

        : add
          _x!                   ( save the pointer in a temp variable )
          _x @                  ( get the value pointed to )
          +                     ( add the incremement from on top of the stack )
          _x !                  ( and save it )
        ;

        : allot h add ;

        : maybebranch
          logical               ( force the TOS to be 0 or 1 )
          r @ @ @               ( load the branch offset )
          computebranch         ( calculate the condition offset [either TOS or 1])
          r @ @ +               ( add it to the return address )
          r @ !                 ( store it to our return address and return )
        ;

        : mod _x! _y!           ( get x then y off of stack )
          _y _y _x / _x *       ( y - y / x * x )
          -
        ;

        : printnum
          dup
          10 mod '0' +
          swap 10 / dup
          if
            printnum
            echo
          else
            drop
            echo
          then
        ;

        : .
          dup 0 <
          if
            '-' echo minus
          then
          printnum
          'space' echo
        ;

        : debugprint dup . cr ;

        ( the following routine takes a pointer to a string, and prints it,
          except for the trailing quote.  returns a pointer to the next word
          after the trailing quote )

        : _print
          dup 1 +
          swap @
          dup '"' =
          if
            drop exit
          then
          echo
          tail _print
        ;

        : print _print ;

          ( print the next thing from the instruction stream )
        : immprint
          r @ @
          print
          r @ !
        ;

        : find-"
          key dup ,
          '"' =
          if
            exit
          then
          tail find-"
        ;

        : " immediate
          key drop
          ' immprint ,
          find-"
        ;

        : do immediate
          ' swap ,              ( compile 'swap' to swap the limit and start )
          ' tor ,               ( compile to push the limit onto the return stack )
          ' tor ,               ( compile to push the start on the return stack )
          here                  ( save this address so we can branch back to it )
        ;

        : i r @ 1 - @ ;
        : j r @ 3 - @ ;

        : > swap < ;
        : <= 1 + < ;
        : >= swap <= ;

        : inci
          r @ 1 -       ( get the pointer to i )
          inc           ( add one to it )
          r @ 1 - @     ( find the value again )
          r @ 2 - @     ( find the limit value )
          <=
          if
            r @ @ @ r @ @ + r @ ! exit          ( branch )
          then
          fromr 1 +
          fromr drop
          fromr drop
          tor
        ;

        : loop immediate ' inci @ here - , ;

        : loopexit

          fromr drop            ( pop off our return address )
          fromr drop            ( pop off i )
          fromr drop            ( pop off the limit of i )
        ;                       ( and return to the caller's caller routine )

        : execute
          8 !
          ' exit 9 !
          8 tor
        ;

        : :: ;          ( :: is going to be a word that does ':' at runtime )

        : fix-:: immediate 3 ' :: ! ;
        fix-::

                ( Override old definition of ':' with a new one that invokes ] )
        : : immediate :: ] ;

        : command
          here 5 !              ( store dict pointer in temp variable )
          _read                 ( compile a word )
                                ( if we get control back: )
          here 5 @
          = if
            tail command        ( we didn't compile anything )
          then
          here 1 - h !          ( decrement the dictionary pointer )
          here 5 @              ( get the original value )
          = if
            here @              ( get the word that was compiled )
            execute             ( and run it )
          else
            here @              ( else it was an integer constant, so push it )
            here 1 - h !        ( and decrement the dictionary pointer again )
          then
          tail command
        ;

        : make-immediate        ( make a word just compiled immediate )
          here 1 -              ( back up a word in the dictionary )
          dup dup               ( save the pointer to here )
          h !                   ( store as the current dictionary pointer )
          @                     ( get the run-time code pointer )
          swap                  ( get the dict pointer again )
          1 -                   ( point to the compile-time code pointer )
          !                     ( write run-time code pointer on compile-time pointer )
        ;

        : <build immediate
          make-immediate        ( make the word compiled so far immediate )
          ' :: ,                ( compile '::', so we read next word )
          2 ,                   ( compile 'pushint' )
          here 0 ,              ( write out a 0 but save address for does> )
          ' , ,                 ( compile a push that address onto dictionary )
        ;

        : does> immediate
          ' command ,           ( jump back into command mode at runtime )
          here swap !           ( backpatch the build> to point to here )
          2 ,                   ( compile run-code primitive so we look like a word )
          ' fromr ,             ( compile fromr, which leaves var address on stack )
        ;


        : _dump                 ( dump out the definition of a word, sort of )
          dup " (" . " , "
          dup @                 ( save the pointer and get the contents )
          dup ' exit
          = if
                " ;)" cr exit
          then
          . " ), "
          1 +
          tail _dump
        ;

        : dump _dump ;

        : # . cr ;

        : var <build , does> ;
        : constant <build , does> @ ;
        : array <build allot does> + ;

        : [ immediate command ;
        : _welcome " Welcome to THIRD.
        Ok.
        " ;

        : ; immediate ' exit , command exit

        [

        _welcome
```


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
