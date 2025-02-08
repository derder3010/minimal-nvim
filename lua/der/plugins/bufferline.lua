return {
	'akinsho/bufferline.nvim',
	version = "*",
	event = 'ColorScheme',
	config = function()
		require('bufferline').setup({
			options = {
				themable = true,
				always_show_bufferline = false,
				sort_by = 'insert_after_current',
				offsets = {
					{
						filetype = 'NvimTree',
						text = 'File Explorer',
						highlight = 'Directory',
						separator = true,
					}
				},
				separator_style = 'thin',
				hover = {
					enabled = true,
					delay = 200,
					reveal = { 'close' }
				},
				custom_areas = {
					right = function()
						return {
							{ text = ' ' }               -- Add space for better visual balance
						}
					end
				}
			},
			highlights = {
				fill = {
					bg = 'None'           -- Fully transparent background
				},
				background = {
					bg = 'None'
				},
				tab = {
					bg = 'None'
				},
				tab_selected = {
					bg = 'None'
				},
				tab_close = {
					bg = 'None'
				},
				close_button = {
					bg = 'None'
				},
				close_button_visible = {
					bg = 'None'
				},
				close_button_selected = {
					bg = 'None'
				},
				buffer_visible = {
					bg = 'None'
				},
				buffer_selected = {
					bg = '#1e1e2e',           -- Slight highlight for active buffer
					italic = false
				},
				separator = {
					fg = '#1e1e2e',
					bg = 'None'
				},
				separator_visible = {
					fg = '#1e1e2e',
					bg = 'None'
				},
				separator_selected = {
					fg = '#1e1e2e',
					bg = 'None'
				},
			}
		})
	end
}
