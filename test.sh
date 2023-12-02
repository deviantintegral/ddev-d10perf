#!/bin/bash

set -e

# Ensure we have a clean start in case we killed the test run.
./cleanup.sh

# We add the echo just so we can easily see which result is which.
hyperfine --export-csv=results.csv --setup './setup.sh' \
  'echo colima-mutagen; ddev drush site:install demo_umami -y' \
  'echo colima-virtiofs; ddev drush site:install demo_umami -y' \
  'echo orb-mutagen; ddev drush site:install demo_umami -y' \
  'echo orb-virtiofs; ddev drush site:install demo_umami -y'

# We don't use --cleanup in hyperfine because that runs after every test run.
./cleanup.sh
