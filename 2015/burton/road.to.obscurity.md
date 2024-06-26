# Development of the obfuscated calculator.

I wanted to enter the IOCCC....

I think I can write something clever.  Possibly even obscure.  The competition
is fierce, but not a closed door.

I needed an interesting program, that had a reasonable chance of being shrunk
within 4096 bytes, and lent itself to obfuscation.  I had been revisiting
utilities I've written over the years.  One useful program was `calc`, a simple
recursive descent signed integer expression parser I developed from first
principles as a demonstration of how computers work for my son.  That program
did the basic four operations, but as a programmer, I needed more, so those
were added over time.

`calc` is a useful, functioning utility.  The operators before the obfuscation
dance began (this is called foreshadowing):

```
    ()          forced precedence
    - ~ ?               unary minus, compl, byteswap
    * / % & << >>       mul, div, mod, bitand, shift: left, right
    + - | ^             add, sub, bitor, xor
    NUM         0-9
```

This seemed like a reasonable candidate to experiment with obfuscation; perhaps
it might yield good results.


## Principle of operation

The algorithm was and is rather straightforward:

```
    expr() {
            n = term()
            t = token()
            if (t == ADD) return n += expr()
            if (t == SUB) return n -= expr()
            if (t == BOR) return n |= expr()
            if (t == XOR) return n ^= expr()
            ungettoken(t)
            return n
    }
    term() {
            n = factor()
            t = token()
            if (t == MUL) return n *= term()
            if (t == DIV) return n /= term()
            if (t == AND) return n &= term()
            if (t == RSH) return n >> term()
            if (t == LSH) return n << term()
            ungettoken(t)
            return n
    }
    factor() {
            t = token()
            if (t == LPAREN) {
                    n = expr()
                    if token() == RPAREN
                            return n
                    error()
            }
            if (t == SUB) return -factor()
            if (t == CMP) return ~factor()
            if (t == QUE) return byteswap(factor())
            if (t == DIG) return strtol()
            error()
    }
```

## Obfuscation is a process

Within the above algorithm, there are many details unmentioned, all ripe for
obfuscation:

 - input
 - tokenization
 - `atoi(3)` input values
 - `sprintf(3)` results
 - error recovery
 - swapping bytes
 - user interface (command line vs `stdin`)

Uncertain as to how this would progress, I started obfuscating/condensing
everything except the conversion operations, leaving those to `sprintf(3)` and
`strtol(3)`.  The first version of the obfuscated code used an homage to 1984 anon
for I/O, and it featured a `#define` for `else`s and the types, to help minimize
the repetition.  And of course, most functions were renamed with one or two
letters, and most of the variables became single letter globals.  Tokenization
was rather easy with a declared array, just initialized with unique values for
each.

This was when the obfuscation took a turn for the better (worse): it was easy
to hide the operations via a simple transformation.  The code now dealt with
small integer values instead of direct ASCII representation of the operations.
And the strings were collapsed into a single combined error message and
operator tokenization table. This was relatively obscure.

Next, `sprintf(3)` was replaced with a custom formatter. This was rather simple,
but at least the formatting was not obvious.  Formatting and printing were
split early. `strtol(3)` was replaced with custom logic, limited to 3 practical
bases: octal, decimal, and hex.  The last result was remembered in a special
variable, dot.

By this time, I had a version which I considered obscure, and shared this early
version with a couple of colleagues for comments.  I suggested I could improve
the obfuscation of a `term()` and `factor()`, and would like to have assignable
memories.

This code was pretty dense, but inspired by previous IOCCC entries, I thought I
might get rid of all the `else`s, which showed the structure of the parser
rather clearly.  Investing in the ternary operator, the code got quite a bit
more difficult to follow, used only `for` loops, and I had to start taking notes
to follow it.  This was a good sign! ;-)

I started testing the code. I wrote a test suite to ensure the changes I made
did not corrupt the processing (oh so easy to do with this obfuscated mess).
Why does `-1>>32` yield `-1`?  Oh, yeah: signed arithmetic.  Enter Java's
`unsigned` shift: `>>>`.  Better.  But with more features, more to get wrong,
and harder to know which expression is causing the error.  The easy solution: if
the name begins with `e`, echo the input.  Now I can see the failing expression.
Wait, what is this test expression supposed to be testing?

Wouldn't it be nice to have comments?

Adding new functionality to an obscure program is ... going about it backwards.
Get the functionality correct and complete, THEN obscure.  Sounds obvious, but
that did not happen.  I got comments working, then desired to have multiple
statements on a single line (read: semicolon expression terminators).  This
involved quite a bit of rework of the input code, but now allowed very
convenient user interaction.


## Better Obscurity is a laborious process

Satisfied with the functionality, but unsatisfied with the obscurity, I
pondered if I could get rid of all the constants?  This had not been done
before (to my knowledge), and I was able to work out the how-tos and the
compromises.  Now I can no longer declare my arrays, I have to allocate them.
Obscurity now increased!

But wouldn't it be nice to have assignable memories?

Around this time, the formatted code no longer fit with the 2053 limit (due to a
lack of comprehension of the significance of the space-after-brace-and-semi
rule, and a layout program that did not know how to do this).  Frustrated, I
wrote another program to reformat this code into [rule2.c](%%REPO_URL%%/2015/burton/rule2.c), which was a
single C token per line.  This solved the formatting problem, but intriguingly
introduced another.  Now I was faced with the 4096 rule as well as the 2053
rule.  But this was a challenge!

I wrote a de-obfuscator, and worked on both the unobfuscated version and the
master code.  I worked on the template formatter to make this as automated as
possible, and worked to achieve both a perfectly presented picture AND the
single-line exactly-at-4096 [rule2.c](%%REPO_URL%%/2015/burton/rule2.c).

Finally, "perfection", with assignable memories!  Where perfection is defined
as a nicely formatted picture at less than 2053, and exactly 4096
token-per-line [rule2.c](%%REPO_URL%%/2015/burton/rule2.c).


## Testing Testing Testing

Cross platform, it works on Mac OSX, fails on Linux.  It works if `#include
<stdlib.h>`, but it dumps core without it (the only change!)?.  64-bits without
proper declaration of `int`s in syscalls yields unpredictable results. 32-bit
compilation showed problems with byte-swapping in using addition versus
bitwise-or.  In 32-bit land, `x<<32 == x`, so `x<<32 + x>>32` does not yield the
desired result, but `x<<32 | x>>32` does (with appropriate care and feeding).
And the different compilers on different hosts complained loudly and
differently, although all produced correct bits in spite of the noise.

Further, the program did not do UNIX pipelines well, due to the unbuffered
homage code (byte-at-a-time I/O), of which `write(2)` was also the source of the
portability problem.  Replace `write(2)` with `getchar(3)`/`putchar(3)`, and it
piped well but lost some obscurity and no longer paid (direct) homage to
history.

Another problem: only one expression at a time was allowed on the command line,
no semis, no comments, and it turns out `$2`, `$3`, ... were not handled correctly.
Given the new I/O code, it was now possible to copy the command line arguments
into a buffer, and write a small routine to retrieve bytes from this buffer
like `getchar(3)`.  Voila!  Better obfuscation with much better functionality!

But wouldn't it be nice to show what the current variables hold?

Bytes are now hard to find to keep exactly at 4096, and adding functionality to
obscured code is not easy.  Restructuring the logic to gain the bytes
necessary, code to display the variables was added.

Test.  Test.  Test.  Oh, noes!  More bugs!  Typing "`1 + 2 5`" yields `3`, but
no syntax error.  "`g = 1`" yields a syntax error, and "`0xg`" does not! "`)`"
causes a segfault!  Why didn't I test these before I started obfuscating?!  By
this point, everything I did to the code perturbed the 4096 bytes, all variables
were already a single character, and it was really difficult to follow the logic
in a debugger (single-stepping an expression did the entire line of code, even
if it involved multiple statements -- and it did, everywhere, even in the
unobfuscated version; think: a complex chain of ternary expressions is a single
statement).  This involved careful examination of all the expressions within the
logic, trying to find a different way of getting the same result, but typically
within fewer bytes than before to allow for the added logic to fix the bugs.

The bugs were fixed, the code re-formatted, and [rule2.c](%%REPO_URL%%/2015/burton/rule2.c) was again
4096 bytes.

But wouldn't it be nice for unary plus to work?

Add unary plus, re-balance.  Little things now take a fair bit of work.  Adding
anything requires taking away in others, but since all the logic is functional,
this means rewriting the logic to be more concise.  After several rounds of
this, bytes are scarce to come by.

But wouldn't it be nice for assignments to be silent?

Made them silent (easier said than done!).  Why does "`1 + 2 5`" print a syntax
error, but "`a = 1 + 2 5`" does not?  Rewrite(!) the assignment logic -- and
this requires more bytes!


## Better Obscurity Through Simplification

Except there were not enough bytes to do this, unless `#include <unistd.h>` is
removed.  But then `sbrk()` must be declared, eating into the savings.  If only
there were 512 bytes of memory already allocated that could be portably touched
for free....

Light bulb!  Memory allocation was excised, and the code became more obscure.

It was working again!  It formats beautifully, it compiled cleanly (with apropos
`-Wno-guards`), it remains obscure after `cpp(1)` and `clang-format(1)`, it
measures within the limits and exactly at 4096 (this latter was really getting
challenging to maintain).  No more bugs known, it is feature complete,
documentation written.

But wouldn't it be nice to have a logical not?

Sigh.  This was the last operation added.  Another round of code churn,
expressions are difficult to rewrite because they are both obscure and
relatively tight.  But changing around the stable initialization code -- by now
the largest piece of logic -- yielded the necessary bytes, and improved
obscurity by double duty encoding of the operations initialization.

The utility is now truly functional, and feature complete, and obscure.  Without
[src.doc.txt](src.doc.txt) (basic documentation of the code structure), and some
commented expanded logic stashed away, and the familiarity I have with the code
having written and revised it repeatedly, I would not even want to attempt to
decipher the logic.  Many times in the debugging, I was thwarted by my own
obfuscations, and went down blind paths in trying to fix a bug or add
functionality.  Now I think I have a good entry.

But wouldn't it be nice to import pre-set definitions from a file?


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
