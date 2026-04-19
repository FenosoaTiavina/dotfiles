-- https://github.com/LunarVim/bigfile.nvim
local config = function()
    require 'bigfile'.setup {
        filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
    }
end

config()
