#!/bin/bash

set -e

# A directory to store which test case we are on.
# We need some way to pass state between each test run. This allows us to use
# --setup in our hyperfine command, which ensures that setup steps aren't
# counted in the timings.
mkdir -p state

# This set of test cases starts with the else at the end and then goes through
# each test case from here down.
if [ -f state/colima-mutagen ]; then
  echo '******* Testing colima-virtiofs ********'
  echo '****************************************'
  echo '****************************************'

  ddev config global --performance-mode=none
  ddev start

  rm state/colima-mutagen
  touch state/colima-virtiofs
elif [ -f state/colima-virtiofs ]; then
  echo '******* Testing orb-mutagen ********'
  echo '************************************'
  echo '************************************'
  colima stop
  orb config set memory_mib 4096
  orb config set cpu 4
  orb start

  # ddev fails out if we don't wait, perhaps orb start is a bit async?
  sleep 5

  ddev config global --performance-mode=mutagen
  ddev start

  rm state/colima-virtiofs
  touch state/orb-mutagen
elif [ -f state/orb-mutagen ]; then
  echo '******* Testing orb-virtiofs *******'
  echo '************************************'
  echo '************************************'

  ddev config global --performance-mode=none
  ddev start

  rm state/orb-mutagen
  touch state/orb-virtiofs
elif [ -f state/orb-virtiofs ]; then
  # We're done! This isn't actually called by hyperfine.
  orb stop
else
  echo '******* Testing colima-mutagen *******'
  echo '**************************************'
  echo '**************************************'

  colima start --cpu 4 --memory 4 --mount-type virtiofs --vm-type vz
  ddev config global --performance-mode=mutagen
  ddev start
  ddev composer install

  touch state/colima-mutagen
fi
