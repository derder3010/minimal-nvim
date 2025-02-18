return {
	'rmagatti/auto-session',
	lazy = true,
	keys = {
		{ '<leader>s',  '<cmd>SessionSearch<CR>',         desc = 'Session search' },
		{ '<leader>ss', '<cmd>SessionSave<CR>',           desc = 'Save session' },
		{ '<leader>st', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
	},

	opts = {
		session_lens = {
			load_on_setup = false,
			previewer = true,
			mappings = {
				delete_session = { "i", "<C-D>" },
				alternate_session = { "i", "<C-S>" },
				copy_session = { "i", "<C-Y>" },
			},
			theme_conf = {
				border = true,
			},
		},
	}
}
