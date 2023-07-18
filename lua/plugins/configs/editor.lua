return {
  "NvChad/nvim-colorizer.lua",
  opts = {
    filetypes = { "*" },
    user_default_options = {
      RGB = true,       -- #RGB hex codes
      RRGGBB = true,    -- #RRGGBB hex codes
      names = true,     -- "Name" codes like Blue or blue
      RRGGBBAA = false, -- #RRGGBBAA hex codes
      AARRGGBB = true,  -- 0xAARRGGBB hex codes
      rgb_fn = false,   -- CSS rgb() and rgba() functions
      hsl_fn = false,   -- CSS hsl() and hsla() functions
      css = false,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = false,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Available modes for `mode`: foreground, background,  virtualtext
      mode = "virtualtext", -- Set the display mode.
      -- Available methods are false / true / "normal" / "lsp" / "both"
      -- True is same as normal
      tailwind = true,
      sass = { enable = false },
      virtualtext = "■",
    },
    -- all the sub-options of filetypes apply to buftypes
    buftypes = {},
  },
  {
    "shellRaining/hlchunk.nvim",
    init = function()
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { pattern = "*", command = "EnableHL", })
      require('hlchunk').setup({
        chunk = {
          enable = true,
          use_treesitter = true,
          style = {
            { fg = "#806d9c" },
          },
        },
        indent = {
          chars = { "│", "¦", "┆", "┊", },
          use_treesitter = false,
        },
        blank = {
          enable = false,
        },
        line_num = {
          use_treesitter = true,
        },
      })
    end
  },
}
