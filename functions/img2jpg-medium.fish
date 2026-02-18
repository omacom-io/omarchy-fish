function img2jpg-medium --description 'Transcode any image to medium JPG (max 1800px)'
  set -l img $argv[1]
  set -l rest $argv[2..]
  set -l base (string replace -r '\.[^.]*$' '' -- $img)
  magick "$img" $rest -resize "1800x>" -quality 95 -strip "$base-medium.jpg"
end
