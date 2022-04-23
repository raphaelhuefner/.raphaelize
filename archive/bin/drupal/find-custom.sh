#!/bin/bash

find ~/projects/affinity/ -path "*modules/custom*" -or -path "*modules/features*" -exec grep -RHniE "$1" "{}" ';'


