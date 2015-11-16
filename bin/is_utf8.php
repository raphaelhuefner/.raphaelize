#!/usr/bin/php
<?php
// @see: http://www.php.net/manual/en/function.utf8-encode.php
// @see: http://www.php.net/manual/en/function.utf8-encode.php#85866

/**
 * Returns true if $string is valid UTF-8 and false otherwise.
 *
 * @since        1.14
 * @param [mixed] $string     string to be tested
 * @subpackage
 */
function is_utf8($string) 
{
    // From http://w3.org/International/questions/qa-forms-utf-8.html
    $string = preg_replace('/[\x09\x0A\x0D\x20-\x7E]/', '', $string); // filter out plain ASCII
    return preg_match('%^(?:
          [\xC2-\xDF][\x80-\xBF]             # non-overlong 2-byte
        |  \xE0[\xA0-\xBF][\x80-\xBF]        # excluding overlongs
        | [\xE1-\xEC\xEE\xEF][\x80-\xBF]{2}  # straight 3-byte
        |  \xED[\x80-\x9F][\x80-\xBF]        # excluding surrogates
        |  \xF0[\x90-\xBF][\x80-\xBF]{2}     # planes 1-3
        | [\xF1-\xF3][\x80-\xBF]{3}          # planes 4-15
        |  \xF4[\x80-\x8F][\x80-\xBF]{2}     # plane 16
    )*$%xs', $string);
}

$filename = $_SERVER['argv'][1];
$input = file_get_contents($filename);
if (is_utf8($input)) {
    echo 'valid utf8: ' . $filename . PHP_EOL;
    exit(0);
} else {
    echo 'no utf8: ' . $filename . PHP_EOL;
    exit(1);
}
