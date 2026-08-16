return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = false,
      styles = {
        comments = { "italic" },
        keywords = { "italic" },
      },
      integrations = {
        cmp = false,
        blink_cmp = true,
        gitsigns = true,
        telescope = { enabled = true },
        which_key = true,
        indent_blankline = { enabled = true },
        mini = { enabled = true },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
        treesitter = true,
        mason = true,
        notify = true,
        bufferline = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin")
    end,
  },
}
