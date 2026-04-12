local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "trevorm4/nvim-base",
      name = "trevor",
      lazy = false,
      priority = 1000,
      config = function()
        require("trevor")
      end,
    },
    { import = "trevor.lazy" },
  },
  change_detection = { notify = false },
})

-- Parity with nvim-base/lua/trevor/init.lua
local augroup = vim.api.nvim_create_augroup
local group = augroup("Trevor", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
  require("plenary.reload").reload_module(name)
end

vim.filetype.add({
  extension = {
    templ = "templ",
  },
})

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

autocmd({ "BufWritePre" }, {
  group = group,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

vim.o.autoread = true

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
