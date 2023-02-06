" Title: Vim Igor
" Description: A simple plugin opening buffers in a different editor
"

if exists("g:loaded_vim_igor")
    finish
endif
:let g:loaded_vim_igor=1

" Check if an editor is specified, use Sublime otherwise
if !exists("g:alternative_editor")
    let g:alternative_editor='subl'
endif

" Function to get all buffers
" Taken from
" [https://vi.stackexchange.com/questions/21006/how-to-get-the-names-of-all-open-buffers]
function! GetBuffers()
    let l:blist = getbufinfo({'bufloaded': 1, 'buflisted': 1})
    let l:result = []
    for l:item in l:blist
        "skip unnamed buffers
        if empty(l:item.name)
            continue
        endif
        call add(l:result, shellescape(l:item.name))
    endfor
    return l:result
endfunction

function! AlternativeEditor()
    :exec '!' g:alternative_editor join(GetBuffers())
endfunction

command! -nargs=0 AlternativeEditor call AlternativeEditor()
