local M = {}

require "conf.lsp.mason"
-- Setup LSP handlers
require("conf.lsp.handlers").setup()

function M.setup()
end
return M
