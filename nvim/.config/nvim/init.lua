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
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- required for cmp
vim.opt.winborder = "rounded"                           -- affects LSP / diagnostic floats
vim.opt.clipboard = "unnamedplus"
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
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },

	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },

	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvimtools/none-ls.nvim" },

	{ src = "https://github.com/vimwiki/vimwiki" },
})

-- mason
require("mason").setup()

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
require("mason-lspconfig").setup({
	ensure_installed = {
		"gopls",
		"golangci_lint_ls",
		"golangci-lint",
		"lua_ls",
		"clangd",
		"elixirls",
		"terraformls",
		"docker_compose_language_service",
		"docker_language_server",
		"dockerls"
	},
})

-- lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
-- without this, LSP completion won't appear in cmp

vim.lsp.config("*", {
	capabilities = capabilities,
})

vim.lsp.enable({
	"gopls",
	"golangci_lint_ls",
	"golangci-lint",
	"lua_ls",
	"clangd",
	"elixirls",
	"terraformls",
	"docker_compose_language_service",
	"docker_language_server",
	"dockerls"
})

-- https://neovim.io/doc/user/lsp.html
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true), -- expose Neovim runtime
			},
			diagnostics = {
				globals = { "vim" }, -- avoid false positives
			},
		},
	},
})

-- null-ls (formatters / linters)
local null_ls = require("null-ls")


null_ls.setup({
	sources = {
		-- formatters
		null_ls.builtins.formatting.prettier, -- js / ts / html / tailwind
		null_ls.builtins.formatting.stylua, -- lua
		null_ls.builtins.formatting.clang_format, -- c / cpp
		null_ls.builtins.formatting.mix,    -- elixir
		null_ls.builtins.formatting.terraform_fmt -- terraform fmt
	},
})

-- format & diagnostics on save
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format({ async = false }) -- blocks to avoid race conditions
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
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Esc>"] = cmp.mapping.abort(),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
	},
})

-- diagnostics
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float) -- inspect error under cursor

-- ui
require("mini.pick").setup()
require("mini.comment").setup()
require("oil").setup()

vim.cmd("colorscheme vague")
vim.cmd("hi statusline guibg=NONE") -- transparent statusline

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

--- vimwiki
map("n", "<leader>tt", "<cmd>VimwikiToggleListItem<CR>")
map("v", "<leader>tt", "<cmd>VimwikiToggleListItem<CR>")

map("v", "<Tab>", ">gv")
map("v", "<S-Tab>", "<gv")

map("n", "<leader>f", ":Pick files<CR>")
map("n", "<leader>h", ":Pick help<CR>")
map("n", "<leader>e", ":Oil<CR>")

map("n", "K", vim.lsp.buf.hover)
map("n", "gd", vim.lsp.buf.definition)
map("n", "<leader>lf", vim.lsp.buf.format)
