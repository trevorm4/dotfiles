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
        vim.cmd.colorscheme("sonokai")
      end,
    },
    { import = "trevor.lazy" },
  },
  change_detection = { notify = false },
})
