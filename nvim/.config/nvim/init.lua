-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Compatibility shim for Neovim 0.11+ (removed ft_to_lang)
if not vim.treesitter.language.ft_to_lang then
  vim.treesitter.language.ft_to_lang = function(ft)
    return vim.treesitter.language.get_lang(ft) or ft
  end
end

-- Load core config
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Load plugins
require("lazy").setup("plugins", {
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "matchparen",
        "tarPlugin", "tohtml", "tutor", "zipPlugin",
      },
    },
  },
})
