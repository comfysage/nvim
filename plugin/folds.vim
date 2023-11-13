function! FullFold()
  let line = getline(v:foldstart)
  let sub = substitute(line, '/\*\|\*/\|\"\s*\|{{{\d\=', '', 'g')
  return v:folddashes .. " " .. sub
endfunction

function! CenteredFold()
  let line = getline(v:foldstart)
  let sub = substitute(line, '/\*\|\*/\|\"\s*\|{{{\d\=', '', 'g')
  return repeat("-", ( &columns - len( sub ) ) / 2 ) .. " " .. sub
  return v:folddashes .. sub
endfunction

function! SimpleFold()
  let line = getline(v:foldstart)
  let sub = substitute(line, '/\*\|\*/\|\"\s*\|{{{\d\=', '', 'g')
  return sub
endfunction

set foldtext=SimpleFold()

" vim: foldmethod=syntax
