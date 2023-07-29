--
-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		"williamboman/mason-lspconfig.nvim",
		"nvim-lua/plenary.nvim",

		-- "neoclide/coc.nvim", branch = 'release',
		-- "hrsh7th/cmp-buffer",
		-- "hrsh7th/cmp-path",
		-- "hrsh7th/cmp-cmdline",
		-- "hrsh7th/cmp-nvim-lsp",
		-- "hrsh7th/nvim-cmp",
		-- "delphinus/cmp-ctags",
		-- "ray-x/cmp-treesitter",
		-- "quangnguyen30192/cmp-nvim-tags",
		"ms-jpq/coq_nvim", branch = 'coq',
		"ms-jpq/coq.artifacts", branch = 'artifacts',
		"ms-jpq/coq.thirdparty", branch = '3p',
	},
	{
		"j-morano/buffer_manager.nvim",
		dependencies = { 'nvim-lua/plenary.nvim' },
		"nvim-telescope/telescope.nvim",
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-tree.lua",
		"numToStr/Comment.nvim",
		"johnfrankmorgan/whitespace.nvim",
		-- "simrat39/symbols-outline.nvim",
		--"folke/which-key.nvim",
		"dhananjaylatkar/cscope_maps.nvim",
		--after = "which-key.nvim",
		"preservim/tagbar",
		"akinsho/toggleterm.nvim",
		"ethanholz/nvim-lastplace",
		"NvChad/nvim-colorizer.lua",
	}
})

vim.g.syntax=on
vim.g.termguicolors=true
-- utf8
vim.g.encoding = "UTF-8"
--vim.o.fileencoding = "utf-8"
vim.opt.mouse = v
vim.opt.number = true
-- 高亮所在行
vim.wo.cursorline = true
-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- 样式
vim.o.background = "dark"
vim.o.termguicolors = true
vim.opt.termguicolors = true
-- 补全增强
vim.o.wildmenu = true
vim.cmd.colorscheme "default"
-- vim.cmd.colorscheme "desert"
-- Tab
--vim.opt.tabstop = 4 -- number of visual spaces per TAB
--vim.opt.softtabstop = 4 -- number of spacesin tab when editing
--vim.opt.shiftwidth = 4 -- insert 4 spaces on a tab
--vim.opt.expandtab = true -- tabs are spaces, mainly because of python
vim.g.hidden = 1
-- hi
-- vim.g.highlight Identifier cterm=none ctermfg=14 guifg=#FFFAFA
-- hi Function   cterm=bold ctermfg=14 guifg=#40ffff gui=bold
vim.api.nvim_set_hl(0, 'Identifier', { fg = "#FFFAFA", cterm=none, ctermfg=14 })
vim.api.nvim_set_hl(0, 'Function', { fg = "#40ffff", cterm=bold, ctermfg=14, bold=true })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = "#403939", ctermfg=0, ctermbg=13})


vim.g.coc_node_path = '/usr/local/bin/node'


local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
vim.keymap.set('n', '<F2>', ':set tags=tags<CR>', opt)
vim.keymap.set('n', '<F3>', ":!rm -rf cscope.* tags ; echo ctag building...;ctags -R --c++-kinds=+px --fields=+aiKSz --extras=+q --langmap=c++:+.tpp.hpp ;echo cscope building...;find ./ -name '*.[chS]' -o -name '*.[cht]pp' -o -name '*.c[x]*' > cscope.files && cscope -Rbq -i cscope.files<CR><ESC>:set tags=tags<CR>", opt)
map('n', '<F6>', ':NvimTreeToggle<CR>', opt)
-- vim.keymap.set('n', '<leader>w', require("buffer_manager.ui").toggle_quick_menu, opt)
vim.keymap.set('n', '<F8>', ':COQnow -s <CR>', opt)


require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- coq_nvim
-- require("coq").setup({})
vim.g.coq_settings = {
    auto_start = true,
    -- auto_start = 'shut-up',
}
require("coq")

--telescope
require('telescope').setup({
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      n = {
    	  ['<c-s>'] = require('telescope.actions').delete_buffer,
	  ["<c-j>"] = require('telescope.actions').move_selection_next,
	  ["<c-k>"] = require('telescope.actions').move_selection_previous,
      }, -- n
      i = {
          ["<C-h>"] = "which_key",
          ['<c-s>'] = require('telescope.actions').delete_buffer,
	  ["<c-j>"] = require('telescope.actions').move_selection_next,
	  ["<c-k>"] = require('telescope.actions').move_selection_previous,
      } -- i
    } -- mappings
  }, -- defaults
  pickers = {
    push_tagstack_on_edit = true,
    buffers = {
        -- sort_lastused = true,
	sort_mru = true,
    }
  },
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find)
vim.keymap.set('n', '<C-p>', builtin.find_files)
-- vim.keymap.set('n', '<C-[>', builtin.current_buffer_tags)
vim.keymap.set('n', '<leader>w', builtin.buffers)
vim.keymap.set('n', ']]s', builtin.live_grep)
vim.keymap.set('n', ']s', function()
	builtin.grep_string({word_match = '-w'})
end)
vim.keymap.set('v', ']s', function()
	vim.cmd.normal('"fy')
	builtin.grep_string({search = vim.fn.getreg('"f')})
end)

require('Comment').setup({
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = ']cc',
        ---Block-comment toggle keymap
        block = ']cb',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = ']cc',
        ---Block-comment keymap
        block = ']cb',
    },
    ---LHS of extra mappings
    extra = {
        ---Add comment on the line above
        above = ']cO',
        ---Add comment on the line below
        below = ']co',
        ---Add comment at the end of line
        eol = ']cA',
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
    },
    ---Function to call before (un)comment
    pre_hook = nil,
    ---Function to call after (un)comment
    post_hook = nil,
})

require('whitespace-nvim').setup({
    -- configuration options and their defaults

    -- `highlight` configures which highlight is used to display
    -- trailing whitespace
    highlight = 'DiffDelete',

    -- `ignored_filetypes` configures which filetypes to ignore when
    -- displaying trailing whitespace
    ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help' },

    -- `ignore_terminal` configures whether to ignore terminal buffers
    ignore_terminal = true,
})
vim.keymap.set('n', ']t', require('whitespace-nvim').trim)

-- require("symbols-outline").setup()
-- vim.g.symbols_outline = {
--   highlight_hovered_item = true,
--   show_guides = true,
--   auto_preview = false,
--   position = 'left',
--   relative_width = true,
--   width = 25,
--   auto_close = false,
--   show_numbers = false,
--   show_relative_numbers = false,
--   show_symbol_details = true,
--   preview_bg_highlight = 'Pmenu',
--   autofold_depth = nil,
--   auto_unfold_hover = true,
--   fold_markers = { '', '' },
--   wrap = false,
--   keymaps = { -- These keymaps can be a string or a table for multiple keys
--     close = {"<Esc>", "q"},
--     goto_location = "<Cr>",
--     focus_location = "o",
--     hover_symbol = "<C-space>",
--     toggle_preview = "K",
--     rename_symbol = "r",
--     code_actions = "a",
--     fold = "h",
--     unfold = "l",
--     fold_all = "W",
--     unfold_all = "E",
--     fold_reset = "R",
--   },
--   lsp_blacklist = {},
--   symbol_blacklist = {},
--   symbols = {
--     File = { icon = "", hl = "@text.uri" },
--     Module = { icon = "", hl = "@namespace" },
--     Namespace = { icon = "", hl = "@namespace" },
--     Package = { icon = "", hl = "@namespace" },
--     Class = { icon = "𝓒", hl = "@type" },
--     Method = { icon = "ƒ", hl = "@method" },
--     Property = { icon = "", hl = "@method" },
--     Field = { icon = "", hl = "@field" },
--     Constructor = { icon = "", hl = "@constructor" },
--     Enum = { icon = "ℰ", hl = "@type" },
--     Interface = { icon = "ﰮ", hl = "@type" },
--     Function = { icon = "", hl = "@function" },
--     Variable = { icon = "", hl = "@constant" },
--     Constant = { icon = "", hl = "@constant" },
--     String = { icon = "𝓐", hl = "@string" },
--     Number = { icon = "#", hl = "@number" },
--     Boolean = { icon = "⊨", hl = "@boolean" },
--     Array = { icon = "", hl = "@constant" },
--     Object = { icon = "⦿", hl = "@type" },
--     Key = { icon = "🔐", hl = "@type" },
--     Null = { icon = "NULL", hl = "@type" },
--     EnumMember = { icon = "", hl = "@field" },
--     Struct = { icon = "𝓢", hl = "@type" },
--     Event = { icon = "🗲", hl = "@type" },
--     Operator = { icon = "+", hl = "@operator" },
--     TypeParameter = { icon = "𝙏", hl = "@parameter" },
--     Component = { icon = "", hl = "@function" },
--     Fragment = { icon = "", hl = "@constant" },
--   },
-- }

require('cscope_maps').setup({
  disable_maps = false, -- true disables my keymaps, only :Cscope will be loaded
  cscope = {
    db_file = "./cscope.out", -- location of cscope db file
    exec = "cscope", -- "cscope" or "gtags-cscope"
    picker = "telescope", -- "telescope", "fzf-lua" or "quickfix"
    skip_picker_for_single_result = false, -- jump directly to position for single result
    db_build_cmd_args = { "-bqkv" }, -- args used for db build (:Cscope build)
  },
})
local keymap_opts = { noremap = true, silent = true }
local keymap_wo_wk = function()
	-- Without which-key
	vim.api.nvim_set_keymap(
		"n",
		"<leader>s",
		[[<cmd>lua require('cscope_maps').cscope_prompt('s', vim.fn.expand("<cword>"))<cr>]],
		keymap_opts
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>g",
		[[<cmd>lua require('cscope_maps').cscope_prompt('g', vim.fn.expand("<cword>"))<cr>]],
		keymap_opts
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>c",
		[[<cmd>lua require('cscope_maps').cscope_prompt('c', vim.fn.expand("<cword>"))<cr>]],
		keymap_opts
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>t",
		[[<cmd>lua require('cscope_maps').cscope_prompt('t', vim.fn.expand("<cword>"))<cr>]],
		keymap_opts
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>e",
		[[<cmd>lua require('cscope_maps').cscope_prompt('e', vim.fn.expand("<cword>"))<cr>]],
		keymap_opts
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>f",
		[[<cmd>lua require('cscope_maps').cscope_prompt('f', vim.fn.expand("<cfile>"))<cr>]],
		keymap_opts
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>i",
		[[<cmd>lua require('cscope_maps').cscope_prompt('i', vim.fn.expand("<cfile>"))<cr>]],
		keymap_opts
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>d",
		[[<cmd>lua require('cscope_maps').cscope_prompt('d', vim.fn.expand("<cword>"))<cr>]],
		keymap_opts
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>a",
		[[<cmd>lua require('cscope_maps').cscope_prompt('a', vim.fn.expand("<cword>"))<cr>]],
		keymap_opts
	)
	vim.api.nvim_set_keymap("n", "<leader>b", [[<cmd>Cscope build<cr>]], keymap_opts)
	vim.api.nvim_set_keymap("n", "<leader><leader>s", ':Cscope find s ', keymap_opts)
	vim.api.nvim_set_keymap("n", "<leader><leader>g", ':Cscope find g ', keymap_opts)
	vim.api.nvim_set_keymap("n", "<leader><leader>c", ':Cscope find c ', keymap_opts)
	vim.api.nvim_set_keymap("n", "<leader><leader>f", ':Cscope find f ', keymap_opts)
end
keymap_wo_wk()

require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "bash", "cpp", "go", "rust", "python"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/s
  -- ome/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- require("tagbar").setup()
vim.g.tagbar_position = "topleft vertical"  --'topleft', 'botright', 'leftabove', or 'rightbelow'
vim.g.tagbar_width = 35 --max([25, winwidth(0) / 5])
vim.g.tagbar_sort = 0
vim.keymap.set('n', '<F5>', ":TagbarToggle()<CR>", opt)

require("toggleterm").setup({
	size = 60,
	open_mapping = [[<c-\>]],
	direction = "float",
})

require'nvim-lastplace'.setup {
    lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
    lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
    lastplace_open_folds = true
}

 require("colorizer").setup {
      filetypes = { "*" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue or blue
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = false, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = false, -- Enable tailwind colors
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

-- require("cmp").setup {
--   sources = {
 --    {
 --      name = "ctags",
 --      -- default values
 --      option = {
 --        executable = "ctags",
 --        trigger_characters = { "." },
 --        trigger_characters_ft = {
	-- 	c = { ".", "->" },
	-- },
 --      },
 --    },
 --    {
	-- name = 'buffer',
 --    },
 --    {
	-- name = 'treesitter',
 --    },
    -- {
    --     name = 'tags',
    --     option = {
    --       -- this is the default options, change them if you want.
    --       -- Delayed time after user input, in milliseconds.
    --       complete_defer = 100,
    --       -- Max items when searching `taglist`.
    --       max_items = 10,
    --       -- Use exact word match when searching `taglist`, for better searching
    --       -- performance.
    --       exact_match = false,
    --       -- Prioritize searching result for current buffer.
    --       current_buffer_only = false,
    --     },
    -- },
--  },
-- }

-- require("lsp")

