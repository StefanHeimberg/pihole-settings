#!/bin/bash
cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2