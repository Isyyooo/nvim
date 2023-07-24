return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
		keys = {
			{ "<Leader>p",  ":Telescope find_files<CR>", desc = "find files" },
			{ "<Leader>P",  ":Telescope live_grep<CR>",  desc = "grep file" },
			{ "<Leader>rs", ":Telescope resume<CR>",     desc = "resume" },
			{ "<Leader>q",  ":Telescope oldfiles<CR>",   desc = "oldfiles" },
		},
	},
}
