return {
  -- File explorer
  {
    "echasnovski/mini.files",
    version = "*",
    keys = {
      {
        "<leader>e",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "File explorer (current file)",
      },
      {
        "<leader>E",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "File explorer (cwd)",
      },
    },
    opts = {
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 50,
      },
      options = { use_as_default_explorer = false },
    },
  },

  -- Auto pairs
  {
    "echasnovski/mini.pairs",
    version = "*",
    event = "InsertEnter",
    opts = {},
  },

  -- Surround
  {
    "echasnovski/mini.surround",
    version = "*",
    keys = { "sa", "sd", "sf", "sF", "sh", "sr", "sn" },
    opts = {
      mappings = {
        add = "sa",
        delete = "sd",
        find = "sf",
        find_left = "sF",
        highlight = "sh",
        replace = "sr",
        update_n_lines = "sn",
      },
    },
  },

  -- Auto-formatting
  

  -- Which-key: keybinding popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 100,
      plugins = { spelling = true },
      spec = {
        { "<leader>f", group = "find/files" },
        { "<leader>h", group = "git hunks" },
        { "<leader>d", group = "diagnostics/delete" },
        { "<leader>c", group = "code" },
        { "<leader>r", group = "rename/run" },
      },
    },
  },
}
