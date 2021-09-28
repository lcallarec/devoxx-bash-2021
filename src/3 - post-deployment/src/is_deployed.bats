# function setup() {
# }

# function teardown() {
# }
@test "should check 6 times when versions mismatch then exit 2" {
  skip
  #given
  source "./is_deployed.sh"

  #when
  run is_deployed 6 "v2"

  #then
  [ "${#lines[@]}" -eq 6 ]
  [ "$status" -eq 2 ]
}

@test "should not fail if deployed version matches the expected version" {
  skip
  #given
  source "./is_deployed.sh"

  #when
  run is_deployed 6 "v2"

  #then
  [ "$status" -eq 0 ]
}

@test "should stop checking as soon as the expected version is deployed" {
  skip
  #given
  # i=0
  # function get_api_version() {
  #   if [ "$i" -le 3 ];then
  #     echo "v1"
  #   else
  #     echo "v2"
  #   fi

  #   ((i++))
  # }
  source "./is_deployed.sh"

  #when
  run is_deployed 6 "v2"

  #then
  [ "${#lines[@]}" -eq 3 ]
}
