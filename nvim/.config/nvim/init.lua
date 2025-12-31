-- options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- required for nvim-cmp UI
vim.opt.winborder = "rounded"                           -- rounded borders for LSP floats
vim.g.mapleader = " "

-- plugins (native pack)
vim.packadd = vim.pack.add

vim.packadd({
	{ src = "https://github.com/vague2k/vague.nvim" },

	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/echasnovski/mini.comment" },

	{ src = "https://github.com/stevearc/oil.nvim" },

	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" }, -- mason ↔ lsp bridge

	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" }, -- exposes LSP completion to cmp
	{ src = "https://github.com/hrsh7th/cmp-buffer" },

	{ src = "https://github.com/vimwiki/vimwiki" },
})

-- mason
require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = { "gopls", "golangci_lint_ls", "lua_ls" }, -- install servers automatically
})

-- lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
-- ↑ without this, LSP completion won't show in nvim-cmp

vim.lsp.config("*", {
	capabilities = capabilities, -- apply to all servers
})

vim.lsp.enable({
	"gopls",
	"golangci_lint_ls",
	"lua_ls",
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true), -- let lua_ls see Neovim runtime
			},
			diagnostics = {
				globals = { "vim" }, -- avoid false positives in config
			},
		},
	},
})

-- format & diagnostics on save
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format({ async = false }) -- block to ensure file is formatted before save
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		vim.diagnostic.enable(true) -- refresh diagnostics after save
	end,
})

-- completion
local cmp = require("cmp")

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(), -- manual trigger if auto-popup is off
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Esc>"] = cmp.mapping.abort(),
	}),
	sources = {
		{ name = "nvim_lsp" }, -- primary source
		{ name = "buffer" }, -- fallback words from buffer
	},
})

-- diagnostics
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float) -- inspect error under cursor

-- ui
require("mini.pick").setup()
require("mini.comment").setup()
require("oil").setup()

vim.cmd("colorscheme vague")
vim.cmd("hi statusline guibg=NONE") -- let terminal background show through

-- vimwiki
vim.g.vimwiki_list = {
	{ syntax = "markdown", ext = ".md" },
}
vim.g.vimwiki_global_ext = 0 -- don't hijack all markdown files

-- keymaps
local map = vim.keymap.set

map("n", "<leader>w", ":write<CR>")
map("n", "<leader>q", ":quit<CR>")
map("n", "<leader>o", ":update<CR>:source<CR>")

map({ "n", "v" }, "<leader>y", '"+y')
map({ "n", "v" }, "<leader>d", '"+d')

map("v", "<Tab>", ">gv")
map("v", "<S-Tab>", "<gv")

map("n", "<leader>f", ":Pick files<CR>")
map("n", "<leader>h", ":Pick help<CR>")
map("n", "<leader>e", ":Oil<CR>")

map("n", "K", vim.lsp.buf.hover) -- show docs / error details
map("n", "gd", vim.lsp.buf.definition)
map("n", "<leader>lf", vim.lsp.buf.format)
