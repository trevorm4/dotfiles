local map = vim.keymap.set
local opts = { noremap = true, silent = true }
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts) -- alternative
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

return {
	"waiting-for-dev/ergoterm.nvim",
	version = "*",
	config = function()
		local Terminal = require("ergoterm")
		Terminal.setup()

		local function prompt_for_name_and_open_terminal(layout)
			local name = vim.fn.input("Enter terminal name: ")
			if name and name ~= "" then
				Terminal:new({ name = string.format("%s (%s)", name, layout), layout = layout }):focus(layout)
			else
				print("No terminal name provided.")
			end
		end
		-- Terminal creation with different layouts
		map("n", "<leader>cb", function()
			prompt_for_name_and_open_terminal("below")
		end, opts)
		map("n", "<leader>cr", function()
			prompt_for_name_and_open_terminal("right")
		end, opts)
		map("n", "<leader>cf", function()
			prompt_for_name_and_open_terminal("float")
		end, opts)
		map("n", "<leader>ct", function()
			prompt_for_name_and_open_terminal("tab")
		end, opts)
		map("n", "<leader>cs", ":TermSelect<CR>", opts) -- select terminal
		map("n", "<leader>cl", ":TermSelect!<CR>", opts) -- select last terminal
	end,
}
