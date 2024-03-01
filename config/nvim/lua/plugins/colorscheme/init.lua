return {
  { 
    "rebelot/kanagawa.nvim", 
    enabled = true, 
    lazy = false, 
    name = "kanagawa",
    theme = "dragon",
    config = function()
      vim.cmd.colorscheme "kanagawa"
    end,
  }
}
