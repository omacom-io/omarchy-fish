function img2jpg-large
    set -l img $argv[1]
    set -e argv[1]

    magick $img $argv -resize 3160x\> -quality 85 -strip (string replace -r '\.[^.]*$' '' $img)-large.jpg
end
