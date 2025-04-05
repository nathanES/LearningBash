#!/bin/bash
filename=$1
filename=${filename:?"missing"}
howmany=${2:-10}
sort -nr $filename | head -$howmany
