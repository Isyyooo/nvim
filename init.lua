require("core.styles")

require("core.options")
require("core.keymaps")

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.lazy").setup(lazypath)
end

vim.opt.rtp:prepend(lazypath)
require "plugins"


