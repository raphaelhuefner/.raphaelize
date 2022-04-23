#!/bin/bash

php -r '$df=get_defined_functions();$df=$df["internal"];sort($df);foreach($df as $d) print $d . "\n";'

