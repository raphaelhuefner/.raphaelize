#!/usr/bin/env -S uv run --script

# /// script
# requires-python = ">=3.14"
# dependencies = []
# ///

from secrets import choice
from string import ascii_letters, digits
from sys import argv


def main() -> None:
    length = int(argv[1]) if len(argv)==2 else 256
    abc = digits + ascii_letters
    print("".join(choice(abc) for _ in range(length)))


if __name__ == "__main__":
    main()
