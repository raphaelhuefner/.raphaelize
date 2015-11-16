#!/usr/bin/python

"""filter log files"""

import fileinput
import re

class RhFilter:
    """my filter"""

    #firstLogLinePattern = '^20\\d\\d-[0-1]\\d-[0-3]\\dT[0-2]\\d:[0-5]:\\d\\d[-+]\\d\\d:\\d\\d '
    firstLogLinePattern = '^20[0-9][0-9]-[0-1][0-9]-[0-3][0-9]T[0-2][0-9]:[0-5][0-9]:[0-6][0-9][-+][0-9][0-9]:[0-9][0-9]'

    blockerPatterns = [
        "to use near 'AND ImageUrl != ''$",
        "syntax to use near 'GROUP BY sh.id$",
        "Invalid controller specified",
        "SQLSTATE\[HY000\]: General error: 2053",
        "The session was explicitly destroyed during this request",
        "Unknown column 'members.hasPicture' in 'where clause'",
        "syntax to use near 'Preis",
        "FROM (category|product) ORDER BY (City|product.Name|Country|Area) desc LIMIT 0,3",
        "Category_Id =  AND ImageUrl != "
    ]

    def __init__(self):
        self.firstLogLineRegexp = re.compile(self.firstLogLinePattern)
        self.blockerRegexps = []
        for blocker in self.blockerPatterns:
            self.blockerRegexps.append(re.compile(blocker))
        self.emptyBuffer()

    def emptyBuffer(self):
        self.buffer = []

    def filter(self):
        for line in fileinput.input():
            if self.isFirstLogLine(line):
                if not self.isBufferBlocked():
                    self.outputBuffer()
                self.emptyBuffer()
            self.buffer.append(line)

    def outputBuffer(self):
        for line in self.buffer:
            print line,    

    def isFirstLogLine(self, line):
        return None != self.firstLogLineRegexp.search(line)        

    def isLineBlocked(self, line):
        for blocker in self.blockerRegexps:
            if None != blocker.search(line):
                return True
        return False                

    def isBufferBlocked(self):
        for line in self.buffer:
            if self.isLineBlocked(line):
                return True
        return False                




if __name__ == "__main__":
    filter = RhFilter()
    filter.filter()

