function gd
    if gum confirm "Remove worktree and branch?"
        set -l cwd (pwd)
        set -l worktree (basename $cwd)

        set -l root (string replace -r '--.*' '' $worktree)
        set -l branch (string replace -r '.*?--' '' $worktree)

        if test "$root" != "$worktree"
            cd "../$root"
            git worktree remove $cwd --force; or return 1
            git branch -D $branch
        end
    end
end
