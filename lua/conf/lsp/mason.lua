local servers = {
  "sumneko_lua",
  "clangd",
  "omnisharp_mono"
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "✓",
      package_pending = "",
      package_uninstalled = "➜",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

require("mason-lspconfig").setup_handlers {
  function(server_name)
    opts = {
      on_attach = require("conf.lsp.handlers").on_attach,
      capabilities = require("conf.lsp.handlers").capabilities,
    }

    local require_ok, conf_opts = pcall(require, "conf.lsp.settings." .. server_name)

    if require_ok then
      opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server_name].setup(opts)
  end
}
