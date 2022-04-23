#!/bin/bash

# use find to exclude symlinks (this is the default, include symlinks by using
# the option -follow or -L ) and .svn directories (-not -path "*.svn*")
# grep -H == show filename
# grep -n == show linenumber
# grep -E "pattern"
# find replaces "{}" by filename 
# find needs ";" to delimit -exec command options, its mandatory for -exec

#find ~/projects/schuelerprofile.de/ -not -path "*.svn*" -exec grep -H -n -E "\WCONFIG[^_]" "{}" ";" 

find /var/www/vhosts/r.huefner/projects/s3/ -not -path "*.svn*" -exec grep -H -n -E "(^|\W)Unister_Classes_Class_CacheWrapper1(\W|$)" "{}" ";"



