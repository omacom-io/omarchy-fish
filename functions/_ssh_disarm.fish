# Disarm mouse tracking (1000/1002/1003, 1006 encoding), focus reporting
# (1004), and the alternate screen (1049), and show the cursor again. The
# escapes are expanded by printf itself, so they stay single-quoted.
function _ssh_disarm --description 'Disarm terminal modes armed over an ssh session'
    printf '\e[?1000l\e[?1002l\e[?1003l\e[?1006l\e[?1004l\e[?1049l\e[?25h'
end
