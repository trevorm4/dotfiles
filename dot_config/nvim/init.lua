vim.g.mapleader = " "

-- Bootstrap lazy.nvim
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
    -- Import specs from the plugin
    { import = "trevor.lazy" },
    -- Import specs from this machine's local configuration (e.g. code-layout, lazyjj)
    { import = "trevor.machine" },
  },
  change_detection = { notify = false },
})

-- Apply colorscheme after lazy setup
vim.cmd.colorscheme("sonokai")
