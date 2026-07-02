return {

  {
    "folke/snacks.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {
      image = { enabled = true },
      picker = { enabled = true },
    },
  },

  {
    "numToStr/Comment.nvim",
  },

  { "wakatime/vim-wakatime", lazy = false, enabled = false },

  { "github/copilot.vim", event = "VeryLazy" },
}
