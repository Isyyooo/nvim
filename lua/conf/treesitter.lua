local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

local M = {}
function M.setup()
  treesitter.setup {
    ensure_installed = "all",

    highlight = {
      enable = true
    },

    indent = {
      enable = true
    }

  }
end
return M
