local function condif_dapui()
  local dap, dapui = require "dap", require "dapui"

  local debug_open = function()
    dapui.open()
    vim.api.nvim_command("DapVirtualTextEnable")
  end
  local debug_close = function()
    dap.repl.close()
    dapui.close()
    vim.api.nvim_command("DapVirtualTextDisable")
    -- vim.api.nvim_command("bdelete! term:")   -- close debug temrinal
  end

  dap.listeners.after.event_initialized["dapui_config"] = function()
    debug_open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    debug_close()
  end
  dap.listeners.before.event_exited["dapui_config"]     = function()
    debug_close()
  end
  dap.listeners.before.disconnect["dapui_config"]       = function()
    debug_close()
  end
end

local function configure_debugger()

end

local function keymapings()
  local opts = { noremap = true, nowait = true }

  vim.keymap.set('n', '<leader>db', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
  vim.keymap.set('n', '<leader>dr', "<cmd>lua require'dap'.repl.open()<cr>", opts)
end

local M = {
  {
    "jay-babu/mason-nvim-dap.nvim",
    config = function ()
      require("mason-nvim-dap").setup()
    end
  },
  {
    "ravenxrz/nvim-dap",
    config = function ()
      condif_dapui()
      configure_debugger()
      keymapings()
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function ()
      require("nvim-dap-virtual-text").setup {
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = true,
        show_stop_reason = true,            -- show stop reason when stopped for exceptions
        commented = false,                  -- prefix virtual text with comment string
        virt_text_pos = 'eol',
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil
      }
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function ()
      require("dapui").setup()
    end
  },
}

return M
