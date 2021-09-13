@test "should check up to 6 times when versions mismatch then exit 2" {
  function get_current_version(){
    echo "ghjk"
  }
  source "./is_deployed"
  run is_deployed 6 "abcd"

  [ "${#lines[@]}" -eq 6 ]
  [ "$status" -eq 2 ]
}

@test "should not fail if versions match" {
  function get_current_version(){
    echo "abcd"
  }
  source "./is_deployed"
  run is_deployed 6 "abcd"

  [ "$status" -eq 0 ]
}

@test "should stop checking as soon as the check is done" {
  i=0
  function get_current_version() {
    if [ "$i" -le 3 ];then
      echo "ghkl"
    else
      echo "abcd"
    fi

    ((i++))
  }
  source "./is_deployed"
  run is_deployed 6 "abcd"
  [ "${#lines[@]}" -eq 3 ]
}

