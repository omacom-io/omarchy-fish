function compress
  set dir $argv[1]
  set dir (string replace -r '/$' '' -- $dir)
  tar -czf "$dir.tar.gz" "$dir"
end
