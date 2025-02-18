return {
	'nvim-lua/plenary.nvim',
	{
		'nvim-lualine/lualine.nvim',
	},
	{ "RRethy/vim-illuminate",  event = "VeryLazy" },
	'windwp/nvim-ts-autotag',
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = false
	},
	{
		'numToStr/Comment.nvim',
	},
	{
		"ibhagwan/fzf-lua",
		cmd = "FzfLua",
	},
	{
		"blazkowolf/gruber-darker.nvim",
	},
	{
		"j-hui/fidget.nvim",
		branch = "main", -- ensures you're using the latest version
	},
	{
		"ashen-org/ashen.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = {
				bold = false,
				italic = false,
			},
		},
	},
	{ 'nvim-tree/nvim-tree.lua' }
}
