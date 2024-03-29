" Vundle setup
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'preservim/nerdtree'
Plugin 'vim-airline/vim-airline' " status line
Plugin 'ctrlp.vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'rust-lang/rust.vim'
Plugin 'vim-syntastic/syntastic'
" Plugin 'zxqfl/tabnine-vim'
" Plugin 'racer-rust/vim-racer'
" Plugin 'Valloric/YouCompleteMe'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
" Put your non-Plugin stuff after this line




" Allow vim-terraform to override your .vimrc indentation syntax for matching files. Defaults to 0 which is off.
let g:terraform_align=1

" Allow vim-terraform to automatically format *.tf and *.tfvars files with terraform fmt. You can also do this manually with the :TerraformFmt command.
let g:terraform_fmt_on_save=1


" https://github.com/stevenocchipinti/dotvim/blob/master/vimrc
" CTRL-P PLUGIN
let g:ctrlp_user_command = {
\   'types': {
\     1: ['.git/', 'cd %s && git ls-files -co --exclude-standard'],
\     2: ['.hg/', 'hg --cwd %s locate -I .'],
\   },
\   'fallback': 'find %s -type f'
\ }
map <leader><C-P> <C-P><C-\>w




syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=/tmp                " Keep swap files in one location

" UNCOMMENT TO USE
set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set expandtab                    " Use spaces instead of tabs
set softtabstop=2


set mouse=a                      " Allows to use mouse scrolling

" GRB: clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" Has to be after colorscheme as it may override it
" Highlight trailing whitespace, but not during insertion
highlight TrailingWhitespace ctermbg=red guibg=red
au BufEnter    * match TrailingWhitespace /\s\+$/
au InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
au InsertLeave * match TrailingWhitespace /\s\+$/
au BufWinLeave * call clearmatches()


:let mapleader = ","

" Tab mappings.
" map <leader>tt :tabnew<cr>
" map <leader>te :tabedit
" map <leader>tc :tabclose<cr>
" map <leader>to :tabonly<cr>
" map <leader>tn :tabnext<cr>
" map <leader>tp :tabprevious<cr>
" map <leader>tf :tabfirst<cr>
" map <leader>tl :tablast<cr>
" map <leader>tm :tabmove

let NERDTreeShowHidden=1
nmap <leader>qq :NERDTree<cr>
nmap <leader>qf :NERDTreeFind<cr>

" CtrlP shortcuts
nmap <leader>t :CtrlP<cr>
nmap <leader>, :CtrlPBuffer<cr>
nmap <leader>m :CtrlPMRU<cr>
" nmap <leader>m :MRU<cr>

set wildignore+=.git,.svn,*.o,*.obj,tmp,*swp,*.log,public/system/dragonfly,coverage/


map <D-[> :bp<cr>
map <D-]> :bn<cr>
" :bd will close buffer + window
" Using this mapping to keep the window open
" http://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window#answer-5179609
nmap <leader>d :bprevious<CR>:bdelete #<CR>
nmap <leader>w :w<cr>

" Easier copy-paste to system clipboard:
vmap <leader>y "+y
map <leader>p "+gp

" INSERT mode mappings.
:imap jj <Esc>



" From https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>l :PromoteToLet<cr>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1 || match(current_file, '\<decorators\>') != -1 

  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>A :call OpenTestAlternate()<cr>



function! AlternateForPlainRubyCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec

  if going_to_spec
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
  endif
  return new_file
endfunction
function! OpenPlainRubyAlternative()
  let new_file = AlternateForPlainRubyCurrentFile()
  exec ':e ' . new_file
endfunction
nnoremap <leader>a :call OpenPlainRubyAlternative()<cr>




" Shortcuts for
" https://github.com/thoughtbot/vim-rspec
function! RunRspecViaZeus()
  let g:rspec_command = "!time zeus rspec --order defined {spec}"
endfunction

function! RunRspecViaBundle()
  let g:rspec_command = "!bundle exec rspec --order defined {spec}"
endfunction

function! RunRspecViaBin()
  let g:rspec_command = "!bin/rspec --order defined {spec}"
endfunction

function! RunRspecViaScriptTest()
  let g:rspec_command = "!script/test {spec}"
endfunction

function! RubyMode()
  map <Leader>s :call RunCurrentSpecFile()<CR>
  map <Leader>S :call RunNearestSpec()<CR>

  call RunRspecViaBundle()
endfunction

function! RustMode()
  map <Leader>s :! clear && cargo test focus --color=always -- --color=always 2>&1 \| head -n 20<CR>
  map <Leader>S :! clear && cargo test --color=always -- --color=always 2>&1 \| head -n 20<CR>
  nmap <Leader>r :! clear && cargo run<CR>
endfunction

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

let g:rustfmt_autosave = 1


call RubyMode() " Ruby mode by default



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END


" Always enable spellchecking
" disable with `:set nospell` if it gets in your way
:setlocal spell spelllang=en_au
:set nospell

" Controversial...swap colon and semicolon for easier commands
"nnoremap ; :
"nnoremap : ;

"vnoremap ; :
"vnoremap : ;

" Automatic fold settings for specific files. Uncomment to use.
" autocmd FileType ruby setlocal foldmethod=syntax
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" For the MakeGreen plugin and Ruby RSpec. Uncomment to use.
autocmd BufNewFile,BufRead *_spec.rb compiler rspec


