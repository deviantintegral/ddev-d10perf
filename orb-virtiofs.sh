#!/bin/bash

orb config set memory_mib 4096
orb config set cpu 4
orb start

sleep 5

ddev config global --performance-mode=none
ddev start
