-- Load Lazy plugin manager
require("config.lazy")

-- Load theme + set 24-bit colour
vim.opt.termguicolors = true
vim.cmd "colorscheme catppuccin-mocha"

-- nvim tree config
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()

-- bind t to open / close nvim-tree
vim.keymap.set('n', 't', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- close nvim if tree is the only remaining buffer
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeAutoClose", { clear = true }),
  callback = function()
    local tree_open = require("nvim-tree.api").tree.is_visible()
    if #vim.api.nvim_list_wins() == 1 and tree_open then
      vim.cmd("quit")
    end
  end,
})

-- lualine config
require('lualine').setup()

-- cokeline setup
local get_hex = require('cokeline.hlgroups').get_hl_attr

require('cokeline').setup({
  default_hl = {
    fg = function(buffer)
      return
        buffer.is_focused
        and get_hex('Normal', 'fg')
         or get_hex('Comment', 'fg')
    end,
    bg = 'NONE',
  },
  sidebar = {
    filetype = {'NvimTree', 'neo-tree'},
    components = {
      {
        text = function(buf)
          return buf.filetype
        end,
        fg = yellow,
        bg = function() return get_hex('NvimTreeNormal', 'bg') end,
        bold = true,
      },
    }
  },
  components = {
    {
      text = function(buffer) return (buffer.index ~= 1) and '▏' or '' end,
      fg = function() return get_hex('Normal', 'fg') end
    },
    {
      text = function(buffer) return '    ' .. buffer.devicon.icon end,
      fg = function(buffer) return buffer.devicon.color end,
    },
    {
      text = function(buffer) return buffer.filename .. '    ' end,
      bold = function(buffer) return buffer.is_focused end
    },
    {
      text = '󰖭',
      on_click = function(_, _, _, _, buffer)
        buffer:delete()
      end
    },
    {
      text = '  ',
    },
  },
})

-- setup gitsigns
vim.wo.number = true
vim.wo.signcolumn = "yes:1"
require('gitsigns').setup()
