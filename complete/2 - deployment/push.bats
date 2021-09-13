git_dir="/tmp/api"

function setup() {
    mkdir -p "$git_dir"
    cd "$git_dir"
    git init -b main
}

function teardown() {
    rm -rf "$git_dir"
}

function deploy() {
    if [ "$(git status -s | wc -l)" -ge 1 ]; then
        git add .
        git commit -m "adding test"
    else 
        exit 2
    fi
}

@test "should exit with status code 2 when there's no changes" {
    #given
    #when
    run deploy

    #then
    [ $status -eq 2 ]
}

function count_commits() {
    cd $git_dir && git log --format=oneline --no-decorate | wc -l
}
@test "should add a new commit when there a new file" {
    #given
    touch "$git_dir/test"

    #when
    run deploy

    #then
    [ "$(count_commits)" -eq 1 ]
}