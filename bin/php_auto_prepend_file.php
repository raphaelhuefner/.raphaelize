<?php

if (! function_exists('rh')) {
  function rh() {
    $kint_file = '/Users/raphael/kint/Kint.class.php';
    if (is_readable($kint_file)) {
      include_once($kint_file);
      if (is_callable(['Kint', 'dump'])) {
        $args = func_get_args();
        call_user_func_array(['Kint', 'dump'], $args);
      }
      else {
        die('Unable to call Kint::dump().');
      }
    }
    else {
      die('Unable to find Kint library file. Tried including ' . $kint_file);
    }
  }
}
