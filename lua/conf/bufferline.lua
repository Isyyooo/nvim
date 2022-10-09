local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

local M = {}
function M.setup()
  bufferline.setup {
  }
end
return M
