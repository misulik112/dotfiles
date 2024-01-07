local config = function()
	require("lualine").setup({
		options = {
			theme = "nord",
			globalstatus = true,
			component_separators = { right = "|", left= "|" },
			section_separators= { right = "", left = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "buffers" },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		tabline = {},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = config,
}
