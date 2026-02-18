function img2png --description 'Transcode any image to compressed-but-lossless PNG'
  set -l img $argv[1]
  set -l rest $argv[2..]
  set -l base (string replace -r '\.[^.]*$' '' -- $img)
  magick "$img" $rest -strip \
    -define png:compression-filter=5 \
    -define png:compression-level=9 \
    -define png:compression-strategy=1 \
    -define png:exclude-chunk=all \
    "$base-optimized.png"
end
