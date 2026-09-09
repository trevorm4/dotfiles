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

-- Path to the nvim-base repo managed by chezmoi
local nvim_base_dir = vim.fn.expand("~/.local/share/nvim-base")

require("lazy").setup({
  spec = {
    -- The base config repo
    {
      dir = nvim_base_dir,
      name = "trevor",
      lazy = false,
      priority = 1000,
      config = function()
        require("trevor")
      end,
    },
    -- Import specs from the base config
    { import = "trevor.lazy" },
    -- Import specs from this machine's local configuration (in lua/machine)
    { import = "machine" },
  },
  change_detection = { notify = false },
})

-- Apply colorscheme after everything is loaded
pcall(vim.cmd.colorscheme, "sonokai")
