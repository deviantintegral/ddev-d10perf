#!/bin/bash

# Stop all Docker providers if they are running.
colima stop || true
orb stop || true

# Remove any stale state files in case benchmarking crashed.
rm -f state/*
