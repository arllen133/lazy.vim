return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
      -- colorscheme = "catppuccin",
    },
  },
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = true,
    enabled = true,
    priority = 1000,
    opts = { style = "storm" },
  },
  {
    "catppuccin/nvim",
    lazy = true,
    enabled = false,
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
    },
  },
}
