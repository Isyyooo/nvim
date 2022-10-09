local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
  return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local M = {}

function M.setup(servers, options)
  mason.setup {
    ui = {
      border = "single",
      icons = {
        package_installed = "✓",
        package_pending = "",
        package_uninstalled = "➜",
      },
    },
  }

  mason_lspconfig.setup {
    ensure_installed = servers,
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      local require_ok, server = pcall(require, "conf.lsp.settings." .. server_name)

      if require_ok then
        options = vim.tbl_deep_extend("force", server, options)
      end

      lspconfig[server_name].setup(options)
    end,
  }
end
return M
