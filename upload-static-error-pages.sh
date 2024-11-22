#!/bin/bash
set -eux

ERROR_PAGES='400 401 403 404 405 406 410 422 429 500 502 503 504'

# Replaces spaces in ERROR_PAGES with commas using parameter expansion
# Result is 400,401,403,404,405
ERROR_PAGES_COMMA_SEPARATED=${ERROR_PAGES// /,}
OUTPUT_PATH=/tmp/output
SERVICE=frontend

# Create directory if it doesn't exist
mkdir -p "${OUTPUT_PATH}"
cd "${OUTPUT_PATH}"

# Saves each downloaded as 400.html, 401.html where #1 corresponds to each iteration
curl --fail-early -fo '#1.html' "${SERVICE}/templates/{${ERROR_PAGES_COMMA_SEPARATED}}.html.erb"

# eval expands the command to list all downloaded files (e.g. ls 400.html 401.html...504.html)
# || is logical OR to specify a fallback action if the command fails
# Here (...) creates a subshell - {...} executes it in the current shell
# Subshell exit status is determined by the exit status of the last command run so here
# it runs 'exit 1' which means the subshell fails. Since set -eux is set the entire command fails
eval ls "{$ERROR_PAGES_COMMA_SEPARATED}.html" || (echo Failed to download one or more files.; exit 1)


aws s3 sync . "s3://govuk-app-assets-${GOVUK_ENVIRONMENT}/error_pages/"
