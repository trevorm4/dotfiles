local map = vim.keymap.set
local opts = { noremap = true, silent = true }

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)  -- alternative
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

return {
	"waiting-for-dev/ergoterm.nvim",
	version = "*",
	config = function()
		require("ergoterm").setup()
		-- Terminal creation with different layouts
		map("n", "<leader>cb", ":TermNew layout=below<CR>", opts) -- Split below
		map("n", "<leader>cr", ":TermNew layout=right<CR>", opts) -- Vertical split
		map("n", "<leader>cf", ":TermNew layout=float<CR>", opts) -- Floating window
		map("n", "<leader>ct", ":TermNew layout=tab<CR>", opts) -- New tab
		--        map("t", "<esc>", [[<C-\><C-n>]], opts)
	end,
}
