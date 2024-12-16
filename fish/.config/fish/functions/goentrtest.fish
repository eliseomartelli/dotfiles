# Run go tests on file changes.
function goentrtest
    find . | entr bash -c "clear; go test -v $argv -cover"
end
