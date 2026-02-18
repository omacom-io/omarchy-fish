function img2jpg-small --description 'Transcode any image to small JPG (max 1080px)'
  set -l img $argv[1]
  set -l rest $argv[2..]
  set -l base (string replace -r '\.[^.]*$' '' -- $img)
  magick "$img" $rest -resize "1080x>" -quality 95 -strip "$base-small.jpg"
end
