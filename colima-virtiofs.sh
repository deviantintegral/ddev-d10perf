#!/bin/bash

colima start --cpu 4 --memory 4 --mount-type virtiofs --vm-type vz
ddev config global --performance-mode=none
ddev start
