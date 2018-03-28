#!/bin/bash

sed -E -f ~/bin/update-log-wordpress.sed < /dev/stdin > ~/tmp/out.txt

cat ~/tmp/out.txt

# echo "| akismet                        | 3.3.1       | 3.3.2       | Updated |" | sed -E -f ~/bin/update-log-wordpress.sed

# | akismet                        | 3.3.1       | 3.3.2       | Updated |
# | google-analytics-for-wordpress | 6.1.7       | 6.1.10      | Updated |
# | js_composer                    | 4.12        | 5.0.1       | Updated |
# | wordpress-seo                  | 4.7         | 4.8         | Updated |
