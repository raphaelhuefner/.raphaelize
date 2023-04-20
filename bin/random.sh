#!/usr/bin/env bash

python3 -c 'import random, string, sys; print("".join(random.choices(string.digits + string.ascii_letters, k=int(sys.argv[1]) if len(sys.argv)==2 else 128)))' $1
