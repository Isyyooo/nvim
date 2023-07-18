return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  priority = 1000,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "query", "typescript", "dart", "java", "c", "prisma", "bash", "go", "lua", "html", "vim" },
      highlight = {
        enable = true,
        disable = {}, -- list of language that will be disabled
      },
      indent = {
        enable = true
      }
    })
  end
}
