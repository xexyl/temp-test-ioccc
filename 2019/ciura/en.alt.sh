#!/usr/bin/env bash
set -x
./getwords.sh en | grep .. | ./prog.alt abcdefghijklmnopqrstuvwxyz
