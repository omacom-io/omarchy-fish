function _herdr_ratio --description 'Echo a split ratio as a float'
    awk -v a="$argv[1]" -v b="$argv[2]" 'BEGIN { printf "%.4f", a / b }'
end
