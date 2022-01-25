vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard = { 'unnamed', 'unnamedplus' }
vim.opt.autoindent = true
vim.opt.expandtab = false 
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.list = true
vim.opt.mouse = 'a'
vim.opt.encoding = 'UTF-8'
vim.opt.scrolloff = 10

vim.api.nvim_exec([[set guifont="SauceCodePro Nerd Font Mono"]], false)

--Unix lile endings
vim.api.nvim_exec([[autocmd BufWritePre * set ff=unix]], false)

vim.api.nvim_exec([[command Hexon :%!xxd]], false)
vim.api.nvim_exec([[command Hexoff :%!xxd -r]], false)

require('packer').startup(function()

	use 'wbthomason/packer.nvim'

	--colorscheme
	use 'morhetz/gruvbox'
	use { 'folke/tokyonight.nvim', branch = 'main' }
	use 'Nis5l/niscolor-vim'
	use 'EdenEast/nightfox.nvim'

	--visual
	use {
		'hoob3rt/lualine.nvim',
		config = function()
			require('lualine').setup {
			  options = {theme = 'tokyonight'}
			}
		end,
	}
	use 'preservim/tagbar'
	use 'frazrepo/vim-rainbow'

	use 'ryanoasis/vim-devicons'
	use 'adelarsq/vim-devicons-emoji'
	use 'kyazdani42/nvim-web-devicons'

	--autocomplete/format
	use 'neovim/nvim-lspconfig'
	--use 'nvim-lua/lsp_extensions.nvim'
	use {
		'folke/trouble.nvim',
		config = function()
			require("trouble").setup{}
		end,
	}

	use { 'ms-jpq/coq_nvim', branch = 'coq' }
	use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }

	--git
	use 'mhinz/vim-signify'

	--Telecope
	use {
		'nvim-treesitter/nvim-treesitter',
		run = [[:TSUpdate]],
		config = function()
			require('nvim-treesitter.configs').setup {
			  ensure_installed = "all",
			  highlight = {
				enable = true,
			  },
			}
		end,
	}
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'

	--misc
	use 'b3nj5m1n/kommentary'
	use 'ap/vim-css-color'
	--[=[use {
		'andweeb/presence.nvim',
		config = function()
			require("presence").setup({
				-- General options
				neovim_image_text   = "Editor For Traditionalist Catholics", -- Text displayed when hovered over the Neovim image
				main_image          = "file",                                -- Main image display (either "neovim" or "file")

				editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer
				file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer
				git_commit_text     = "Committing changes",       -- Format string rendered when commiting changes in git
				plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins
				reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer
				workspace_text      = "Working on %s",            -- Workspace format string (either string or function(git_project_name: string|nil, buffer: string): string) line_number_text    = "Line %s out of %s",        -- Line number format string (for when enable_line_number is set to true)
			})
		end,
	}
	]=]
	use {
		'iamcco/markdown-preview.nvim',
		config = 'vim.call("mkdp#util#install")'
	}
	use 'AndrewRadev/bufferize.vim'
	use {
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	}

	use {
		"numtostr/FTerm.nvim",
		config = function()
			require'FTerm'.setup({
				border = 'double',
				dimensions  = {
					height = 0.9,
					width = 0.9,
				},
			})
		end,
	}

	use "alec-gibson/nvim-tetris"
	use "petertriho/nvim-scrollbar"
end)

vim.opt.termguicolors = true

--signify
vim.opt.updatetime = 100

vim.g.rainbow_active = 1

vim.g.tokyonight_style = 'night'
vim.cmd[[colorscheme tokyonight]]

vim.api.nvim_set_keymap('n', '<C-z>', '<CMD>lua require("FTerm").toggle()<CR>', { silent = true })
vim.api.nvim_set_keymap('t', '<C-z>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { silent = true})
vim.api.nvim_set_keymap('n', '<TAB>', ':tabn<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-TAB>', ':tabp<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F8>', ':TagbarToggle<CR>', { silent = true })
vim.api.nvim_set_keymap('n', 't', ':Telescope find_files<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-t>', ':Telescope live_grep<CR>', { silent = true })

vim.api.nvim_set_keymap('', '<C-j>', '<C-w><down>' , { silent = true })
vim.api.nvim_set_keymap('', '<C-k>', '<C-w><up>'   , { silent = true })
vim.api.nvim_set_keymap('', '<C-h>', '<C-w><left>' , { silent = true })
vim.api.nvim_set_keymap('', '<C-l>', '<C-w><right>', { silent = true })

--Exit terminal mode
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true } )

--Keep visual selection
vim.api.nvim_set_keymap('v', '>', '>gv', { silent = true })
vim.api.nvim_set_keymap('v', '<', '<gv', { silent = true })

vim.api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gb', '<C-^>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gh', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })


vim.g.coq_settings = {
  auto_start = 'shut-up',
  ['keymap.recommended'] = true,
  ['keymap.jump_to_mark'] = '',
}

local lsp = require "lspconfig"
local coq = require "coq"

local setup = coq.lsp_ensure_capabilities;
--local setup = function()
--  return {}
--end

lsp.rust_analyzer.setup(setup())
lsp.tsserver.setup(setup())
lsp.vimls.setup(setup())
lsp.ocamlls.setup(setup())
lsp.intelephense.setup(setup({cmd = { "intelephense", "--stdio" }}))

local colors = require("tokyonight.colors").setup()

require("scrollbar").setup({
	handle = {
		color = colors.bg_highlight,
	},
	marks = {
		Search = { color = colors.orange },
		Error = { color = colors.error },
		Warn = { color = colors.warning },
		Info = { color = colors.info },
		Hint = { color = colors.hint },
		Misc = { color = colors.purple },
	}
})

--https://github.com/ray-x/lsp_signature.nvim
--https://github.com/mhinz/vim-crates
--https://github.com/RRethy/vim-illuminate
--https://github.com/jbyuki/instant.nvim
