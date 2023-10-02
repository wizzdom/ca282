#!/usr/bin/zsh

# Explanation.
#
# This script unpacks your git bundle and then verifies various properties of
# the resulting files.
#
# The expect directory/file hierarchy is:
#    ca282
#    ca282/week-01
#    ca282/week-01/wk1-find-all-empty-files.sh
#    ca282/week-01/wk1-find-all-files.sh
#    ca282/week-01/wk1-untar-again.sh
#    ca282/week-01/hello.sh
#    ca282/week-02
#    ca282/week-02/wk2-echo-arguments.sh
#    ca282/week-02/wk2-first-non-file.sh
#
# Additional files may be present, they will not interfere with these tests.
#
# There are sample solutions for each of the required tasks on the course
# web site:
#
#    https://ca282.computing.dcu.ie/einstein/solutions.html?student
#
# The name of your git bundle must be git-weeks-1-and-2.bundle.
#
# The name of your actual repo is ignored.
#
# This is a zsh script, and depends upon a couple of zsh-specific features:
#   - "print" is just like "echo"
#   - "print -l" prints each argument *on a new line*
#
#  "execute", below, is a shell function; it runs a command and exits with a message
#  if it fails

execute ()
{
   print -- '  $' $argv >&2
   if ! $argv
   then
      print "  failed!"
      false
   fi
}

# This just checks that you don't have uncommited work.  If you have uncommited work. then
# you really don't want to be running this script.
#
if [[ -n $( git status -s ) ]]
then
   print "error: you have uncommitted work"
   print "       refusing to run"
   exit
fi >&2

# ########################################################################
# ADDED (20/1020 @ 20:00)
#
# Some people are encountering errors which seem to arise for files which were copied
# from a Windows machine.
#
# Here, we try to fix those files.
if which dos2unix > /dev/null
then
   find * -type f | xargs dos2unix -q
fi

# Exit with an error if any of these commands fail.
set -e

# Redirect stderr to stdout.
# This will make the output easier to follow on Einstein.
exec 2>&1

# The main branch can be called either "master" or "main".
#
print "verify master (or main) branch..."
execute git checkout --quiet master ||
  execute git checkout --quiet main

print -l "" "verify ca282 directory..."
execute test -d ca282

print -l "" "enter ca282 directory..."
execute cd ca282

for dir in week-01 week-02
do
   print -l "" "verify $dir directory..."
   execute test -d $dir
done

print -l "" "enter week-01 directory..."
execute cd week-01

print -l "" "verify four of the week 1 tasks exist..."
for file in hello.sh wk1-find-all-files.sh wk1-find-all-empty-files.sh wk1-untar-again.sh
do
   print -l "" "verify $file exists and is non-empty..."
   execute test -f $file
   execute test -s $file
done

print -l "" "test hello.sh..."
execute sh hello.sh | sed 's/^/  |/'

print -l "" "test find-all-files.sh..."
mkdir t
date > t/date.txt
true > t/empty.txt
(
   cd t
   sh ../wk1-find-all-files.sh | sort | sed 's/^/  |/'
)

print -l "" "test find-all-empty-files.sh..."
(
   cd t
   sh ../wk1-find-all-empty-files.sh | sort | sed 's/^/  |/'
)

print -l "" "enter week 2 directory (../week-02)..."
execute cd ../week-02

print -l "" "verify two of the week 2 tasks exist..."

for file in wk2-echo-arguments.sh wk2-first-non-file.sh
do
   print -l "" "verifying $file exists and is non-empty..."
   execute test -f $file
   execute test -s $file
done

print -l "" "test echo-arguments.sh..."
execute sh wk2-echo-arguments.sh dog cat mouse "snow leopard"

print -l "" "test first-non-file.sh..."
print -l /etc/passwd /var /home | execute sh wk2-first-non-file.sh | sed 's/^/  |/'
