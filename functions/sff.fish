function sff
    if test (count $argv) -eq 0
        echo "Usage: sff <destination> (e.g. sff host:/tmp/)"
        return 1
    end

    set -l file (find . -type f -printf '%T@\t%p\n' | sort -rn | cut -f2- | ff)
    if test -n "$file"
        scp $file $argv[1]
    end
end
