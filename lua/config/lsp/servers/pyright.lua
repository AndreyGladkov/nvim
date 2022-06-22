local venv_selector = require 'venv-selector'



local M = {}

M.settings = {
    pyright = {
        autoImportCompletion = true,
    },
    python = {
        analysis = {
            autoSearchPaths = true,
            diagnosticMode = 'openFilesOnly',
            useLibraryCodeForTypes = true,
            typeCheckingMode = 'off'
        },
    }
}

venv_selector.setup {
  --- other configuration
  changed_venv_hooks = { venv_selector.hooks.pyright },
}

return M
