#!/usr/bin/env bash
#
# output-year-index.sh - output markdown of winner links for a given year
#
# This tool is used in conjunction with the inc/md2html.cfg configuration
# file, and the tools that use that use that configuration file such as "bin/md2html.sh".
#
# It is usually invoked by:
#
#	-a bin/output-year-index.sh
#
# Copyright (c) 2024 by Landon Curt Noll.  All Rights Reserved.
#
# Permission to use, copy, modify, and distribute this software and
# its documentation for any purpose and without fee is hereby granted,
# provided that the above copyright, this permission notice and text
# this comment, and the disclaimer below appear in all of the following:
#
#       supporting documentation
#       source copies
#       source works derived from this source
#       binaries derived from this source or from derived source
#
# LANDON CURT NOLL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
# INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO
# EVENT SHALL LANDON CURT NOLL BE LIABLE FOR ANY SPECIAL, INDIRECT OR
# CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
# USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.
#
# chongo (Landon Curt Noll, http://www.isthe.com/chongo/index.html) /\oo/\
#
# Share and enjoy! :-)

# firewall - must be bash with a version 4.2 or later
#
# We must declare arrays with -ag or -Ag, and we need loops to "export" modified variables.
#
if [[ -z ${BASH_VERSINFO[0]} || ${BASH_VERSINFO[0]} -lt 4 || ${BASH_VERSINFO[0]} -eq 4 && ${BASH_VERSINFO[1]} -lt 2 ]]; then
    echo "$0: ERROR: bash version must be >= 4.2: $BASH_VERSION" 1>&2
    exit 4
fi

# setup bash file matching
#
# Requires bash with a version 4.2 or later
#
shopt -s nullglob	# enable expanded to nothing rather than remaining unexpanded
shopt -u failglob	# disable error message if no matches are found
shopt -u dotglob	# disable matching files starting with .
shopt -s globskipdots	# enable never matching . or ..
shopt -u nocaseglob	# disable strict case matching
shopt -u extglob	# enable extended globbing patterns
shopt -s globstar	# enable ** to match all files and zero or more directories and subdirectories

# set variables referenced in the usage message
#
export VERSION="1.0 2024-02-12"
NAME=$(basename "$0")
export NAME
export V_FLAG=0
GIT_TOOL=$(type -P git)
export GIT_TOOL
if [[ -z "$GIT_TOOL" ]]; then
    echo "$0: FATAL: git tool is not installed or not in \$PATH" 1>&2
    exit 210
fi
"$GIT_TOOL" rev-parse --is-inside-work-tree >/dev/null 2>&1
status="$?"
if [[ $status -eq 0 ]]; then
    TOPDIR=$("$GIT_TOOL" rev-parse --show-toplevel)
fi
export TOPDIR
export DOCROOT_SLASH="../../"
export REPO_URL="https://github.com/ioccc-src/temp-test-ioccc"
export SITE_URL="https://ioccc-src.github.io/temp-test-ioccc"

# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-n] [-N]
			[-p tool] [-u repo_url] [-U URL] [-w site_url] [-e string ..] [-E exitcode]
			YYYY [more_options]

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)
	-D docroot/	set the document root path followed by slash (def: $DOCROOT_SLASH)
			NOTE: 'docroot' must end in a slash

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	-p tool		run 'pandoc wrapper tool' (not pandoc path) during HTML phase number 21 (def: use $PANDOC_WRAPPER)

	-u repo_url	Base level URL of target git repo (def: $REPO_URL)
	-U url		URL of HTML file being formed (def: $URL)
	-w site_url	Base URL of the web site (def: $SITE_URL)

	-e string	output string, followed by newline, to stderr (def: do not)
	-E exitcode	force exit with exitcode (def: exit based on success or failure of the action)

	YYYY		path from topdir to year directory: must contain the files: README.md, .path and .entry.json
	[more_options]	additional tool command line options to use before the YYYY/dir argument

Exit codes:
     0         all OK
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is < 4.2
     5	       YYYY is not a year directory
     6	       subst.year-navbar.awk tool or pandoc wrapper not found
     7	       cannot find a non-empty or read .year file
     8	       entry under year YYYY is not in proper form
 >= 10  < 210  ((not used))
 >= 210	       internal tool error

$NAME version: $VERSION"

# output_award
#
# Write the award name to standard output (stdout)
#
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - until we have the jnamval command, we must FAKE PARSE the .entry.json file  - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
#
# usage:
#       output_award YYYY/dir/.entry.json
#
# returns:
#       0 ==> no errors detected, but output may be empty
#     > 0 ==> function error number
#
function output_award
{
    local ENTRY_JSON_PATH;     # the .entry.json path

    # parse args
    #
    if [[ $# -ne 1 ]]; then
        echo "$0: ERROR: in output_award: expected 1 arg, found $#" 1>&2
        return 1
    fi
    ENTRY_JSON_PATH="$1"
    if [[ ! -e $ENTRY_JSON_PATH ]]; then
        echo "$0: ERROR: in output_award: .entry.json does not exist: $ENTRY_JSON_PATH" 1>&2
        return 2
    fi
    if [[ ! -f $ENTRY_JSON_PATH ]]; then
        echo "$0: ERROR: in output_award: .entry.json is not a file: $ENTRY_JSON_PATH" 1>&2
        return 3
    fi
    if [[ ! -r $ENTRY_JSON_PATH ]]; then
        echo "$0: ERROR: in output_award: .entry.json is not a readable file: $ENTRY_JSON_PATH" 1>&2
        return 4
    fi

    # obtain the award string
    #
    AWARD=$(grep -F '"award" : "'  "$ENTRY_JSON_PATH" | sed -e 's/^.*"award" : "//' -e 's/",//')
    if [[ -z $AWARD ]]; then
	echo "$0: ERROR: in output_award: no award found in .entry.json file: $ENTRY_JSON_PATH" 1>&2
	return 5
    fi
    echo "$AWARD"
    return 0
}

# output_ordinal
#
# Write the numerical ordinal form of a non-negative integer to standard output (stdout)
#
# usage:
#       output_ordinal integer
#
# returns:
#       0 ==> no errors detected
#     > 0 ==> function error number
#
function output_ordinal
{
    local INTEGER;	# integer argument

    # parse args
    #
    if [[ $# -ne 1 ]]; then
        echo "$0: ERROR: in output_ordinal: expected 1 arg, found $#" 1>&2
        return 1
    fi
    INTEGER="$1"
    if [[ $INTEGER =~ ^-?[0-9]+$ ]]; then
	:
    else
	echo "$0: ERROR: argument is not an integer: $INTEGER" 1>&2
	return 2
    fi
    if [[ $INTEGER -lt 0 ]]; then
	echo "$0: ERROR: integer is negative: $INTEGER" 1>&2
	return 3
    fi

    # case: 11, 12, 13 are N-th
    #
    if [[ $INTEGER -ge 11 && $INTEGER -le 13 ]]; then
	echo "${INTEGER}th"

    # case: 1 mod 10 is N-st
    #
    elif [[ $((INTEGER % 10)) -eq 1 ]]; then
	echo "${INTEGER}st"

    # case: 2 mod 10 is N-nd
    #
    elif [[ $((INTEGER % 10)) -eq 2 ]]; then
	echo "${INTEGER}nd"

    # case: 3 mod 10 is N-rd
    #
    elif [[ $((INTEGER % 10)) -eq 3 ]]; then
	echo "${INTEGER}rd"

    # case: everything else is N-th
    #
    else
	echo "${INTEGER}th"
    fi
    return 0
}

# setup
#
export NOOP=
export DO_NOT_PROCESS=

# parse command line
#
while getopts :hv:Vd:D:nNp:u:U:w:e:E: flag; do
  case "$flag" in
    h) echo "$USAGE" 1>&2
	exit 2
	;;
    v) V_FLAG="$OPTARG"
	;;
    V) echo "$VERSION"
	exit 2
	;;
    d) TOPDIR="$OPTARG"
	;;
    D) # parse -D docroot/
	case "$OPTARG" in
	*/) ;;
	*) echo "$0: ERROR: in -D docroot/, the docroot must end in /" 1>&2
	   echo 1>&2
	   print_usage 1>&2
	   exit 3
	   ;;
	esac
	DOCROOT_SLASH="$OPTARG"
	;;
    n) NOOP="-n"
	;;
    N) DO_NOT_PROCESS="-N"
	;;
    p) PANDOC_WRAPPER="$OPTARG"
	;;
    u) REPO_URL="$OPTARG"
	;;
    U) URL="$OPTARG"
	;;
    w) SITE_URL="$OPTARG"
	;;
    e) echo "$OPTARG" 1>&2
	;;
    E) exit "$OPTARG"
	;;
    \?) echo "$0: ERROR: invalid option: -$OPTARG" 1>&2
	echo 1>&2
	print_usage 1>&2
	exit 3
	;;
    :) echo "$0: ERROR: option -$OPTARG requires an argument" 1>&2
	echo 1>&2
	echo "$USAGE" 1>&2
	exit 3
	;;
    *) echo "$0: ERROR: unexpected value from getopts: $flag" 1>&2
	echo 1>&2
	echo "$USAGE" 1>&2
	exit 3
	;;
  esac
done

# parse the command line arguments
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: debug level: $V_FLAG" 1>&2
fi
#
shift $(( OPTIND - 1 ));
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: file argument count: $#" 1>&2
fi
if [[ $# -ne 1 ]]; then
    echo "$0: ERROR: expected 1 arg, found: $#" 1>&2
    exit 3
fi
#
export YYYY="$1"
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: YYYY=$YYYY" 1>&2
fi
if [[ -z $YYYY ]]; then
    echo "$0: ERROR: YYYY arg is empty" 1>&2
    exit 3
fi

# verify that we have a topdir directory
#
REPO_NAME=$(basename "$REPO_URL")
export REPO_NAME
if [[ -z $TOPDIR ]]; then
    echo "$0: ERROR: cannot find top of git repo directory" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 211
fi
if [[ ! -e $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR does not exist: $TOPDIR" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 212
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR is not a directory: $TOPDIR" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 213
fi

# cd to topdir
#
if [[ ! -e $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to non-existent path: $TOPDIR" 1>&2
    exit 217
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to a non-directory: $TOPDIR" 1>&2
    exit 218
fi
export CD_FAILED
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: about to: cd $TOPDIR" 1>&2
fi
cd "$TOPDIR" || CD_FAILED="true"
if [[ -n $CD_FAILED ]]; then
    echo "$0: ERROR: cd $TOPDIR failed" 1>&2
    exit 219
fi
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: now in directory: $(/bin/pwd)" 1>&2
fi

# verify we have the pandoc wrapper
#
if [[ ! -e $PANDOC_WRAPPER ]]; then
    echo "$0: ERROR: pandoc wrapper tool does not exist: $PANDOC_WRAPPER" 1>&2
    exit 6
fi
if [[ ! -f $PANDOC_WRAPPER ]]; then
    echo "$0: ERROR: pandoc wrapper tool is not a file: $PANDOC_WRAPPER" 1>&2
    exit 6
fi
if [[ ! -x $PANDOC_WRAPPER ]]; then
    echo "$0: ERROR: pandoc wrapper tool is not an executable file: $PANDOC_WRAPPER" 1>&2
    exit 6
fi

# verify that YYYY is a entry directory
#
if [[ ! -d $YYYY ]]; then
    echo "$0: ERROR: arg is not a directory: $YYYY" 1>&2
    exit 5
fi
if [[ ! -r $YYYY ]]; then
    echo "$0: ERROR: arg is not a writable directory: $YYYY" 1>&2
    exit 5
fi

# verify we have a non-empty readable .top file
#
export TOP_FILE=".top"
if [[ ! -e $TOP_FILE ]]; then
    echo  "$0: ERROR: .top does not exist: $TOP_FILE" 1>&2
    exit 6
fi
if [[ ! -f $TOP_FILE ]]; then
    echo  "$0: ERROR: .top is not a regular file: $TOP_FILE" 1>&2
    exit 6
fi
if [[ ! -r $TOP_FILE ]]; then
    echo  "$0: ERROR: .top is not an readable file: $TOP_FILE" 1>&2
    exit 6
fi
if [[ ! -s $TOP_FILE ]]; then
    echo  "$0: ERROR: .top is not a non-empty readable file: $TOP_FILE" 1>&2
    exit 6
fi

# verify that YYYY has a non-empty readable .year file
#
export YEAR_FILE="$YYYY/.year"
if [[ ! -e $YEAR_FILE ]]; then
    echo  "$0: ERROR: YYYY/.year does not exist: $YEAR_FILE" 1>&2
    exit 7
fi
if [[ ! -f $YEAR_FILE ]]; then
    echo  "$0: ERROR: YYYY/.year is not a regular file: $YEAR_FILE" 1>&2
    exit 7
fi
if [[ ! -r $YEAR_FILE ]]; then
    echo  "$0: ERROR: YYYY/.year is not an readable file: $YEAR_FILE" 1>&2
    exit 7
fi
if [[ ! -s $YEAR_FILE ]]; then
    echo  "$0: ERROR: YYYY/.year is not a non-empty readable file: $YEAR_FILE" 1>&2
    exit 7
fi

# determine The N-th IOCCC string
#
LINE_NUM=$(sed -n "/$YYYY/=" "$TOP_FILE" | head -1)
if [[ -z $LINE_NUM ]]; then
    echo  "$0: ERROR: cannot determine line number in $TOP_FILE for year: $YYYY" 1>&2
    exit 220
fi
ORDINAL=$(output_ordinal "$LINE_NUM")
export ORDINAL
if [[ -z $ORDINAL ]]; then
    echo  "$0: ERROR: cannot determine ordinal for: $LINE_NUM" 1>&2
    exit 221
fi

# parameter debugging
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: VERSION=$VERSION" 1>&2
    echo "$0: debug[3]: NAME=$NAME" 1>&2
    echo "$0: debug[3]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[3]: GIT_TOOL=$GIT_TOOL" 1>&2
    echo "$0: debug[3]: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[3]: DOCROOT_SLASH=$DOCROOT_SLASH" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: URL=$URL" 1>&2
    echo "$0: debug[3]: SITE_URL=$SITE_URL" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: YYYY=$YYYY" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: TOP_FILE=$TOP_FILE" 1>&2
    echo "$0: debug[3]: YEAR_FILE=$YEAR_FILE" 1>&2
    echo "$0: debug[3]: LINE_NUM=$LINE_NUM" 1>&2
    echo "$0: debug[3]: ORDINAL=$ORDINAL" 1>&2
fi

# If -N, time to exit
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: arguments parsed, -N given, exit 0" 1>&2
    fi
    exit 0
fi

# create a temporary markdown for pandoc to process
#
TMP_FILE=".$NAME.$$.md"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary markdown file: $TMP_FILE" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
    rm -f "$TMP_FILE"
    if [[ -e $TMP_FILE ]]; then
	echo "$0: ERROR: cannot remove temporary markdown file: $TMP_FILE" 1>&2
	exit 227
    fi
    :> "$TMP_FILE"
    if [[ ! -e $TMP_FILE ]]; then
	echo "$0: ERROR: cannot create temporary markdown file: $TMP_FILE" 1>&2
	exit 228
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary markdown file is not used: $TMP_FILE" 1>&2
fi

# output leading markdown for this IOCCC year
#
{
    echo "# <a name=inventory></a><a name=$YYYY></a>Winning Entries of $YYYY - The $ORDINAL IOCCC"
    echo
    echo "**Download IOCCC** [$YYYY entry source]($YYYY/ioccc.$YYYY.tar.bz2)"
    echo
} | if [[ -z $NOOP ]]; then
    cat >> "$TMP_FILE"
else
    cat > /dev/null
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: because of -n, IOCCC year $YYYY starting markdown not written to stdout" 1>&2
    fi
fi

# process each entry under YYYY
#
export YYYY_DIR
for YYYY_DIR in $(< "$YEAR_FILE"); do

    # debug YYYY
    #
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: starting to process year/dir: $YYYY_DIR" 1>&2
    fi

    # parse YYYY_DIR
    #
    if [[ ! -d $YYYY_DIR ]]; then
	echo "$0: ERROR: YYYY_DIR is not a directory: $YYYY_DIR" 1>&2
	exit 8
    fi
    if [[ ! -w $YYYY_DIR ]]; then
	echo "$0: ERROR: YYYY_DIR is not a writable directory: $YYYY_DIR" 1>&2
	exit 8
    fi
    export YEAR_DIR=${YYYY_DIR%%/*}
    if [[ -z $YEAR_DIR ]]; then
	echo "$0: ERROR: YYYY_DIR not in YYYY/dir form: $YYYY_DIR" 1>&2
	exit 8
    fi
    export ENTRY_DIR=${YYYY_DIR#*/}
    if [[ -z $ENTRY_DIR ]]; then
	echo "$0: ERROR: YYYY_DIR not in $YEAR_DIR/dir form: $YYYY_DIR" 1>&2
	exit 8
    fi
    if [[ $ENTRY_DIR = */* ]]; then
	echo "$0: ERROR: YYYY_DIR: $YYYY_DIR dir contains a /: $ENTRY_DIR" 1>&2
	exit 8
    fi

    # verify that YYYY_DIR is a writable directory
    #
    if [[ ! -e $YYYY_DIR ]]; then
	echo  "$0: ERROR: YYYY_DIR does not exist: $YYYY_DIR" 1>&2
	exit 8
    fi
    if [[ ! -d $YYYY_DIR ]]; then
	echo  "$0: ERROR: YYYY_DIR is not a directory: $YYYY_DIR" 1>&2
	exit 8
    fi
    if [[ ! -w $YYYY_DIR ]]; then
	echo  "$0: ERROR: YYYY_DIR is not an writable directory: $YYYY_DIR" 1>&2
	exit 8
    fi

    # verify YYYY/dir/.path
    #
    export DOT_PATH="$YYYY_DIR/.path"
    if [[ ! -s $DOT_PATH ]]; then
	echo "$0: ERROR: not a non-empty file: $DOT_PATH" 1>&2
	exit 8
    fi
    DOT_PATH_CONTENT=$(< "$DOT_PATH")
    if [[ $YYYY_DIR != "$DOT_PATH_CONTENT" ]]; then
	echo "$0: ERROR: arg: $YYYY_DIR does not match $DOT_PATH contents: $DOT_PATH_CONTENT" 1>&2
	exit 8
    fi
    export ENTRY_JSON="$YYYY_DIR/.entry.json"
    if [[ ! -e $ENTRY_JSON ]]; then
	echo "$0: ERROR: .entry.json does not exist: $ENTRY_JSON" 1>&2
	exit 8
    fi
    if [[ ! -f $ENTRY_JSON ]]; then
	echo "$0: ERROR: .entry.json is not a file: $ENTRY_JSON" 1>&2
	exit 8
    fi
    if [[ ! -r $ENTRY_JSON ]]; then
	echo "$0: ERROR: .entry.json is not a readable file: $ENTRY_JSON" 1>&2
	exit 8
    fi

    # determine the award for this entry
    #
    AWARD=$(output_award "$ENTRY_JSON")
    if [[ -z $AWARD ]]; then
	echo "$0: ERROR: cannot find award in .entry.json: $ENTRY_JSON" 1>&2
	exit 8
    fi

    # output markdown for this entry
    #
    echo "* [$YYYY_DIR]($YYYY_DIR/index.html) - $AWARD"
done | if [[ -z $NOOP ]]; then
    cat >> "$TMP_FILE"
else
    cat > /dev/null
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: because of -n, $YYYY entry markdown data is NOT written to stdout" 1>&2
    fi
fi

# write trailing markdown for this IOCCC year
#
{
    echo
    echo '&nbsp;**Jump to:** [top](#)'
    echo
} | if [[ -z $NOOP ]]; then
    cat >> "$TMP_FILE"
else
    cat > /dev/null
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: because of -n, IOCCC year $YYYY ending markdown data is NOT to stdout" 1>&2
    fi
fi

# convert temporary markdown file into HTML
#
if [[ -z $NOOP ]]; then
    echo "<!-- START: this line starts content generated by: bin/$NAME -->"
    echo
    if [[ $V_FLAG -ge 1 ]]; then
	echo  "$0: debug[1]: about to execute: $PANDOC_WRAPPER $TMP_FILE -" 1>&2
    fi
    "$PANDOC_WRAPPER" "$TMP_FILE" -
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: pandoc failed, error: $status" 1>&2
	exit 231
    fi
    echo
    echo "<!-- END: next line ends content generated by: bin/$NAME -->"
elif [[ $V_FLAG -ge 1 ]]; then
    echo  "$0: debug[1]: -n disabled execution of: $PANDOC_WRAPPER $TMP_FILE -" 1>&2
fi

# All Done!!! -- Jessica Noll, Age 2
#
if [[ -z $NOOP ]]; then
    rm -f "$TMP_FILE"
elif [[ $V_FLAG -ge 1 ]]; then
    echo  "$0: debug[1]: -n disabled execution of: rm -f $TMP_FILE" 1>&2
fi
exit 0