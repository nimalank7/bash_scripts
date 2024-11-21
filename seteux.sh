#!/bin/bash
# -e means exit on error if any command exits with a non-zero status
# -u treats unset variables as errors
# -x prints commands as they are executed


set -eux

# Example script
echo "This is a test script."

# Attempt to use an undefined variable which terminates the script
echo $UNDEFINED_VAR

# This line won't execute because the script exits on the previous error
echo "This will not be printed."

# Script output:
# + echo 'This is a test script.'
# This is a test script.
# ./seteux.sh: line 8: UNDEFINED_VAR: unbound variable
