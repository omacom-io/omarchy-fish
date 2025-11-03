function img2png
  set base (string replace -r '\.[^.]*$' '' -- $argv[1])
  magick "$argv[1]" -strip \
    -define png:compression-filter=5 \
    -define png:compression-level=9 \
    -define png:compression-strategy=1 \
    -define png:exclude-chunk=all \
    "$base.png"
end
