local map = vim.keymap.set

return {
	"nvim-mini/mini.nvim",

	version = false,

	config = function()
		require("mini.pick").setup({})
		map("n", "<leader>kf", ":Pick files<CR>", opts) -- Split below
	end,
}
