-- Jujutsu component for lualine
-- Shows change ID and bookmark for current buffer's jj repository

local M = {}

-- Cache to avoid excessive jj calls
local jj_cache = {
	cache_duration = 2, -- seconds
}

-- Function to execute jj command and get output
local function exec_jj(args, cwd)
	local cmd = "jj " .. args .. " 2>/dev/null"
	if cwd then
		cmd = "cd " .. vim.fn.shellescape(cwd) .. " && " .. cmd
	end
	local handle = io.popen(cmd)
	if not handle then
		return nil
	end
	local result = handle:read("*a")
	handle:close()
	return result and result:match("^%s*(.-)%s*$") or nil
end

-- Function to get change ID
local function get_change_id(cwd)
	local result = exec_jj('log -r @ --no-graph -T "change_id.shortest()"', cwd)
	return result
end

-- Function to get bookmark
local function get_bookmark(cwd)
	local result = exec_jj('log -r @ --no-graph -T "bookmarks"', cwd)
	if result and result ~= "" then
		return result
	end
	return nil
end

-- Function to update cache
local function update_jj_cache(cwd)
	local now = os.time()
	local cache_key = cwd or "default"

	if not jj_cache[cache_key] then
		jj_cache[cache_key] = {
			change_id = nil,
			bookmark = nil,
			last_update = 0,
		}
	end

	local cache = jj_cache[cache_key]
	if now - cache.last_update < jj_cache.cache_duration then
		return cache
	end

	cache.change_id = get_change_id(cwd)
	cache.bookmark = get_bookmark(cwd)
	cache.last_update = now

	return cache
end

-- Main component function
function M.component()
	-- Get current buffer's directory using Neovim API
	local bufpath = vim.api.nvim_buf_get_name(0)
	local cwd

	-- Check if buffer is a real file
	if bufpath ~= "" and vim.fn.filereadable(bufpath) == 1 then
		cwd = vim.fs.dirname(bufpath)
	else
		-- Fall back to current working directory for non-file buffers
		cwd = vim.fn.getcwd()
	end

	-- Check if we're in a jj repo
	local handle = io.popen("cd " .. vim.fn.shellescape(cwd) .. " && jj root 2>/dev/null")
	if not handle then
		return ""
	end
	local root = handle:read("*a")
	handle:close()

	if not root or root == "" then
		return ""
	end

	-- Update cache for this directory
	local cache = update_jj_cache(cwd)

	-- Build display string
	local parts = {}

	if cache.change_id and cache.change_id ~= "" then
		table.insert(parts, cache.change_id)
	end

	if cache.bookmark and cache.bookmark ~= "" then
		table.insert(parts, "(" .. cache.bookmark .. ")")
	end

	if #parts == 0 then
		return ""
	end

	return " " .. table.concat(parts, " ")
end

return M
