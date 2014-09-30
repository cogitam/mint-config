if !empty(system("setxkbmap -print|grep bepo"))
    source ~/.vimrc.bepo

endif

"utilise backspace et espace pour pageup et pagedown en mode normal (wiki bépo)
noremap <BS> <PageUp>
noremap <Space> <PageDown>

" Tab fait un Ctr-] (pour abbrev), Maj+Tab fait un Tab en mode insertion
inoremap <Tab> <C-]>
inoremap <A-Tab> <C-]>
"inoremap <S-Tab> <Tab>

" En mode insertion, visuel et normal, Tab fait escape et Maj+Tab un Tab (i.e. jump list)
inoremap <Tab> <Esc>
inoremap <S-Tab> <Tab>
vnoremap <Tab> <Esc>
vnoremap <S-Tab> <Tab>
nnoremap <Tab> <Esc>
nnoremap <S-Tab> <Tab>
 
" f3 et f8 pour la complétion des mots (plus rapide que C-p et C-n)
inoremap <F3> <C-p>
inoremap <F8> <C-n>
 
" en mode insert et visuel, f7 donne escape
vnoremap <F7> <Esc>
inoremap <F7> <Esc>
 
" permet de coller proprement depuis le presse-papier de X
noremap ê :r !xsel -o

