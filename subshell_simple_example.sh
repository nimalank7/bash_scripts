#!/bin/bash

# If we added set -eux it would stop at (exit 1)

# Since the parent shell doesn't explicitly check the status the script continues
(exit 1)
echo "Script continues"

# Code continues because the exit status isn't explicitly checked
false || (echo Failed to download one or more files.; exit 1)


if (exit 1); then
    echo "Success"
else
    # This is the output
    echo "Failure"
fi