local function nvim_tree_on_attach(bufnr)
	local api = require("nvim-tree.api")
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	local function change_root_to_node(node)
		if node == nil then
			node = api.tree.get_node_under_cursor()
		end

		if node ~= nil and node.type == "directory" then
			vim.api.nvim_set_current_dir(node.absolute_path)
		end
		api.tree.change_root_to_node(node)
	end

	local function change_root_to_parent(node)
		local abs_path
		if node == nil then
			abs_path = api.tree.get_nodes().absolute_path
		else
			abs_path = node.absolute_path
		end

		local parent_path = vim.fs.dirname(abs_path)
		vim.api.nvim_set_current_dir(parent_path)
		api.tree.change_root(parent_path)
	end

	vim.keymap.set("n", "<C-]>", change_root_to_node, opts("CD"))
	vim.keymap.set("n", "<2-RightMouse>", change_root_to_node, opts("CD"))
	vim.keymap.set("n", "-", change_root_to_parent, opts("Up"))
end

local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup({
			hijack_cursor = true,
            on_attach = nvim_tree_on_attach,
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = true,
				ignore_list = { "help" },
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
			},
			filters = {
				custom = {
					"^.git$",
				},
			},
			actions = {
				change_dir = {
					enable = false,
					restrict_above_cwd = true,
				},
				open_file = {
					resize_window = true,
					window_picker = {
						chars = "aoeui",
					},
				},
				remove_file = {
					close_window = false,
				},
			},
			log = {
				enable = false,
				truncate = true,
				types = {
					all = false,
					config = false,
					copy_paste = false,
					diagnostics = false,
					git = false,
					profile = false,
					watcher = false,
				},
			},
		})
	end,
}
