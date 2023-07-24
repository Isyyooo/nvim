return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				modules = {},
				ensure_installed = { "lua", "vim", "json", "rust" },
				ignore_install = {},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						node_incremental = "v",
						node_decremental = "<BS>",
					},
				}
			})
		end,
	}
}
