function mup --wraps='mise up' --description 'alias mup=MISE_MINIMUM_RELEASE_AGE=0 mise up'
  MISE_MINIMUM_RELEASE_AGE=0 mise up $argv
end
