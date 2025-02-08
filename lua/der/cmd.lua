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
