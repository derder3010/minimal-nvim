require("der.remap")
require("der.lazy_init")
require("der.set")
require("der.lualine")
require("der.cmd")

-- ColorScheme
vim.cmd("colorscheme gruber-darker")
-- vim.cmd("au ColorScheme * hi Normal ctermbg=none guibg=none")
-- vim.cmd("au ColorScheme * hi NormalFloat ctermbg=none guibg=none")
-- vim.cmd("au ColorScheme * hi SignColumn ctermbg=none guibg=none")
-- vim.cmd("au ColorScheme * hi NormalNC ctermbg=none guibg=none")
-- vim.cmd("au ColorScheme * hi MsgArea ctermbg=none guibg=none")
-- vim.cmd("au ColorScheme * hi TelescopeBorder ctermbg=none guibg=none")
-- vim.cmd("au ColorScheme * hi NvimTreeNormal ctermbg=none guibg=none")
vim.cmd("doautocmd ColorScheme")

require("markview").setup({
	preview = {
		debounce = 50,
		filetypes = { "markdown", "quarto", "rmd" },
		highlight_groups = "dark",
		hybrid_modes = nil,
		injections = {
			languages = {
				markdown = {
					enable = true,
					overwrite = true,
					query = [[
                    (section
                        (atx_headng) @injections.mkv.fold
                        (#set! @fold))
                ]]
				}
			}
		}
	}
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})


require('nvim-treesitter.configs').setup({
	ensure_installed = { 'typescript', 'tsx', 'jsonc' },
	highlight = { enable = true },
})

require('ts_context_commentstring').setup {
	enable_autocmd = false, -- Manual control, let Comment.nvim handle it
}

require('Comment').setup({
	pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})

require('nvim-ts-autotag').setup({
	aliases = {
		["tsx"] = "html",
	}
})


require("fzf-lua").setup({
	winopts = {
		height = 0.3,                  -- Small height, like Doom Emacs
		width = 1,                     -- Full width
		row = 1,                       -- Align to bottom
		col = 0.5,                     -- Center horizontally
		preview = { hidden = "hidden" }, -- Disable preview
		border = "none",
	},
	fzf_opts = {
		["--no-scrollbar"] = true, -- Optional: Hide scrollbar like Doom Emacs
	},

	files = {
		cwd_prompt = true,
		actions = {
			["alt-i"] = require("fzf-lua").actions.toggle_ignore,
			["alt-h"] = require("fzf-lua").actions.toggle_hidden,
			["left"] = function(_, opts)                    -- Move to parent dir on backspace
				local parent = vim.fn.fnamemodify(opts.cwd, ":h") -- Get parent dir
				require("fzf-lua").files({ cwd = parent })
			end,

		},
		fd_opts = "--hidden --no-ignore", -- Show hidden & dotfiles
	},
})

require("fidget").setup({
	-- options = {
	-- 	window = {
	-- 		winblend = 20, -- Increase this value for more transparency (0 = opaque, 100 = fully transparent)
	-- 	},
	-- }
})
