local set = vim.o
set.number = true
set.relativenumber = true
set.clipboare = "unnamed"

-- copy after highlight
vim.api.nvim_create_autocmd({"TextYankPost"},
{
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
		})
	end,
})


