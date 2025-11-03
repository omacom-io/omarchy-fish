function img2jpg
  set base (string replace -r '\.[^.]*$' '' -- $argv[1])
  magick "$argv[1]" -quality 95 -strip "$base.jpg"
end
