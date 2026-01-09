return {
	"nvimdev/lspsaga.nvim",
	config = function()
		require("lspsaga").setup({
			outline = {
				layout = "float",
			},
			symbol_in_winbar = {
				enable = false,
			},
			lightbulb = {
				virtual_text = false,
			},
		})

		-- Keymaps go here, not in opts
		local remap = vim.keymap.set
		remap({ "n", "t" }, "<leader>cf", "<cmd>Lspsaga term_toggle<CR>")
		remap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
		remap("n", "<leader>zf", "<cmd>Lspsaga finder<CR>")
		remap("n", "<leader>dn", "<cmd>Lspsaga diagnostic_jump_next<CR>")
		remap("n", "<leader>dp", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
		remap("n", "<leader>r", "<cmd>Lspsaga rename<CR>")
		remap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
		remap("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>")
	end,
	event = "LspAttach",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
}
