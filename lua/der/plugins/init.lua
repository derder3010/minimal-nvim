return {
	'nvim-lua/plenary.nvim',
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
	},
	{
		'nvim-lualine/lualine.nvim',
	},
	-- { "RRethy/vim-illuminate", event = "VeryLazy" },
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

}
