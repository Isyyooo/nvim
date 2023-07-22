I = mo.styles.icons

require("lazy").setup({
  spec = {
    require("plugins.configs.colortheme").config,
    require("plugins.configs.ui"),
    require("plugins.configs.treesitter"),
    require("plugins.configs.project"),
    require("plugins.configs.editor"),
    require("plugins.configs.explorer"),
    require("plugins.configs.lsp").config,
    require("plugins.configs.completion").config,
    require("plugins.configs.whichkey").config,
    -- require("plugins.configs.dap"),
    require("plugins.configs.startup"),
    require("plugins.configs.finder")
  },
  defaults = { lazy = false },
  install = { colorscheme = { "catppuccin" } },
  change_detection = { notify = false },
  ui = {
    border = mo.styles.border,
    icons = {
      loaded = I.plugin.installed,
      not_loaded = I.plugin.uninstalled,
      cmd = I.misc.terminal,
      config = I.misc.setting,
      event = I.lsp.kinds.event,
      ft = I.documents.file,
      init = I.dap.controls.play,
      keys = I.misc.key,
      plugin = I.plugin.plugin,
      runtime = I.misc.vim,
      source = I.lsp.kinds.snippet,
      start = I.dap.play,
      task = I.misc.task,
      lazy = I.misc.lazy,
      list = {
        I.misc.creation,
        I.misc.fish,
        I.misc.star,
        I.misc.pulse,
      },
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  }})
