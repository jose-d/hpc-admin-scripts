#!/bin/bash

node=$1

for job in $(squeue --noheader --nodelist=${node} | awk {'print $1'} | xargs); do echo "------------"; echo "${job}"; scontrol show job=${job} | grep Time ; done
