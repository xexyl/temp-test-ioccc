#!/usr/bin/env make
#
# IOCCC 2001 winning entry - anonymous

################################################################################
#
# IOCCC winning entry code may not work on your system.  What was liked/allowed
# and worked in the past may no longer be liked/allowed or compile/run today.
#
# Bug fixes, corrections and typo fixes are VERY WELCOME.  If you see a problem,
# first check this URL for a list of known bugs and (mis)features of IOCCC entries:
#
#	https://www.ioccc.org/bugs.html
#
# GitHub pull requests are welcome!  Please see the above URL for details.
#
################################################################################
#
# This file is Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
# You are free to share and adapt this file under the terms of this license:
#
#	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
#
# For more information, see: https://creativecommons.org/licenses/by-sa/4.0/


#############################
# shell used by this Makefile
#############################
#
SHELL= bash

#######################
# common tool locations
#######################
#
include ../../var.mk

# Common C compiler warnings to silence
#
CSILENCE= -Wno-bitwise-conditional-parentheses -Wno-error \
	  -Wno-implicit-function-declaration -Wno-implicit-int \
	  -Wno-int-to-pointer-cast -Wno-macro-redefined -Wno-pedantic \
	  -Wno-pointer-to-int-cast -Wno-return-type -Wno-string-plus-int \
	  -Wno-bitwise-op-parentheses -Wno-format -Wno-format-extra-args \
	  -Wno-int-conversion -Wno-unused-parameter -Wno-unsequenced \
	  -Wno-deprecated-non-prototype -Wno-unused-value \
	  -Wno-maybe-uninitialized -Wno-parentheses

# Attempt to silence unknown warnings
#
CUNKNOWN= -Wno-unknown-warning-option

# Common C compiler warning flags
#
CWARN= -Wall -Wextra ${CSILENCE} ${CUNKNOWN}

# Compiler standard
#
CSTD= -std=gnu99

# Compiler bit architecture
#
ARCH=

# Defines that are needed to compile
#
CDEFINE=

# Include files that are needed to compile
#
CINCLUDE=

# Optimization
#
OPT= -O3

# Default flags for ANSI C compilation
#
CFLAGS= ${CSTD} ${CWARN} ${ARCH} ${CDEFINE} ${CINCLUDE} ${OPT}

# Libraries needed to build
#
LDFLAGS=

# C compiler to use
#
CC= cc

# Compiler add-ons or replacements for clang only
#
ifeq "$(findstring $(CLANG),${CC})" "$(CLANG)"
#
CSILENCE+= -Wno-bad-function-cast -Wno-comma -Wno-format-nonliteral \
	   -Wno-missing-prototypes -Wno-missing-variable-declarations \
	   -Wno-poison-system-directories -Wno-shadow -Wno-strict-prototypes \
	   -Wno-unused-macros -Wno-shorten-64-to-32 -Wno-sign-conversion \
	   -Wno-unsafe-buffer-usage
#
CWARN+= -Weverything
#
endif

# Specific add-ons or replacements for gcc only
#
ifeq "$(findstring $(GCC),${CC})" "$(GCC)"
#
#CSILENCE+=
#
#CWARN+=
#
endif


##############################
# Special Makefile variables for this entry
##############################
#
ENTRY= anonymous
PROG= ${ENTRY}
#
OBJ= ${PROG}.o
DATA=
TARGET= ${PROG} ${PROG}.ten ${PROG}.ten.alt ${PROG}.bed ${PROG}.bed.alt
#
ALT_OBJ= ${PROG}.ten.alt.o ${PROG}.bed.alt.o
ALT_TARGET= ${PROG}.ten.alt ${PROG}.bed.alt


#################
# build the entry
#################
#
all: data ${TARGET}
	@${TRUE}

.PHONY: all alt data everything diff_orig_prog diff_prog_orig \
	diff_alt_prog diff_prog_alt diff_orig_alt diff_alt_orig \
	clean clobber install love haste waste maker easter_egg \
	sandwich supernova deep_magic magic charon pluto

${PROG}: ${PROG}.c
	magic='${CC} ${CFLAGS}'; \
	X='-DA(X)=#X'; \
	warning='-Dprocessor'; \
	$$magic $$warning -Dmagic= $$X "-DX=A($$magic \"$$X\")" \
		$< -o $@ ${LDFLAGS}


${PROG}.ten: ${PROG}.ten.c
	@echo "Warning: ${PROG}.ten.c must be compiled as a 32-bit ELF binary to use with"
	@echo "the entry itself; this is because the program works on 32-bit ELF binaries."
	@echo "If you cannot use -m32 or it cannot compile for some other reason this will"
	@echo "NOT work!"
	@echo
	@echo "If you want to use this program where this is not possible e.g. with a Mac,"
	@echo "say to use by itself, try:"
	@echo
	@echo "	    make anonymous.ten.alt"
	@echo
	@echo "but running ${PROG} on the resulting binary will crash. The build of"
	@echo "anonymous.ten.alt is done automatically in case anonymous.ten fails to"
	@echo "compile. Nevertheless again the entry will not work with it."
	@echo
	${CC} ${CFLAGS} -m32 $< -o $@ ${LDFLAGS} || ${MAKE} ${PROG}.ten.alt

${PROG}.ten.alt: ${PROG}.ten.c
	@echo
	@echo "Warning: the file created by this rule, ${PROG}.ten.alt, will NOT work with"
	@echo "the entry itself; this is because it works ONLY on 32-bit ELF binaries! This"
	@echo "however at least lets you see the supplementary program in action:"
	@echo
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}
	@echo

${PROG}.bed: ${PROG}.bed.c
	@echo "Warning: ${PROG}.bed.c must be compiled as a 32-bit ELF binary to use with"
	@echo "the entry itself; this is because the program works on 32-bit ELF binaries."
	@echo "If you cannot use -m32 or it cannot compile for some other reason this will"
	@echo "NOT work!"
	@echo
	@echo "If you want to use this program where this is not possible e.g. with a Mac,"
	@echo "say to use by itself, try:"
	@echo
	@echo "	    make anonymous.bed.alt"
	@echo
	@echo "but running ${PROG} on the resulting binary will crash. The build of"
	@echo "anonymous.bed.alt is done automatically in case anonymous.bed fails to"
	@echo "compile. Nevertheless again the entry will not work with it."
	@echo
	${CC} ${CFLAGS} -m32 $< -o $@ ${LDFLAGS} || ${MAKE} ${PROG}.bed.alt

${PROG}.bed.alt: ${PROG}.bed.c
	@echo
	@echo "Warning: the file created by this rule, ${PROG}.bed.alt, will NOT work with"
	@echo "the entry itself; this is because it works ONLY on 32-bit ELF binaries! This"
	@echo "however at least lets you see the supplementary program in action:"
	@echo
	${CC} ${CFLAGS} $< -o $@ ${LDFLAGS}
	@echo


# alternative executable
#
alt: data ${ALT_TARGET}
	@${TRUE}

# data files
#
data: ${DATA}
	@${TRUE}

# both all and alt
#
everything: all alt
	@${TRUE}


#####################
# make a difference #
#####################
#
# diff orig source and source
#
diff_orig_prog: ${PROG}.orig.c ${PROG}.c
	@-${DIFF} -u ${PROG}.orig.c ${PROG}.c

# diff source and orig source
#
diff_prog_orig: ${PROG}.c ${PROG}.orig.c
	@-${DIFF} -u ${PROG}.c ${PROG}.orig.c

# diff alt source and source
#
diff_alt_prog: ${PROG}.c
	@-if [[ -e ${PROG}.alt.c ]]; then \
	    ${DIFF} -u ${PROG}.alt.c ${PROG}.c; \
	fi

# diff source and alt source
#
diff_prog_alt: ${PROG}.c
	@-if [[ -e ${PROG}.alt.c ]]; then \
	    ${DIFF} -u ${PROG}.c ${PROG}.alt.c; \
	fi

# diff orig and alt
#
diff_orig_alt: ${PROG}.orig.c
	@-if [[ -e ${PROG}.alt.c ]]; then \
	    ${DIFF} -u ${PROG}.orig.c ${PROG}.alt.c; \
	fi

# diff alt and orig
diff_alt_orig:
	@-if [[ -e ${PROG}.alt.c ]]; then \
	    ${DIFF} -u ${PROG}.alt.c ${PROG}.orig.c; \
	fi


###############
# utility rules
###############
#
clean:
	${RM} -f ${OBJ} ${ALT_OBJ}
	@-if [ -f indent.c ]; then \
	    echo ${RM} -f indent.c; \
	    ${RM} -f indent.c; \
	fi

clobber: clean
	${RM} -f ${TARGET} ${ALT_TARGET}
	${RM} -rf *.dSYM
	${RM} -f anonymous.ten.bak ten.od ten.od.bak ten.txt ten.bak.txt
	@-if [ -e sandwich ]; then \
	    ${RM} -f sandwich; \
	    echo 'ate sandwich'; \
	fi

install:
	@echo "Dr. Spock says that is not logical!"
	@${TRUE}

# you may be able to misunderstand the source by reading indent.c
#
indent.c: ${PROG}.c
	@if which "${GINDENT}" >/dev/null 2>&1; then \
	    echo ${RM} -f $@; \
	    ${RM} -f $@; \
	    echo "${GINDENT} < $< > $@"; \
	    ${GINDENT} < $< > $@; \
	elif which "${INDENT}" >/dev/null 2>&1; then \
	    echo ${RM} -f $@; \
	    ${RM} -f $@; \
	    echo "${INDENT} < $< > $@"; \
	    ${INDENT} < $< > $@; \
	else \
	    echo "no indent tool found, ident $< yourself, sorry"; \
	    echo "exit 17"; \
	    exit 17; \
	fi


######################################
# optional include of 1337 hacker rulz
######################################

-include 1337.mk ../1337.mk ../../1337.mk
