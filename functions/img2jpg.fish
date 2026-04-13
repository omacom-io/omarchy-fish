function img2jpg --description 'Transcode any image to JPG (great for shrinking wallpapers)'
  set -l img $argv[1]
  set -l rest $argv[2..]
  set -l base (string replace -r '\.[^.]*$' '' -- $img)
  magick "$img" $rest -quality 85 -strip "$base-converted.jpg"
end
