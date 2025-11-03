function transcode-video-4K
  set base (string replace -r '\.[^.]*$' '' -- $argv[1])
  ffmpeg -i "$argv[1]" -c:v libx265 -preset slow -crf 24 -c:a aac -b:a 192k "$base-optimized.mp4"
end
