local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local M = {}

function M.setup()
nvimtree.setup{
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    custom = { "*.meta" },
    dotfiles = true,
  },
}
end
return M
