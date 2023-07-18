require("lazy").setup({
  require("plugins.configs.appearance"),
  require("plugins.configs.treesitter"),
  require("plugins.configs.project"),
  require("plugins.configs.editor"),
  require("plugins.configs.lsp").config,
  require("plugins.configs.cmp").config
})
