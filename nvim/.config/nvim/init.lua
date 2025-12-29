vim.opt.number         = true          -- Show absolute line number
vim.opt.relativenumber = true          -- Show relative line numbers
vim.opt.signcolumn     = "yes"         -- Always show signcolumn
vim.opt.wrap           = true          -- Wrap long lines
vim.opt.tabstop        = 4             -- A tab equals 4 spaces
vim.opt.shiftwidth     = 4             -- Indent/outdent by 4 spaces
vim.opt.expandtab      = false         -- Use actual tabs (set true for spaces)
vim.opt.swapfile       = false         -- Disable swapfile
vim.opt.clipboard      = "unnamedplus" -- Yank/delete to system clipboard
vim.g.mapleader        = " "           -- Leader key = Space
vim.opt.winborder      = "rounded"     -- Rounded borders for floating windows

vim.fn.stdpath("data")                 -- ensures data path exists
vim.packadd = vim.pack.add
vim.packadd({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
})

require "mason".setup()

-- Use built-in omnifunc for LSP and enable <C-x><C-o>
vim.opt.completeopt = { "menuone", "noselect", "popup" }

-- Attach autocmd to enable omnifunc on LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local buf = ev.buf
		vim.bo[buf].omnifunc = "v:lua.vim.lsp.omnifunc"
	end,
})


-- Enable Lua language server via lspconfig
vim.lsp.enable({ "lua_ls", "svelte", "tinymist", "emmetls" })
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			}
		}
	}
})

-- mini.pick (fuzzy finder)
require("mini.pick").setup()

-- oil.nvim (file explorer)
require("oil").setup()

-- Apply colorscheme and adjust statusline background
vim.cmd("colorscheme vague")
vim.cmd("hi statusline guibg=NONE")

local map = vim.keymap.set
-- Save, reload, quit
map("n", "<leader>o", ":update<CR>:source<CR>", { desc = "Save & reload config" })
map("n", "<leader>w", ":write<CR>", { desc = "Save file" })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit" })

-- Yank/Delete to system clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>d", '"+d', { desc = "Delete to system clipboard" })
-- Override default delete to clipboard (optional)
map("n", "d", '"+d', { desc = "Cut to system clipboard" })
map("x", "d", '"+d', { desc = "Cut to system clipboard" })

-- Indentation in Visual and Visual-Block modes
-- Use Tab and Shift-Tab to indent/unindent selected lines
map("v", "<Tab>", ">gv", { desc = "Indent selection" })
map("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })

-- Omni-completion triggers
map("i", "<C-x><C-o>", "<C-x><C-o>", { desc = "Omni-completion" })
map("i", "<C-Space>", "<C-x><C-o>", { desc = "Trigger completion" })

-- File pickers
map("n", "<leader>f", ":Pick files<CR>", { desc = "Find files" })
map("n", "<leader>h", ":Pick help<CR>", { desc = "Search help" })
map("n", "<leader>e", ":Oil<CR>", { desc = "Open file explorer" })

-- LSP formatting
map("n", "<leader>lf", function() vim.lsp.buf.format() end, { desc = "LSP format buffer" })
