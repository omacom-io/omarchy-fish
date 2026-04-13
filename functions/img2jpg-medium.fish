function img2jpg-medium --description 'Transcode any image to 4K JPG (max 2160px)'
  set -l img $argv[1]
  set -l rest $argv[2..]
  set -l base (string replace -r '\.[^.]*$' '' -- $img)
  magick "$img" $rest -resize "2160x>" -quality 85 -strip "$base-medium.jpg"
end
