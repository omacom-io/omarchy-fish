# Lazy-load try shell integration on first use, mirroring bash init.
# try init emits a fish function when SHELL points at fish.
if command -q try
    function try --description 'Lazy-load try shell integration'
        functions -e try
        SHELL=(command -v fish) command try init ~/Work/tries | source
        try $argv
    end
end
