return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = I.plugin.installed,
						package_pending = I.plugin.pedding,
						package_uninstalled = I.plugin.uninstalled,
					},
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			local fmt = string.format
			local icons = mo.styles.icons.diagnostics
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			for name, icon in pairs(icons) do
				name = "DiagnosticSign" .. name:gsub("^%l", string.upper)
				vim.fn.sign_define(name, { text = icon, texthl = name })
			end

			vim.diagnostic.config({
				severity_sort = true,
				virtual_text = {
					source = false,
					severity = vim.diagnostic.severity.ERROR,
					spacing = 1,
					format = function(d)
						local level = vim.diagnostic.severity[d.severity]
						return fmt("%s %s", icons[level:lower()], d.message)
					end,
				},
				float = {
					header = "",
					source = false,
					border = mo.styles.border,
					prefix = function(d)
						local level = vim.diagnostic.severity[d.severity]
						local prefix = fmt("%s ", icons[level:lower()])
						return prefix, "DiagnosticFloating" .. level
					end,
					format = function(d)
						return d.source and fmt("%s: %s", string.gsub(d.source, "%.$", ""), d.message) or d.message
					end,
					suffix = function(d)
						local code = d.code or (d.user_data and d.user_data.lsp.code)
						local suffix = code and fmt(" (%s)", code) or ""
						return suffix, "Comment"
					end,
				},
			})

			require("mason-lspconfig").setup()
			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<Leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})

			lspconfig.pyright.setup({
				capabilities = capabilities,
			})

			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
		end,
	},
	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup({
				lspconfig = true,
				override = function() end,
			})
		end,
	},
}
