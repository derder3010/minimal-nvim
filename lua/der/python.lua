local M = {}

local path = require('lspconfig.util').path

local function get_pipenv_dir()
	return vim.fn.trim(vim.fn.system 'pipenv --venv')
end

local function get_poetry_dir()
	return vim.fn.trim(vim.fn.system 'poetry env info -p')
end

local function get_pdm_package()
	return vim.fn.trim(vim.fn.system 'pdm info --packages')
end

local function get_python_dir(workspace)
	local poetry_match = vim.fn.glob(path.join(workspace, 'poetry.lock'))
	if poetry_match ~= '' then
		return get_poetry_dir()
	end

	local pipenv_match = vim.fn.glob(path.join(workspace, 'Pipfile.lock'))
	if pipenv_match ~= '' then
		return get_pipenv_dir()
	end

	-- Find and use virtualenv in workspace directory (.venv)
	for _, pattern in ipairs { '*', '.*' } do
		local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
		if match ~= '' then
			return path.dirname(match)
		end
	end

	return ''
end

M.get_python_path = function(root_dir)
	local venv_path = get_python_dir(root_dir)
	if venv_path ~= '' then
		return path.join(venv_path, 'bin', 'python')
	end
	return 'python'   -- Fallback to system Python
end

return M
