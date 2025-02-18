-- Set 2-space indentation for JavaScript, TypeScript, HTML, CSS, Vue, JSON, YAML, and Ruby
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "typescript", "html", "css", "vue", "json", "yaml", "ruby", "typescriptreact", "javascriptreact" },
	callback = function()
		vim.opt.tabstop = 2
		vim.opt.shiftwidth = 2
		vim.opt.expandtab = true
	end
})

-- Set tab-based indentation for Go, Makefile, and other languages that use tabs
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go", "make", "haskell", "rust", "lua", "c", "cpp", "swift", "kotlin" },
	callback = function()
		vim.opt.expandtab = false -- Use real tabs
		vim.opt.tabstop = 2     -- A tab represents 4 spaces (this can vary per language)
		vim.opt.shiftwidth = 2  -- Indentation width with tabs
	end
})

vim.api.nvim_create_autocmd("BufReadPre", {
	pattern = "*",
	callback = function()
		local max_filesize = 5 * 1024 * 1024 -- 5MB (Adjust as needed)
		local file = vim.fn.expand("<afile>")
		local size = vim.fn.getfsize(file)

		if size > max_filesize then
			vim.opt.synmaxcol = 500    -- Limit syntax highlighting columns
			vim.opt.lazyredraw = true  -- Improve scrolling performance
			vim.opt.updatetime = 3000  -- Reduce frequent updates
			vim.opt.swapfile = false   -- Disable swap file
			vim.opt.undofile = false   -- Disable undo file
			vim.opt.foldenable = false -- Prevent folding lag
			print("Performance mode enabled for large file")
		end
	end,
})



-- vim.cmd([[ let $VIRTUAL_ENV = finddir('.venv', '.;') ]])
-- vim.api.nvim_create_autocmd("BufReadPost", {
-- 	pattern = "*.py",
-- 	callback = function()
-- 		-- Find `.venv` folder in project directory
-- 		local project_root = vim.fn.getcwd()
-- 		local venv_python = project_root .. "/.venv/bin/python3"
--
-- 		-- Check if the virtual environment exists
-- 		if vim.fn.filereadable(venv_python) == 1 then
-- 			-- Run PyrightSetPythonPath automatically
-- 			vim.cmd("PyrightSetPythonPath " .. venv_python)
-- 			print("Pyright Python path set to: " .. venv_python)
-- 		end
-- 	end,
-- })
