#!/bin/bash
outfile=${filename%.pcx}.jpg # looks for pcx on the end of the string. If it's found it's stripped off and the rest of the string is return. If no match, nothing is deleted
