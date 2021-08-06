" vim: set foldmethod=marker :

""Plugins:
"call plug#begin('~/.vim/plugged')
"Plug 'lervag/vimtex'
"Plug 'tpope/vim-fugitive'
"call plug#end()
"http://vimcasts.org/episodes/minpac/
"git clone https://github.com/k-takata/minpac.git \
"    ~/.vim/pack/minpac/opt/minpac
"    ~/.config/nvim/pack/minpac/opt/minpac
""**************************** status bar shows buffer number and character value {{{
"taken from: <http://stackoverflow.com/questions/5547943/display-number-of-current-buffer>


try
  packadd minpac
"  if exists('*minpac#init')
    call minpac#init()

	call minpac#add('romainl/Apprentice')
"	call minpac#add('dracula/vim')
"	call minpac#add('morhetz/gruvbox')
	call minpac#add('michaeljsmith/vim-indent-object')

    call minpac#add('pevhall/simple_highlighting')
	set termguicolors

	if 1
		call minpac#add('tpope/vim-fugitive')
		autocmd BufReadPost fugitive://* set bufhidden=delete "https://github.com/tpope/vim-fugitive/issues/81#issuecomment-1245830
"		call minpac#add('shumphrey/fugitive-gitlab.vim')
""		let g:fugitive_gitlab_domains = ['http://gitlab.solinnov.com.au:9999']
"		let g:fugitive_gitlab_domains = ['git@192.168.2.1:9999']
		
	endif

	call minpac#add('vim-airline/vim-airline')
	if 1
		call minpac#add('airblade/vim-gitgutter')
		nmap ]h <Plug>(GitGutterNextHunk)
		nmap [h <Plug>(GitGutterPrevHunk)
	endif

	if 1
		call minpac#add('junegunn/fzf', { 'do': { -> fzf#install() } } )
		call minpac#add('junegunn/fzf.vim')
	endif

"	command FzfFileTxtList call fzf#run(fzf#wrap({'source':'cat '.<f-args>}))
	command FzfFileTxtList call fzf#run(fzf#wrap({'source':'cat files*.txt'}))

	if 0
	"	ripgrep seraching
		call minpac#add('dyng/ctrlsf.vim')
"		nmap     <C-A-F>f <Plug>CtrlSFPrompt
"		vmap     <C-A-F>f <Plug>CtrlSFVwordPath
"		vmap     <C-A-F>F <Plug>CtrlSFVwordExec
"		nmap     <C-A-F>n <Plug>CtrlSFCwordPath
"		nmap     <C-A-F>N <Plug>CtrlSFCCwordPath
"		nmap     <C-A-F>p <Plug>CtrlSFPwordPath
"		nnoremap <C-A-F>t :CtrlSFToggle<CR>
	endif
	

    "https://github.com/junegunn/fzf/wiki/Examples-(vim)#jump-to-tags
    command! -bar Tags if !empty(tagfiles()) | call fzf#run({
\   'source': "sed '/^\\!/d;s/\t.*//' " . join(tagfiles()) . ' | uniq',
\   'sink':   'tag',
\ }) | else | echo 'Preparing tags' | call system('ctags -R') | FZFTag | endif

    call minpac#add('godlygeek/tabular')

    if 0 
      call minpac#add('lervag/vimtex')
      let g:vimtex_latexmk_options = '-pdf -verbose -file-line-error -synctex=1'
      let g:vimtex_compiler_progname = 'nvr'
    endif

    if 1
            " Track the engine.
      call minpac#add('SirVer/ultisnips')

      " Snippets are separated from the engine. Add this if you want them:
"      call minpac#add('honza/vim-snippets')

      " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
	  let g:UltiSnipsListSnippets = "<leader><c-m>"
      let g:UltiSnipsExpandTrigger="<tab>"
      let g:UltiSnipsJumpForwardTrigger="<tab>"
      let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

"	  let g:UltiSnipsListSnippets = "<leader><c-m>"
"      let g:UltiSnipsExpandTrigger="<tab>"
"      let g:UltiSnipsJumpForwardTrigger="<c-m>"
"      let g:UltiSnipsJumpBackwardTrigger="<C-A-m>"

      " If you want :UltiSnipsEdit to split your window.
"      let g:UltiSnipsEditSplit="vertical"
    endif

    if 1 && has('nvim') " Add COC {{{
      call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
      " See https://github.com/neoclide/coc.nvim (for info about all these
      " settings)

      " TextEdit might fail if hidden is not set.
      set hidden

      " Don't pass messages to |ins-completion-menu|.
      set shortmess+=c
      

      " Use tab for trigger completion with characters ahead and navigate.
      " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
      " other plugin before putting this into your config.
"      inoremap <silent><expr> <TAB>
"            \ pumvisible() ? "\<C-n>" :
"            \ <SID>check_back_space() ? "\<TAB>" :
"            \ coc#refresh()
"      inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

      function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
      endfunction

      " Use <c-space> to trigger completion.
      inoremap <silent><expr> <c-space> coc#refresh()

  "    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  "    " position. Coc only does snippet and additional edit on confirm.
  "    if has('patch8.1.1068')
  "      " Use `complete_info` if your (Neo)Vim version supports it.
  "      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  "    else
  "      imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  "    endif
          
      
      " Use `[g` and `]g` to navigate diagnostics
      nmap <silent> [g <Plug>(coc-diagnostic-prev)
      nmap <silent> ]g <Plug>(coc-diagnostic-next)
      nmap <silent> [G <Plug>(coc-diagnostic-prev-error)
      nmap <silent> ]G <Plug>(coc-diagnostic-next-error)

      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)

      " Use K to show documentation in preview window.
      nnoremap <silent> K :call <SID>show_documentation()<CR>

      function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
          execute 'h '.expand('<cword>')
        else
          call CocAction('doHover')
        endif
      endfunction

      " Highlight the symbol and its references when holding the cursor.
      autocmd CursorHold * silent call CocActionAsync('highlight')

      " Symbol renaming.
      nmap <leader>rn <Plug>(coc-rename)
          

  "    " Use <TAB> for selections ranges.
  "    " NOTE: Requires 'textDocument/selectionRange' support from the language server.
  "    " coc-tsserver, coc-python are the examples of servers that support it.
  "    nmap <silent> <TAB> <Plug>(coc-range-select)
  "    xmap <silent> <TAB> <Plug>(coc-range-select)

      " Add `:Format` command to format current buffer.
      command! -nargs=0 Format :call CocAction('format')

      " Add `:Fold` command to fold current buffer.
      command! -nargs=? Fold :call     CocAction('fold', <f-args>)

      " Add `:OR` command for organize imports of the current buffer.
      command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
      
  "    " Add (Neo)Vim's native statusline support.
  "    " NOTE: Please see `:h coc-status` for integrations with external plugins that
  "    " provide custom statusline: lightline.vim, vim-airline.
  "    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

      " Mappings using CoCList:
      " Show all diagnostics.
      nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
      " Manage extensions.
      nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
      " Show commands.
      nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
      " Find symbol of current document.
      nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
      " Search workspace symbols.
      nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
      " Do default action for next item.
      nnoremap <silent> <space>j  :<C-u>CocNext<CR>
      " Do default action for previous item.
      nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
      " Resume latest coc list.
      nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
    endif "}}}
"    call minpac#add('iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'})
"    let g:mkdp_auto_start = 1

    call minpac#add('JamshedVesuna/vim-markdown-preview')
    " I also installed: markdown and xdotool with sudo apt
    

"   call minpac#add('suoto/vim-hdl')

"    call minpac#add('scrooloose/syntastic')
"    call minpac#add('http://git.vhdltool.com/vhdl-tool/syntastic-vhdl-tool')
"    let g:syntastic_always_populate_loc_list = 1
"    let g:syntastic_auto_loc_list = 1
"    let g:syntastic_check_on_open = 1
"    let g:syntastic_check_on_wq = 0
"    "VHDL
"    let g:syntastic_vhdl_checkers = ['vhdltool']
"    "PYTHON
"    let g:syntastic_python_checkers=['flake8']
"    let g:syntastic_python_flake8_args='--ignore=F401,E111,E301,E262,E226,E265,E501,E221,W291,E231,E261,W293,E203,E227,E114,E271,E222,E303,E266,E116,E305,E115,E302,E225,E272,E228,E201,E402'   "E111 is indentation mult=4
"    "CPP
"    let g:syntastic_cpp_compiler_options = '-std=c++14'
"    let g:syntastic_cpp_config_file = './.syntastic_cpp_config'
"    let g_syntastic_deubg = 1

    call minpac#add('luochen1990/rainbow')
    let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
        let g:rainbow_conf = {
      \    'guifgs'  : ['RoyalBlue1', 'SeaGreen3', 'Orange', 'IndianRed', 'Magenta'],
      \    'ctermfgs': ['Blue', 'Cyan', 'Green', 'Red', 'Magenta'] ,
      \    'operators': '_,_',
      \    'separately': {
      \       '*': {},
      \       'vhdl' : {'parentheses': ['start=/(/ end=/)/ fold',  
      \                                 'start=/^\s*for\>/ end=/\<end loop\>/ fold', 
      \                                 'start=/^\s*if\>/ step=/\<\(elsif\|else\)\>/ end=/\<end if\>/ fold', 
      \                                 'start=/\<generate$/ step=/\<begin\>/ end=/\<end generate\>/ fold',  
      \                                 'start=/^\s*process\>/ step=/\<begin\>/ end=/\<end process\>/ fold']}
      \   }
      \ }  
 " generate line above doesn't work 
"      \                                 'start=/^\s*function\>/ step=/\<begin\>/ end=/\<end function\>/ fold',
"      \                                 'start=/^\s*procedure\>/ step=/\<begin\>/ end=/\<end procedure\>/ fold',
"  endif
"      \       'vhdl' : {'parentheses': ['start=/(/ end=/)/ fold',  'start=/^\s*if\>/ step=/\<else\>/ end=/\<end if\>/ fold',  'start=/^\s*process\>/ step=/\<begin\>/ end=/\<end process\>/ fold', 'start=/\<for\>/ end=/\<end loop\>/ fold']},
	let g:has_minpac = 1
catch
	let g:has_minpac = 0
endtry

if filereadable('/usr/bin/fish')
  set shell=/usr/bin/fish
endif
"
" Status Line {  
if g:has_minpac == 0
        set laststatus=2                             " always show statusbar  
        set statusline=  
        set statusline+=%-10.3n\                     " buffer number  
        set statusline+=%t\                          "tail of file name ( f -> full lenght filename   )
        set statusline+=%h%m%r%w                     " status flags  
        set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type  
if g:has_minpac		
       set statusline+=\ %{FugitiveStatusline()}        " add Git repo/ status
endif
        set statusline+=%=                           " right align remainder  
        set statusline+=0x%-8B                       " character value  
        set statusline+=%-14(%l,%c%V%)               " line, character  
        set statusline+=%<%P                         " file position  
endif
"}  
""}}}

"set grepprg="cat files*.txt \| xargs rg --vimgrep"
"set grepformat^=%f:%l:%c:%m

" load script that insters a VHDL component from an file
let s:srcFilePath = expand('<sfile>:p:h')
let initVhdlPath = s:srcFilePath . '/instVhdl/instVHDL.vim'
if filereadable(initVhdlPath)
  exec 'source'initVhdlPath
endif
"copy abs file path
nnoremap <leader>c%  :let @*=expand("%:p")<CR> 
"copy file name
nnoremap <leader>c%t :let @*=expand("%:t")<CR>
"copy directory
nnoremap <leader>c%h :let @*=expand("%:p:h")<CR>

"<https://stackoverflow.com/questions/4256697/vim-search-and-highlight-but-do-not-jump>
nnoremap # m`:keepjumps normal! *``<cr>
nnoremap <Leader>s m`:%s/<C-r>//<C-r><C-w>/g<cr>``
nnoremap <Leader><a-s> :%s/<C-r>//<C-r><C-w>/g

"if has('nvim')
"  if has("gui_running")
  "fix up middle mouse selection issue on neovim-qt
"    set mouse=a
"    vmap <LeftRelease> "*ygv
"  endif
"endif

"Uncrustify function {{{
let g:uncrustifyCfgFile = '~/.uncrustify.cfg'
function! UncrustifyFunc(options) range
	exec a:firstline.','.a:lastline.'!uncrustify '.a:options
				\.' -c '.g:uncrustifyCfgFile.' -q -l '.&filetype
endfunction

command! -range=% UncrustifyRange <line1>,<line2>call UncrustifyFunc('--frag')
command! Uncrustify  let s:save_cursor = getcurpos() 
                  \| %call UncrustifyFunc('') 
                  \| call setpos('.', s:save_cursor)
"}}}

"helpful :terminal mappings {{{
"To map <Esc> to exit terminal-mode:
"    :tnoremap <Esc> <C-\><C-n>

"To simulate |i_CTRL-R| in terminal-mode:
    :tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
"}}}

"To use `ALT+{h,j,k,l}` to navigate windows and tabs from any mode: {{{
    :tnoremap <A-p> <C-\><C-N>gT
    :tnoremap <A-n> <C-\><C-N>gt
    :inoremap <A-p> <C-\><C-N>gT
    :inoremap <A-n> <C-\><C-N>gt
    :nnoremap <A-p> gT
    :nnoremap <A-n> gt

    :tnoremap <A-h> <C-\><C-N><C-w>h
    :tnoremap <A-j> <C-\><C-N><C-w>j
    :tnoremap <A-k> <C-\><C-N><C-w>k
    :tnoremap <A-l> <C-\><C-N><C-w>l
    :inoremap <A-h> <C-\><C-N><C-w>h
    :inoremap <A-j> <C-\><C-N><C-w>j
    :inoremap <A-k> <C-\><C-N><C-w>k
    :inoremap <A-l> <C-\><C-N><C-w>l
    :nnoremap <A-h> <C-w>h
    :nnoremap <A-j> <C-w>j
    :nnoremap <A-k> <C-w>k
    :nnoremap <A-l> <C-w>l
"}}}

" termical colours '[ark pastels] {{{
let g:terminal_color_0  = "#3f3f3f"
let g:terminal_color_1  = "#705050"
let g:terminal_color_2  = "#60b48a"
let g:terminal_color_3  = "#dfaf8f"
let g:terminal_color_4  = "#9ab8d7"
let g:terminal_color_5  = "#ec93d3"
let g:terminal_color_6  = "#8cd0d3"
let g:terminal_color_7  = "#dcdccc"
let g:terminal_color_8  = "#709080"
let g:terminal_color_9  = "#dca3a3"
let g:terminal_color_10 = "#72d5a3"
let g:terminal_color_11 = "#f0dfaf"
let g:terminal_color_12 = "#9ab8d7"
let g:terminal_color_13 = "#dc8cc3"
let g:terminal_color_14 = "#93e0e3"
let g:terminal_color_15 = "#ffffff"
" }}}

if has("win32") "{{{
  "Windows options here

  " Makes bash open in the working directory
  let $CHERE_INVOKING=1

  " Default path for Cygwin 64-bit, change accordingly
  set shell=C:\cygwin64\bin\bash.exe

  " Without --login, Cygwin won't mount some directories such as /usr/bin/
  set shellcmdflag=--login\ -c

  " Default value is (, but bash needs "
  set shellxquote=\"

  " Paths will use / instead of \
  set shellslash
  " Makes bash open in the working directory
  let $CHERE_INVOKING=1

  " Default path for Cygwin 64-bit, change accordingly
  set shell=C:\cygwin64\bin\bash.exe

  " Without --login, Cygwin won't mount some directories such as /usr/bin/
  set shellcmdflag=--login\ -c

  " Default value is (, but bash needs "
  set shellxquote=\"

  " Paths will use / instead of \
  set shellslash
endif
"}}}

"{{{ " source $VIMRUNTIME/mswin.vim
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"}}} 


""" diffexpr {{{
 function MyDiff()
   let opt = '-a --binary '
   if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
   if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
   let arg1 = v:fname_in
   if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
   let arg2 = v:fname_new
   if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
   let arg3 = v:fname_out
   if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
   if $VIMRUNTIME =~ ' '
     if &sh =~ '\<cmd'
       if empty(&shellxquote)
         let l:shxq_sav = ''
         set shellxquote&
       endif
       let cmd = '"' . $VIMRUNTIME . '\diff"'
     else
       let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
     endif
   else
     let cmd = $VIMRUNTIME . '\diff'
   endif
   silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
   if exists('l:shxq_sav')
     let &shellxquote=l:shxq_sav
   endif
 endfunction
" }}}

" TABS and spascing: {{{
set tabstop=4     " width of a tab character

set shiftwidth=4  " amount of white space from '>' and '<' keys
set softtabstop=4 " number of spaces to insert when tab is pressed
set noexpandtab
set smarttab

function SetLocalTabSpace(numSpaces)
    exe 'setlocal shiftwidth=' .a:numSpaces  | " amount of white space from '>' and '<' keys
"    exe 'setlocal tabstop='    .a:numSpaces  | " width of a tab character
    exe 'setlocal softtabstop='.a:numSpaces  | " number of spaces to insert when tab is pressed
endfunction

command -nargs=1 RSetLocalTabSpace call SetLocalTabSpace(<args>) | normal i VIM settings: ex: set shiftwidth=2 softtabstop=2 expandtab:<ESC>

command -nargs=1 SetLocalTabSpace call SetLocalTabSpace(<args>)

let g:python_recommended_style=0 "do not use python recormeneded tab defined in python.vim
"}}}

set ff=unix "fileformat=unix always use unix line endings

" use hybride/relative line numbers {{{ <https://jeffkreeftmeijer.com/vim-number/>
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd WinEnter,FocusGained,InsertLeave * set relativenumber
  autocmd WinLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
"}}}

" used to quickly instert headders
command -nargs=0 InsertDate put! = strftime('%d/%m/%y')
command -nargs=0 InsertHead put! = 'Pev Hall @ Solinnov '.strftime('%d/%m/%y')

" vim GUI options {{{
if has('gui_running')
"  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
endif
" }}}

"if has("gui_running")
try "apply apprentice colorscheme if we have it
  colorscheme apprentice
catch
  colorscheme torte "default inbuilt one
endtry
"else
"    set background=light "centos vim7.4 needed to set light before dark
"    set background=dark
"    colorscheme torte "default inbuilt one
"endif

"let &colorcolumn="40,80,120"
"highlight ColorColumn ctermbg=235 guibg=#2c2d27


set wildmode=longest:full
set wildmenu
"set wildoptions+=pum        set wildmode=list:lastused        requires nvim 0.4+ 

set selectmode=key " mouse selection dose visual mode key does select mode
set keymodel="" " force default keymodel (arrow keys behave as expected)

" ************************ normal program CUT COPY PAST: taken from mswin.vim {{{
" CTRL-X  Cut
vnoremap <C-X> "+x

" CTRL-C Copy
vnoremap <C-C> "+y

" CTRL-V Paste
map <C-V>		"+gP
cmap <C-V>		<C-R>+

" Use CTRL-Q (and CTRL-E as CTRL-Q does not work though ssh terminal) to do what CTRL-V used to do
noremap <C-E>		<C-V>
noremap <C-Q>		<C-V>

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

" ******************** END }}}

set incsearch " incremental search
set hlsearch  " highlight seaech

" function to perform gerp on all files within a file containing a list of files {{{
function! Grep(what, where)
    exec join(extend(['vimgrep', a:what],
        \ map(filter(readfile(a:where), 'v:val !=# "" && filereadable(v:val)'),
        \ 'fnameescape(v:val)')))
    copen
endfunction
command! -nargs=+ Grep call Grep(<f-args>)
" }}}


"new splits below or right
set splitbelow
set splitright


" first, delete some text (using a command such as daw or dt in normal mode, or x in visual mode). Then, use visual mode to select some other text, and press Ctrl-S. The two pieces of text should then be swapped.
:vnoremap <C-S> <Esc>`.``gvP``P

if has('unix')
	"https://unix.stackexchange.com/questions/43119/preserve-modified-time-stamp-after-edit
	function! WritePreserveDate()
		let mtime = system("stat -c %.Y ".shellescape(expand('%:p')))
		write
		call system("touch --date='@".mtime."' ".shellescape(expand('%:p')))
		edit
	endfunction
endif

"""maps \s to swapping regesters unnamed, and a via x
":nnoremap <Leader>x :let @x=@" \| let @"=@a \| let @a=@x<CR>

"modified buffer delete -- closes buffer but keeps splits unchaged
command Bd bp | bd #

"https://stackoverflow.com/questions/8450919/how-can-i-delete-all-hidden-buffers
function! BuffersDeleteHidden()
    redir => buffersoutput
    buffers
    redir END
    let buflist = split(buffersoutput,"\n")
    for item in filter(buflist,"v:val[5] == 'h'")
            exec 'bdelete ' . item[:2]
    endfor
endfunction

"To search for visually selected text <https://vim.fandom.com/wiki/Search_for_visually_selected_text>
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

"if !exists("s:autocommands_loaded") "guard
augroup FILE_TYPES
"    let s:autocommands_loaded = 1 "only run commands below once
    autocmd Filetype vhdl    call FT_vhdl()
"    autocmd Filetype verilog call FT_verilog()
augroup END
"endif

autocmd BufRead,BufNewFile SConstruct set filetype=python "use python syntax for scons
"filetype on
"augroup FILE_TYPES
" Files with extension .rb are processed as VHDL code
"    autocmd BufRead,BufNewFile *.vhd  set ft=vhdl
"    autocmd BufRead,BufNewFile *.vhdl set ft=vhdl
"    autocmd BufRead,BufNewFile *.v    set ft=verilog
"augroup END


""*******************************o**** VHDL: specific funciton {{{
"" <http://0x7.ch/vim/vhdl/>    <http://0x7.ch/vim/vhdl/vimrc>
"
let g:hdlUpdate = "hdl_checker_update"
filetype plugin on
runtime macros/matchit.vim

function FT_vhdl()
"    if !exists("g:one_off_vhdl_loaded")
"        let g:one_off_vhdl_loaded = 1
"    endif

	setlocal tabstop=8 shiftwidth=2 softtabstop=2 expandtab

	let g:tlist_vhdl_settings   = 'vhdl;e:entities;P:packages;t:types;T:subtypes;f:functions;p:procedures'

	iabbr <buffer> dt downto
	iabbr <buffer> sig signal
	iabbr <buffer> var variable
	iabbr <buffer> sl std_logic
	iabbr <buffer> slv std_logic_vector
	iabbr <buffer> re rising_edge
	iabbr <buffer> pro process
	iabbr <buffer> gen generate
	iabbr <buffer> const constant

	let g:vhdl_indent_genportmap = 0
	exe "command! Tg !".g:hdlUpdate."   .   "
	"let g:xiseProPath = glob("*xise")
	"call SetTg("a")
	runtime macros/matchit.vim
	if ! exists("b:match_words")  &&  exists("loaded_matchit")
	  let b:match_ignorecase=1
	  let s:notend = '\%(\<end\s\+\)\@<!'
	  let b:match_words =
		\ s:notend.'\<if\>:\<elsif\>:\<else\>:\<end\s\+if\>,'.
		\ s:notend.'\<case\>:\<when\>:\<end\s\+case\>,'.
		\ s:notend.'\<loop\>:\<end\s\+loop\>,'.
		\ s:notend.'\<for\>:\<end\s\+for\>,'.
		\ s:notend.'\<generate\>:\<begin\>:\<end\s\+generate\>,'.
		\ s:notend.'\<record\>:\<end\s\+record\>,'.
		\ s:notend.'\<units\>:\<end\s\+units\>,'.
		\ s:notend.'\<process\>:\<begin\>:\<end\s\+process\>,'.
		\ s:notend.'\<block\>:\<end\s\+block\>,'.
		\ s:notend.'\<function\>:\<begin\>:\<end\s\+function\>,'.
		\ s:notend.'\<entity\>:\<end\s\+entity\>,'.
		\ s:notend.'\<component\>:\<end\s\+component\>,'.
		\ s:notend.'\<architecture\>:\<begin\>:\<end\s\+architecture\>,'.
		\ s:notend.'\<package\>:\<begin\>:\<end\s\+package\>,'.
		\ s:notend.'\<procedure\>:\<begin\>:\<end\s\+procedure\>,'.
		\ s:notend.'\<configuration\>:\<end\s\+configuration\>'
	endif
endfunction

"function FT_verilog()
"  if !exists("g:one_off_verilog_loaded")
"    let g:one_off_verilog_loaded = 1
"    exe "command! Tg !".s:hdlUpdate."   .   "
"  endif
"endfunction
"}}}

"" Basic Functions {{{
"function NewArray(length, elemVal)
"    let retVal = []
"    for idx in range(a:length)
"        let retVal += [deepcopy(a:elemVal)]
"    endfor
"    return retVal
"endfunction
"
"function Zeros(length)
"    return NewArray(a:length, 0)
"endfunction
"
"function FlatternStrArr(strArr, seperator) "Flattern String Array into signal string
"    if len(a:strArr) == 0
"        return ''
"    endif
"    let ret = a:strArr[0]
"    for str in a:strArr[1:]
"        let ret .= a:seperator.str
"    endfor
"    return ret
"endfunction
"
""function below taken form <http://vim.wikia.com/wiki/Windo_and_restore_current_window>
"" Just like windo, but restore the current window when done.
"function! WinDo(command)
"  let currwin=winnr()
"  execute 'windo ' . a:command
"  execute currwin . 'wincmd w'
"endfunction
"com! -nargs=+ -complete=command Windo call WinDo(<q-args>)
"
"" }}}
"
""Highlight words extension {{{
""
"" useful web link: http://www.ibm.com/developerworks/linux/library/l-vim-script-1/index.html
"" http://vim.wikia.com/wiki/Highlight_multiple_words
"
"highlight hlg1 ctermbg=DarkGreen   guibg=DarkGreen      ctermfg=white guifg=white
"highlight hlg2 ctermbg=DarkCyan    guibg=DarkCyan       ctermfg=white guifg=white
"highlight hlg3 ctermbg=Blue        guibg=Blue           ctermfg=white guifg=white
"highlight hlg4 ctermbg=DarkMagenta guibg=DarkMagenta    ctermfg=white guifg=white
"highlight hlg5 ctermbg=DarkRed     guibg=DarkRed        ctermfg=white guifg=white
"highlight hlg6 ctermbg=DarkYellow  guibg=DarkYellow     ctermfg=white guifg=white
"highlight hlg7 ctermbg=Brown       guibg=Brown          ctermfg=white guifg=white
"highlight hlg8 ctermbg=DarkGrey    guibg=DarkGrey       ctermfg=white guifg=white
"highlight hlg9 ctermbg=Black       guibg=Black          ctermfg=white guifg=white
"let s:TOTAL_HL_NUMBERS = 10
"
"let g:hlPat   = NewArray(s:TOTAL_HL_NUMBERS,[])  "stores the patters
"let s:REGEX_OR = '\|'
"
""press [<number>] <Leader> h -> to highligt the whole word under the cursor
""   highligted colour is determed by the number the number defined above
"nmap <Leader>h :<C-U> exe "call HighlightAdd(".v:count.",'\\<".expand('<cword>')."\\>')"<CR>
""NOTE: above funtion can match on an empty pattern '\<\>' however this doesn't
""   seem to have any magor negetive effects so is not fixed
"
""Hc [0,2...] -> clears the highlighted patters listed or all if no arguments
""   are passed
"command -nargs=* Hc call HighlightClear(<f-args>)
"
"command -nargs=* Hs call HighlightSearch(<f-args>) | set hlsearch
"
"command -nargs=+ Ha call HighlightAddMultiple(<f-args>)
"
"command -nargs=+ Hw call HighlightWriteCommands(<f-args>)
"
"command -nargs=1 Hd call HighlightSetDefaultSlot(<f-args>)
"
"let g:hlDefaultNum = 1
"
"function HighlightSetDefaultSlot(hlNum)
"  let g:hlDefaultNum = a:hlNum
"endfunction
"
"function HighlightWriteCommands(...)
"    let cmds = []
"    if a:0 == 1
"        for idx in range(s:TOTAL_HL_NUMBERS)
"            let cmds+=HighlightPatternCommands(eval(idx))
"        endfor
"    else
"        for idx in range(3, a:0)
"            let cmds+=HighlightPatternCommands(eval('a:'.idx))
"        endfor
"    endif
"    call writefile(cmds, a:1)
"endfunction
"
"function HighlightPatternCommands(hlNum)
"	let cmds = []
"    if s:HighlightCheckNum(a:hlNum) && w:hlIdArr[a:hlNum] > 0
"		let str = 'Ha '.a:hlNum
"		let idx = 0
"        for pat in g:hlPat[a:hlNum]
"			if idx == 10
"				let cmds += [str]
"				let str = 'Ha '.a:hlNum
"				let idx = 0
"			endif
"			let idx = idx+1
"            let str = str.' '.substitute(pat, ' ', "\\\\ ", 'g')
"        endfor
"		let cmds += [str]
"    endif
"    return cmds
"endfunction
"
"function HighlightAdd(hlNum, pattern)
"    if a:hlNum == 0
"      let hlNum = g:hlDefaultNum
"    else
"      let hlNum = a:hlNum
"    endif
"    if (s:HighlightCheckNum(hlNum) != 0) &&( a:pattern != '') && (a:pattern != '\<\>')
"        let prevSlotAndIdx = HighlightPatternInSlot(a:pattern)
"        let prevHlNum = prevSlotAndIdx[0]
"        let prevIdx   = prevSlotAndIdx[1]
"        if prevHlNum != -1
"            call HighlightRemovePatternAt(prevHlNum,prevIdx)
"            if prevHlNum == hlNum " was already at slot so do not add it back in
"                return 
"            endif
"        endif
"        let g:hlPat[hlNum] += [a:pattern]
"        call WinDo('call s:HighlightUpdatePriv('.hlNum.')')
"    endif
"endfunction
"
"let s:HIGHLIGHT_PRIORITY = -1  " -1 => do not overide default serach highlighting
"function s:HighlightUpdatePriv(hlNum) "if patern is black will set w:hlIdArr[a:hlNum] to  -1
"    if w:hlIdArr[a:hlNum] > 0
"        call matchdelete(w:hlIdArr[a:hlNum])
"    end
"    let w:hlIdArr[a:hlNum] = matchadd('hlg'.a:hlNum, HighlightPattern(a:hlNum), s:HIGHLIGHT_PRIORITY)
"endfunction
"
"function HighlightWinEnter()
"    if !exists("w:displayed")
"        let w:displayed  = 1
"        let w:hlIdArr = Zeros(s:TOTAL_HL_NUMBERS)
"        for idx in range(s:TOTAL_HL_NUMBERS)
"            if len(g:hlPat[idx]) > 0
"                call s:HighlightUpdatePriv(idx)
"            endif
"        endfor
"    endif
"endfunction
"
"if !exists("s:au_highlight_loaded") "guard
"    let s:au_highlight_loaded = 1 "only run commands below once
"    autocmd WinEnter    * call HighlightWinEnter()
"    autocmd BufEnter    * call HighlightWinEnter()
"    call  HighlightWinEnter()
"endif
"
"function HighlightAddMultiple(...)
"    if a:0 < 2
"        echoerr 'HighlightAddMultiple usage <slot number> [pattern ...]'
"    else
"        for idx in range(2, a:0)
"            call HighlightAdd(a:1, eval('a:'.idx))
"        endfor
"    endif
"endfunction
"
"function HighlightClear(...)
"    if a:0 == 0
"        for idx in range(s:TOTAL_HL_NUMBERS) "range stops BEFORE
"            call s:HighlightClearPriv(eval(idx))
"        endfor
"    else
"        for idx in range(1, a:0) "range stops AFTER
"            call s:HighlightClearPriv(eval('a:'.idx))
"        endfor
"    endif
"endfunction
"
"function s:HighlightClearPriv(hlNum)
"    if s:HighlightCheckNum(a:hlNum) && w:hlIdArr[a:hlNum] > 0
"        call WinDo('call s:HighlightClearBuffPriv('.a:hlNum.')')
"        let g:hlPat[a:hlNum]   = []
"    endif
"endfunction
"
"function s:HighlightClearBuffPriv(hlNum)
"    call matchdelete(w:hlIdArr[a:hlNum])
"    let w:hlIdArr[a:hlNum] = 0
"endfunction
"
"function s:HighlightCheckNum(hlNum)
"    if a:hlNum >= s:TOTAL_HL_NUMBERS
"        echoerr 'ERROR: Highlight number must be from 0 to 's:TOTAL_HL_NUMBERS-1'inclsive. Not'a:hlNum
"        return 0
"    endif
"    return 1
"endfunction
"
"function HighlightSearch(...)
"    let searchStr = call('HighlightPattern', a:000)
"    call UserSerach(searchStr)
"endfunction
"
"function HighlightPatternInSlot(pattern)
"    for hlNum in range(s:TOTAL_HL_NUMBERS)
"        for patIdx in range(len(g:hlPat[hlNum]))
"            if a:pattern == g:hlPat[hlNum][patIdx]
"                return [hlNum, patIdx]
"            endif
"        endfor
"    endfor
"    return [-1, -1]
"endfunction
"
"function HighlightRemovePatternAt(hlNum, patIdx)
"    call remove(g:hlPat[a:hlNum], a:patIdx)
"    call WinDo('call s:HighlightUpdatePriv('.a:hlNum.')')
"endfunction
"
"function HighlightPattern(...)
"    let idxs = []
"    if a:0 == 0
"        let idxs = range(s:TOTAL_HL_NUMBERS)
"    else
"        for aIdx in range(1, a:0) "range stops AFTER
"            call add(idxs,eval('a:'.aIdx))
"        endfor
"    endif
"    let pattern = ''
"    for idx in idxs
"        if len(g:hlPat[idx]) > 0
"            let idxPattern = FlatternStrArr(g:hlPat[idx], s:REGEX_OR)
"            if len(pattern) > 0 
"                let pattern .= s:REGEX_OR
"            endif
"            let pattern .= idxPattern
"        endif
"    endfor
"    return pattern
"endfunction
"
"function UserSerach(searchStr)
"    let @/ = a:searchStr
"endfunction
"
""}}}
"
