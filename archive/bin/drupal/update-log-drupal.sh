#!/bin/bash

sed -E -f ~/bin/update-log-drupal.sed < /dev/stdin > ~/tmp/out.txt

cat ~/tmp/out.txt

# echo " Drupal                                   7.53               7.54              Update available" | sed -E -f ~/bin/update-log-drupal.sed
# echo " References (references)                  7.x-2.1            7.x-2.2           SECURITY UPDATE available" | sed -E -f ~/bin/update-log-drupal.sed

 # Drupal                                   7.53               7.54              Update available
 # Chaos tools (ctools)                     7.x-1.11           7.x-1.12          Update available
 # CAPTCHA (captcha)                        7.x-1.3            7.x-1.4           Update available
 # Date (date)                              7.x-2.9            7.x-2.10          Update available
 # Field collection (field_collection)      7.x-1.0-beta11     7.x-1.0-beta12    Update available
 # FillPDF (fillpdf)                        7.x-1.10           7.x-1.11          Update available
 # Google Tag Manager (google_tag)          7.x-1.0            7.x-1.2           Update available
 # References (references)                  7.x-2.1            7.x-2.2           SECURITY UPDATE available
 # Token (token)                            7.x-1.6            7.x-1.7           Update available
 # Views (views)                            7.x-3.15           7.x-3.16          Update available
 # Webform (webform)                        7.x-4.14           7.x-4.15          Update available
 # Webform Validation (webform_validation)  7.x-1.11           7.x-1.13          Update available
 # Wysiwyg (wysiwyg)                        7.x-2.2            7.x-2.4           Update available
