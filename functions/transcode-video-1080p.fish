function transcode-video-1080p
  set base (string replace -r '\.[^.]*$' '' -- $argv[1])
  ffmpeg -i "$argv[1]" -vf scale=1920:1080 -c:v libx264 -preset fast -crf 23 -c:a copy "$base-1080p.mp4"
end
