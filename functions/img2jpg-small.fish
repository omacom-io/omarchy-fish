function img2jpg-small
  set base (string replace -r '\.[^.]*$' '' -- $argv[1])
  magick "$argv[1]" -resize "1080x>" -quality 95 -strip "$base.jpg"
end
