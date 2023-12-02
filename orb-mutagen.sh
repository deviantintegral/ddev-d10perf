#!/bin/bash

orb config set memory_mib 3096
orb config set cpu 4
orb start

sleep 5

ddev config global --performance-mode=mutagen
ddev start
