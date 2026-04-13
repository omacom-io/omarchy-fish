function ga
    if test -z "$argv[1]"
        echo "Usage: ga [branch name]"
        return 1
    end

    set -l branch $argv[1]
    set -l base (basename $PWD)
    set -l wt_path "../$base--$branch"

    git worktree add -b $branch $wt_path
    mise trust $wt_path
    cd $wt_path
end
