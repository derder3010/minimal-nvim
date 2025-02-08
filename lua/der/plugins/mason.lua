return {
    "williamboman/mason.nvim",
    dependencies = "williamboman/mason-lspconfig.nvim",
    config = function()
        require("mason").setup {
            ui = { border = "rounded" }
        }
        require("mason-lspconfig").setup {
            ensure_installed = {
                "lua_ls",
                "cssls",
                "html",
                "pyright",
                "bashls",
                "jsonls",
                "rust_analyzer"
            }
        }
    end
}
