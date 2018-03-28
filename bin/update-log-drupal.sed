{
  s# +SECURITY UPDATE available$##g
  s# +Update available$##g
}

/^ Drupal +7\..+ +7\..+/ {
  s# +7\.# -> 7.#g
  s#^ Drupal -> #- Drupal #g

  i\
\
\# updated core:\
\

  a\
\
\# updated contrib modules:\
\

}

/^ [^(]+\(.+\) +7\.x-.+ +7\.x-.+/ {
  s# +7\.x-# -> #g
  s#\) -> #) #g
  s#^ #- #g
}
