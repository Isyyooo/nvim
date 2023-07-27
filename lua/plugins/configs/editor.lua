return {
	{
		"romainl/vim-cool",
		event = "VeryLazy",
	},

	{
		"airblade/vim-rooter",
		event = "VeryLazy",
		init = function()
			vim.g.rooter_patterns = { '__vim_project_root', '.git/' }
			vim.g.rooter_silent_chdir = true
			-- set an autocmd
			vim.api.nvim_create_autocmd("VimEnter", {
				pattern = "*",
				callback = function()
					-- source .nvim.lua at project root
					vim.cmd([[silent! source .vim.lua]])
				end,
			})
		end
	},

	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup {
				filetypes = { "*" },
				user_default_options = {
					RGB = true,        -- #RGB hex codes
					RRGGBB = true,     -- #RRGGBB hex codes
					names = true,      -- "Name" codes like Blue or blue
					RRGGBBAA = false,  -- #RRGGBBAA hex codes
					AARRGGBB = false,  -- 0xAARRGGBB hex codes
					rgb_fn = false,    -- CSS rgb() and rgba() functions
					hsl_fn = false,    -- CSS hsl() and hsla() functions
					css = false,       -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					css_fn = false,    -- Enable all CSS *functions*: rgb_fn, hsl_fn
					-- Available modes for `mode`: foreground, background,  virtualtext
					mode = "virtualtext", -- Set the display mode.
					-- Available methods are false / true / "normal" / "lsp" / "both"
					-- True is same as normal
					tailwind = false,                              -- Enable tailwind colors
					-- parsers can contain values used in |user_default_options|
					sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
					virtualtext = "■",
					-- update color values even if buffer is not focused
					-- example use: cmp_menu, cmp_docs
					always_update = false
				},
				-- all the sub-options of filetypes apply to buftypes
				buftypes = {},
			}
		end
	}
}
