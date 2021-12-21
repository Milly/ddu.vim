"=============================================================================
" FILE: ddu.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu at gmail.com>
" License: MIT license
"=============================================================================

let s:root_dir = fnamemodify(expand('<sfile>'), ':h:h')

function! ddu#start() abort
  if exists('g:ddu#_initialized')
    return
  endif

  if !has('patch-8.2.0662') && !has('nvim-0.5')
    call ddu#util#print_error(
          \ 'ddu requires Vim 8.2.0662+ or neovim 0.5.0+.')
    return
  endif

  augroup ddu
    autocmd!
  augroup END

  " Note: ddu.vim must be registered manually.

  " Note: denops load may be started
  if exists('g:loaded_denops') && !has('vim_starting')
    silent! call ddu#_register()
  else
    autocmd ddu User DenopsReady silent! call ddu#_register()
  endif
endfunction
function! ddu#_register() abort
  call denops#plugin#register('ddu',
        \ denops#util#join_path(s:root_dir, 'denops', 'ddu', 'app.ts'),
        \ { 'mode': 'skip' })
endfunction