#!/bin/bash

xattr -r -d com.apple.metadata:kMDItemWhereFroms .
xattr -r -d com.apple.quarantine .
