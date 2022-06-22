require('config.EcoVim')

require('utils.globals')
require('utils.functions')

require('config.options')
require('config.lazy')
require('config.keymappings')
require('config.autocmds')
require('config.lsp.config')
require('config.lsp.setup')
require('config.lsp.functions')

require('internal.winbar')
require('internal.cursorword')
require('theme')

require('snippets.react')

if vim.g.neovide then
    vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.g.neovide_text_gamma = 0.1
    vim.g.neovide_text_contrast = 0.8
    vim.g.neovide_window_blurred = true
    vim.g.neovide_transparency = 0.92
    vim.g.neovide_no_idle = false
    vim.g.neovide_scroll_animation_length = 0.1
    vim.g.neovide_fullscreen = true
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animate_command_line = true
end

 vim.cmd([[
    let g:user_emmet_leader_key='<Tab>'
    let g:neovide_underline_automatic_scaling = v:true
    let g:prettier#autoformat_config_present = 1
    let g:prettier#autoformat_require_pragma = 0
    let g:neovide_cursor_trail_size = 0.1
    let g:neovide_input_use_logo = 1
    let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'
    map <D-v> "+p<CR>
    map! <D-v> <C-R>+
    tmap <D-v> <C-R>+
    vmap <D-c> "+y<CR> 
    let g:searchindex_line_limit=10000
]])
