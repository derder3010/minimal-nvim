return {
	{
		'saecki/crates.nvim',
		tag = 'stable',
		config = function()
			require('crates').setup({
				completion = {
					cmp = {
						enabled = true,
					},
					crates = {
						enabled = true,
					}
				},
				null_ls = {
					enabled = true,
				},
				lsp = {
					enabled = true,
					completion = true,
					hover = true,
					-- action = true,
				}
			})
		end,
	},
	{
		'mg979/vim-visual-multi',
		branch = 'master',
		config = function()
			-- Tạo bảng map key cho vim-visual-multi
			vim.g.VM_maps = {
				['Find Under'] = '<C-d>',     -- Thay thế cho C-n
				['Find Subword Under'] = '<C-d>', -- Thay thế cho visual C-n
			}
		end
	}
}
