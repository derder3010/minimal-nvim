local lualine = require('lualine')

local colors = {
	-- bg = '#202328',
	bg = '#000000',
	fg = '#bbc2cf',
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand('%:p:h')
		local gitdir = vim.fn.finddir('.git', filepath .. ';')
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

local config = {
	options = {
		globalstatus = true,
		component_separators = '',
		section_separators = '',
		theme = {
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
	table.insert(config.sections.lualine_c, component)
end

ins_left {
	function()
		local mode_map = {
			['n']   = 'NORMAL',
			['no']  = 'O-PENDING',
			['nov'] = 'O-PENDING V',
			['noV'] = 'O-PENDING V-L',
			['no'] = 'O-PENDING V-B',
			['niI'] = 'NORMAL i',
			['niR'] = 'NORMAL r',
			['niV'] = 'NORMAL v',
			['nt']  = 'NORMAL T',
			['ntT'] = 'NORMAL T (TUI)',

			['v']   = 'VISUAL',
			['V']   = 'V-LINE',
			['']   = 'V-BLOCK',

			['s']   = 'SELECT',
			['S']   = 'S-LINE',
			['']   = 'S-BLOCK',

			['i']   = 'INSERT',
			['ic']  = 'INSERT c',
			['ix']  = 'INSERT x',

			['R']   = 'REPLACE',
			['Rc']  = 'REPLACE c',
			['Rx']  = 'REPLACE x',
			['Rv']  = 'V-REPLACE',
			['Rvc'] = 'V-REPLACE c',
			['Rvx'] = 'V-REPLACE x',

			['c']   = 'COMMAND',
			['cv']  = 'EX',
			['ce']  = 'EX-NORMAL',

			['r']   = 'HIT-ENTER',
			['rm']  = 'MORE',
			['r?']  = 'CONFIRM',

			['t']   = 'TERMINAL',
		}

		local current_mode = vim.fn.mode()
		return mode_map[current_mode] or current_mode
	end,
	padding = { left = 1 },
}

-- ins_left {
-- 	function()
-- 		local full_path = vim.fn.expand('%:p')
-- 		full_path = full_path:gsub(vim.env.HOME, "~")
-- 		if vim.bo.modified then
-- 			return full_path .. " [+]"
-- 		end
-- 		return full_path
-- 	end,
-- 	cond = conditions.buffer_not_empty,
-- }

ins_left {
	function()
		local full_path = vim.fn.expand('%:.')
		full_path = full_path:gsub(vim.env.HOME, "~")
		if vim.bo.modified then
			return full_path .. " [+]"
		end
		return full_path
	end,
	cond = conditions.buffer_not_empty,
}

ins_left {
	'filesize',
	cond = conditions.buffer_not_empty,

}

ins_left {
	'progress',
	fmt = function()
		return "%P/%L"
	end,
}

ins_left {
	'diagnostics',
	sources = { 'nvim_diagnostic' },
	symbols = { error = 'E-', warn = 'W-', info = 'I-' },
	diagnostics_color = {
		error = { fg = colors.fg },
		warn = { fg = colors.fg },
		info = { fg = colors.fg }
	}
}

ins_right {
	function()
		local bufnr = vim.api.nvim_get_current_buf()
		local clients = vim.lsp.get_clients({ bufnr = bufnr }) -- Only clients for the current buffer

		if not clients or #clients == 0 then
			return ""
		end

		local max_lsp = 2 -- Set the max LSPs to display
		local client_names = vim.tbl_map(function(client)
			return client.name
		end, clients)

		if #client_names > max_lsp then
			client_names = { unpack(client_names, 1, max_lsp) }
			table.insert(client_names, "...") -- Indicate truncation
		end

		return "[" .. table.concat(client_names, ", ") .. "]"
	end,
}

ins_right {
	function()
		local indent = vim.api.nvim_get_option_value("shiftwidth", {})
		local is_spaces = vim.api.nvim_get_option_value("expandtab", {}) and "sps" or "tbs"
		return string.format("%d%s", indent, is_spaces)
	end,
	cond = conditions.buffer_not_empty,
}


ins_right {
	'branch',
	fmt = function(str)
		return '‹' .. str .. '›'
	end,
	icon = ""
}

ins_right {
	'diff',
	symbols = { added = '+', modified = '~', removed = '-' },
	diff_color = {
		added = { fg = colors.fg },
		modified = { fg = colors.fg },
		removed = { fg = colors.fg },
	},
	cond = conditions.hide_in_width,
}
lualine.setup(config)
