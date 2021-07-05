#!/usr/bin/env bash

python3 -c 'import random, string; print("".join(random.choices(string.digits + string.ascii_letters, k=32)))'
