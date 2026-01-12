
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "SmiteshP/nvim-navic" },
	config = function()
		require("lualine").setup({
			sections = {
				lualine_b = {
					{ require("trevor.components.jujutsu").component },
				},
				lualine_c = {
					require("lspsaga.symbol.winbar").get_bar,
				},
				lualine_x = {},
			},
			inactive_sections = {},
		})
	end,
}
