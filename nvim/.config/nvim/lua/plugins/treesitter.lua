return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "rust", "c", "cpp",
        "lua", "vim", "vimdoc",
        "bash", "toml", "json", "jsonc",
        "yaml", "markdown", "markdown_inline",
        "regex", "diff",
        "javascript", "typescript", "tsx", "html", "css", "scss",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
    end,
  },
}
