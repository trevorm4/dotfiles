local map = vim.keymap.set
local opts = { noremap = true, silent = true }

return {
    'swaits/lazyjj.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
	config = function()
		require("lazyjj").setup({
            mapping = "<leader>jj"
        })
	end,
}
