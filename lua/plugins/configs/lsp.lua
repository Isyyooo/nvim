local servers = {
  "lua_ls",
  "pyright",
  "jsonls",
  "clangd",
  "cssls"
}

local M = {}
local F = {}

M.config = {
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
      { "williamboman/mason.nvim", build = ":MasonUpdate", },
      { "folke/neodev.nvim" }
    },
    config = function()
      require("mason").setup({
        ui = {
          border = "none",
          icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
          },
          log_level = vim.log.levels.INFO,
          max_concurrent_installers = 4,
        }
      })
      require("neodev").setup()
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local opts = {}

      local signs = {

        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "⚑" },
        { name = "DiagnosticSignInfo", text = "»" },
      }
      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end

      local config = {
        virtual_text = false, -- disable virtual text
        signs = {
          active = signs, -- show signs
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      }

      vim.diagnostic.config(config)
      F.configureKeybinds()

      for _, server in pairs(servers) do
        opts = {
        }

        server = vim.split(server, "@")[1]

        local require_ok, conf_opts = pcall(require, "plugins.lsp." .. server)
        if require_ok then
          opts = vim.tbl_deep_extend("force", conf_opts, opts)
        end

        lspconfig[server].setup(opts)
      end
    end
  }
}

F.configureKeybinds = function()
  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
      local opts = { buffer = event.buf, noremap = true, nowait = true }

      vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gD', ':tab sp<CR><cmd>lua vim.lsp.buf.definition()<cr>', opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('i', '<c-f>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      -- vim.keymap.set({ 'n', 'x' }, '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)
      vim.keymap.set('n', '<leader>aw', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', "<leader>,", vim.lsp.buf.code_action, opts)
      -- vim.keymap.set('x', '<leader>aw', vim.lsp.buf.range_code_action, opts)
      -- vim.keymap.set('x', "<leader>,", vim.lsp.buf.range_code_action, opts)
      vim.keymap.set('n', '<leader>t', ':Trouble<cr>', opts)
      vim.keymap.set('n', '<leader>-', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', '<leader>=', vim.diagnostic.goto_next, opts)
    end
  })
end

return M
