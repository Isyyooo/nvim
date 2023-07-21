local has_words_before = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local M = {}

M.config = {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  after = "SirVer/ultisnips",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-calc",
    {
      "quangnguyen30192/cmp-nvim-ultisnips",
      config = function()
        -- optional call to setup (see customization section)
        require("cmp_nvim_ultisnips").setup {}
      end,
    },
    {
      "SirVer/ultisnips",
      dependencies = {
        "honza/vim-snippets",
      },
    },
  },

  config = function()
    M.configfunc()
  end
}

M.configfunc = function()
  local cmp = require("cmp")
  local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
  -- local luasnip = require("luasnip")

  cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
      expand = function(args)
        -- luasnip.lsp_expand(args.body)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    window = {
      completion = {
        border = mo.styles.border,
        winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      },
      documentation = {
        border = mo.styles.border,
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      },
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      maxwidth = 60,
      maxheight = 10,
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format("%s %s", I.lsp.kinds[vim_item.kind:lower()], vim_item.kind)
        vim_item.menu = ({
          ultisnips = "[Snippet]",
          nvim_lsp = "[LSP]",
          buffer = "[Buf]",
          path = "[Path]",
          cmd = "[Cmd]"
        })[entry.source.name] or entry.source.name
        return vim_item
      end,
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "ultisnips" },
    }, {
        { name = "path" },
        { name = "nvim_lua" },
        { name = "calc" },
        -- { name = "luasnip" },
        -- { name = 'tmux',    option = { all_panes = true, } },  -- this is kinda slow
      }),
    mapping = cmp.mapping.preset.insert({
      ['<C-o>'] = cmp.mapping.complete(),
      ["<c-e>"] = cmp.mapping(
        function()
          cmp_ultisnips_mappings.compose { "expand", "jump_forwards" } (function() end)
        end,
        { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
      ),
      ["<c-n>"] = cmp.mapping(
        function(fallback)
          cmp_ultisnips_mappings.jump_backwards(fallback)
        end,
        { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
      ),
      ['<c-f>'] = cmp.mapping({
        i = function(fallback)
          cmp.close()
          fallback()
        end
      }),
      ['<c-y>'] = cmp.mapping({ i = function(fallback) fallback() end }),
      ['<CR>'] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          else
            fallback()
          end
        end
      }),
      ["<Tab>"] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end,
      }),
      ["<S-Tab>"] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          else
            fallback()
          end
        end,
      }),
    }),
  })
end

return M
