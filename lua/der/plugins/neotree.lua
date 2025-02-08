local uid_cache = {}
local gid_cache = {}

local truncate_string = function(str, max_length)
	if #str <= max_length then
		return str
	end
	return str:sub(1, max_length - 1) .. "…"
end


local function get_username(uid)
	if uid_cache[uid] then return uid_cache[uid] end
	local username = vim.fn.trim(vim.fn.system("id -nu " .. uid))
	uid_cache[uid] = username
	return username
end

local get_header = function(state, label, size)
	if state.sort and state.sort.label == label then
		local icon = state.sort.direction == 1 and "▲" or "▼"
		size = size - 2
		return vim.fn.printf("%" .. size .. "s %s  ", truncate_string(label, size), icon)
	end
	return vim.fn.printf("%" .. size .. "s  ", truncate_string(label, size))
end

local function get_groupname(gid)
	if gid_cache[gid] then return gid_cache[gid] end
	local groupname = vim.fn.trim(vim.fn.system("id -ng " .. gid))
	gid_cache[gid] = groupname
	return groupname
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		-- vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
		-- vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
		-- vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
		-- vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

		require("neo-tree").setup({
			lazy = false,
			close_if_last_window = false,
			enable_git_status = true,
			enable_diagnostics = true,
			open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
			sort_case_insensitive = false,
			sort_function = nil,
			popup_border_style = "NC",
			use_popups_for_input = false,
			-- hide_root_node = true,
			enable_cursor_hijack = true,
			-- source_selector = {
			--     winbar = false,                        -- toggle to show selector on winbar
			--     statusline = true,                     -- toggle to show selector on statusline
			--     show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
			-- },
			default_component_configs = {
				container = { enable_character_fade = true },
				indent = {
					indent_size = 2,
					padding = 0,
					with_markers = true,
					-- indent_marker = "│",
					-- last_indent_marker = "└",
					indent_marker = "..",
					last_indent_marker = "..",
					highlight = "NeoTreeIndentMarker",
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				-- icon = {
				--     folder_closed = "",
				--     folder_open = "",
				--     folder_empty = "󰜌",
				--     default = "*",
				--     highlight = "NeoTreeFileIcon",
				-- },
				-- modified = { symbol = "[+]", highlight = "NeoTreeModified" },
				name = { trailing_slash = false, use_git_status_colors = true, highlight = "NeoTreeFileName" },
				-- git_status = {
				--     symbols = {
				--         added = "",
				--         modified = "",
				--         deleted = "✖",
				--         renamed = "󰁕",
				--         untracked = "",
				--         ignored = "",
				--         unstaged = "󰄱",
				--         staged = "",
				--         conflict = "",
				--     },
				-- },
				icon = {
					folder_closed = "",           -- No icon for closed folders
					folder_open = "",             -- No icon for open folders
					folder_empty = "",            -- No icon for empty folders
					default = "",                 -- No icon for files
				},
				git_status = {
					symbols = {           -- Remove Git symbols
						added = "",
						modified = "",
						deleted = "",
						renamed = "",
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
				file_size = { enabled = true, width = 10, required_width = 64 },
				type = { enabled = true, width = 10, required_width = 122 },
				last_modified = {
					enabled = true,
					width = 12,
					required_width = 88,
					format = "%b %d %H:%M"
				},
				created = { enabled = false, width = 15, required_width = 110 },
				symlink_target = {
					enabled = false,
					text_format = " ➛ %s", -- %s will be replaced with the symlink target's path.
				},
			},
			commands = {},
			window = {
				position = "bottom",
				-- width = 40,
				mappings = {
					["<space>"] = { "toggle_node", nowait = false },
					["<2-LeftMouse>"] = "open",
					-- ["<cr>"] = "open",
					["<cr>"] = function(state)
						local node = state.tree:get_node()

						if node.type == "directory" then
							-- If it's a directory, set it as the root
							require("neo-tree.sources.filesystem").navigate(state, node.id)
						else
							-- If it's a file, open it
							require("neo-tree.utils").open_file(state, node.path)
						end
					end,
					["<esc>"] = "cancel",
					["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
					["S"] = "open_split",
					["s"] = "open_vsplit",
					["t"] = "open_tabnew",
					["w"] = "open_with_window_picker",
					["C"] = "close_node",
					["z"] = "close_all_nodes",
					["%"] = { "add", config = { show_path = "none" } },
					["d"] = "add_directory",
					["D"] = "delete",
					["r"] = "rename",
					-- ["b"] = "rename_basename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy",
					["m"] = "move",
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
					["<"] = "prev_source",
					[">"] = "next_source",
					["i"] = "show_file_details",
				},
			},
			filesystem = {
				components = {
					permissions = function(config, node, state)
						local stat = vim.loop.fs_stat(node.path)
						local highlights = require("neo-tree.ui.highlights")
						if not stat then return {} end

						local perm_width = 9
						if node:get_depth() == 1 then
							return {
								text = get_header(state, "Pers", perm_width),
								highlight = highlights.FILE_STATS_HEADER,
							}
						end

						local function format_permissions(mode)
							local owner = bit.band(bit.rshift(mode, 6), 7)
							local group = bit.band(bit.rshift(mode, 3), 7)
							local others = bit.band(mode, 7)

							local prefix = node.type == "directory" and "d" or "-"
							local suffix = "."
							local function perm_string(perm)
								return string.format("%s%s%s",
									bit.band(perm, 4) ~= 0 and "r" or "-",
									bit.band(perm, 2) ~= 0 and "w" or "-",
									bit.band(perm, 1) ~= 0 and "x" or "-")
							end

							return vim.fn.printf(prefix ..
								perm_string(owner) .. perm_string(group) .. perm_string(others) .. suffix)
						end

						return {
							text = string.format("%s",
								format_permissions(stat.mode)
							-- stat.nlink or 1, -- Number of hard links
							-- get_username(stat.uid)
							-- get_groupname(stat.gid) or "Unknown"
							),
							-- text = format_permissions(stat.mode),
							highlight = highlights.FILE_STATS,
						}
					end,
					number_links = function(config, node, state)
						local stat = vim.loop.fs_stat(node.path)
						local highlights = require("neo-tree.ui.highlights")
						if not stat then return {} end

						local perm_width = 6
						if node:get_depth() == 1 then
							return {
								text = get_header(state, "Links", perm_width),
								highlight = highlights.FILE_STATS_HEADER,
							}
						end

						return {
							-- text = string.format("%d",
							--     stat.nlink or 1 -- Number of hard links
							-- ),
							text = vim.fn.printf("%" .. perm_width .. "d  ",
								stat.nlink or 1),

							highlight = highlights.FILE_STATS,
						}
					end,
					owner = function(config, node, state)
						local stat = vim.loop.fs_stat(node.path)
						local highlights = require("neo-tree.ui.highlights")
						if not stat then return {} end

						local perm_width = 6
						if node:get_depth() == 1 then
							return {
								text = get_header(state, "Owner", perm_width),
								highlight = highlights.FILE_STATS_HEADER,
							}
						end


						return {
							-- text = string.format("%s",
							--     get_username(stat.uid)
							-- ),
							text = vim.fn.printf("%" .. perm_width .. "s  ",
								truncate_string(get_username(stat.uid), perm_width)),
							highlight = highlights.FILE_STATS,
						}
					end


				},
				renderers = {
					directory = {
						{ "permissions",  zindex = 10 },
						{ "number_links", zindex = 10 },
						{ "owner",        zindex = 10 },
						{
							"file_size",
							zindex = 20,
							align = "left",               -- Align to the right
						},
						-- {
						--     "type",
						--     zindex = 10,
						--     align = "left", -- Align to the left
						-- },
						{
							"last_modified",
							align = "left",               -- Align to the right
						},
						{ "indent" },
						{
							"name",
							zindex = 20,
						}
					},
					file = {
						{ "permissions",  zindex = 10 },
						{ "number_links", zindex = 10 },
						{ "owner",        zindex = 10 },
						{
							"file_size",
							align = "left",               -- Align to the right
						},
						-- {
						--     "type",
						--     zindex = 10,
						--     align = "left", -- Align to the left
						-- },
						{
							"last_modified",
							align = "left",               -- Align to the right
						},
						{ "indent" },
						{
							"name",
						}
					}
				},
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false,
				},
				follow_current_file = { enabled = true, leave_dirs_open = true },
				group_empty_dirs = false,
				-- hijack_netrw_behavior = "disabled", -- to set "open_default"
				hijack_netrw_behavior = "open_current",         -- to set "open_default"
				use_libuv_file_watcher = true,
				window = {
					-- position = "left",
					mappings = {
						["<bs>"] = "navigate_up",
						["."] = "set_root",
						["H"] = "toggle_hidden",
						["/"] = "fuzzy_finder",
						["F"] = "fuzzy_finder_directory",
						["f"] = "filter_on_submit",
						["<c-x>"] = "clear_filter",
						["[g"] = "prev_git_modified",
						["]g"] = "next_git_modified",
					},
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function()
						-- Auto-close the tree when opening a file
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
				{
					event = "file_renamed",
					handler = function(args)
						-- fix references to file
						print(args.source, " renamed to ", args.destination)
					end
				},
				{
					event = "file_moved",
					handler = function(args)
						-- fix references to file
						print(args.source, " moved to ", args.destination)
					end
				},
				-- {
				--     event = "neo_tree_buffer_enter",
				--     handler = function()
				--         vim.cmd("highlight! Cursor blend=100")
				--     end,
				-- },
				-- {
				--     event = "neo_tree_buffer_leave",
				--     handler = function()
				--         vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
				--     end,
				-- },
				-- {
				--     event = "file_opened",
				--     handler = function()
				--         require("neo-tree.sources.filesystem").reset_search()
				--     end
				-- },
			},
			buffers = {
				follow_current_file = { enabled = true, leave_dirs_open = false },
				group_empty_dirs = true,
				show_unloaded = true,
				window = { mappings = { ["bd"] = "buffer_delete", ["<bs>"] = "navigate_up", ["."] = "set_root" } },
			},
			git_status = {
				window = {
					position = "float",
					mappings = {
						["A"] = "git_add_all",
						["gu"] = "git_unstage_file",
						["ga"] = "git_add_file",
						["gr"] = "git_revert_file",
						["gc"] = "git_commit",
						["gp"] = "git_push",
						["gg"] = "git_commit_and_push",
					},
				},
			},
		})
		-- vim.cmd([[nnoremap \ :Neotree float<cr>]])
	end,
}
