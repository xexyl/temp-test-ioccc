# The Patience puzzle

The Patience puzzle, probably of Chinese origin, consists of
an iron U-shaped piece and several rings that link around
it.  The physical shape of the puzzle is very difficult to
describe verbally, but here is an attempt.

This description of the puzzle is presented as a set of
instructions for constructing the puzzle.  Start with a flat
piece of iron about 15 centimeters long by about two
centimeters wide.  Drill six holes in the piece of iron.
Through each hole, place a rod.  The rod should have a
diameter slightly less than that of the hole so that it can
move freely.  One end of the rod is like the head of a nail
and is larger than the hole to prevent it from coming free.
The other end is looped around a metal ring with a diameter
of about five centimeters.  This completely prevents the
iron rod from separating from the base.  Each rod, in
addition to going through the iron base, goes through the
ring at the end of the rod to its right.  The only rod free
of this restriction is the rightmost rod.  What has been
described so far is one of the two components of the puzzle.

The other component is another iron rod shaped like a `U`.
The `U` is as long from the tips to the base as the original
piece of iron with the holes in it.  The ends of the `U` are
looped around another ring of about five centimeters in
diameter.  In the puzzle's initial configuration, the `U` is
placed through the rings so that it is held in place by the
iron rods.  Imagine starting with the `U` piece before the
iron loop is placed at the end.  Slide the legs of the `U`
through the loops so that the iron rods securing the loops
to the metal strip go up the center of the `U`.  Placing the
final ring at the ends of the `U` prevents it from coming out.
The object of the puzzle is to free the `U`-shaped piece from
the other piece.

The following illustration (sideways) shows a three-ring
case of this puzzle.  If you look carefully, you can see
that the first ring could be lifted over the edge of the `U`
and slid down through the center of the `U`, thereby freeing
the `U` from the first iron rod.  The second ring can also be
freed in the initial configuration since it is already over
the rod for the first ring.  The third ring cannot be moved,
however, since it is blocked by the iron rod to which the
first ring is attached.  If the first first is removed, then
the third ring is no longer blocked by the first ring's iron
rod and can be removed freely.  The second ring, however
cannot be moved if the first ring is gone because it will
then be blocked by the first ring in its new position
outside of the `U`.

Here is an illustration of the three-ring case.  The bottom
of the puzzle is on the left-hand side of the page.

```
                               //==\\
                              ||    ||
                              ||    ||
                         *****||**  ||
                       ***    || ***||
                       **     ||   *||
          |\           **     ||    ||**
          | \           ***   ||    ||  ***
          |  \            ***  |    ||    ===
          |   \             ***     ||  // * \\
          |    \              ***   || || **  ||
          |     |             | **********    ||
          |     |             ||    || ||     ||
          |     |             ||    || ||     ||
          |     |        *****||**  ||  \\    ||
       |  | |\  |      ***    || ***||        ||
       |==| |=========-**-===-||-============//
       |==| |=========-**-===-||-===========//
       |  |  \| |       ***   ||    ||  ***
          |     |         *** ||    ||    ===
          |     |           ***|    ||  // * \\
          |     |             ***   || || **  ||
          |     |             ||**********    ||
          |     |             ||    || ||     ||
          |     |        *****||**  ||  \\    ||
       |  | |\  |      ***    || ***||        ||
       |==| |=========-**-===-||-============//
       |==| |=========-**-===-||-===========//
       |  |  \| |       ***   ||    ||  ***
          |     |         *** ||    ||    ===
          |     |           ***|    ||  // * \\
          |     |             ***   || || **  ||
          |     |             ||**********    ||
          |     |             ||    || ||     ||
          |     |             ||    || ||     ||
       |  |     |             ||    ||  \\    ||
       |  | |\  |             ||    ||        ||
       |==| |================-||-============//
       |==| |================-||-===========//
       |  |  \| |             ||    ||
          |     |             ||    ||
          |     |             ||    ||
          |     |             ||    ||
          \     |             ||    ||
           \    |              \\   ||
            \   |               \\  ||
             \  |                \\ ||
              \ |                 \\||
               \|                  \||
```

This puzzle takes other forms as well.  One such puzzle is
called "Spin-Out".  This puzzle consists of one plastic
piece that encases another piece that can slide in and out
of it.  The movement of the smaller piece is restricted by
discs that, when turned to one angle, lock the smaller piece
inside the larger one and, when turned the other way, allow
it to move.  This puzzle is as difficult to describe as the
first and, since I don't have one in front of me, I will not
attempt to describe it.  The object of this puzzle is to
free the smaller piece from the larger one.  The other
puzzle that is like this one consists of a cylinder with
rods protruding from the top.  The rods can be slid from the
center to the edge of the cylinder constrained by a series
of discs in the center.  The discs have cuts in them that
allow some rods to move and force others in one place based
on the relative rotations of the discs.  The object here is
to move all the rods from the inside to the outside.

What makes these puzzles similar is that the physical shapes
of the puzzles put the same restrictions on the movement of
the pieces.  Specifically, there is always one piece that is
free to move.  The only other piece that is free to move is
the second one that is still attached to the base it is
trying to be freed from.  In the case of the original
puzzle, consider the rings numbered from 1 to 6 with ring 1
being the one at the closed end of the `U`.  Ring 1 can
always be removed from or added to the `U`.  In the initial
state, when all rings are around the `U`, ring 2 is the other
one that can be moved because it is second.  If ring 1 is
removed, then only two operations are possible: the
restoration of ring 1 and the removal of ring 3.  This is
because ring 1 is always movable, and ring 3 is currently
the second ring still attached to the `U`.  This constraint
leads to a recursive solution to the puzzle.  Like the
[Towers of Hanoi](hanoi.html), the number of steps to solve this puzzle is
exponential in the number of rings.


<hr style="width:10%;text-align:left;margin-left:0">

Jump to: [top](#)


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
