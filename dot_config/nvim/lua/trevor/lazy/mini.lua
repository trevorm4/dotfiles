local map = vim.keymap.set

return {
	{
		"nvim-mini/mini.nvim",

		version = false,

		config = function()
			require("mini.pick").setup({})
            require("mini.cmdline").setup({})
            require("mini.starter").setup({
                query_updaters = ''
            })
			map("n", "<leader>kf", "<cmd>Pick files<CR>") -- Split below
		end,
	},
}
