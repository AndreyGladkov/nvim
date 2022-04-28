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

 vim.cmd([[
    let g:user_emmet_leader_key='<Tab>'
    let g:prettier#autoformat_config_present = 1
    let g:prettier#autoformat_require_pragma = 0
    let g:neovide_no_idle=v:true
    let g:neovide_cursor_vfx_mode = "railgun"
    let g:neovide_input_use_logo = 1
    map <D-v> "+p<CR>
    map! <D-v> <C-R>+
    tmap <D-v> <C-R>+
    vmap <D-c> "+y<CR> 
    let g:searchindex_line_limit=10000
]])
