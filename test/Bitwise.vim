let s:themis_vimspec_bundles = []
let s:themis_vimspec_scopes = themis#style#vimspec#new_scope()
function! s:themis_vimspec_scope_1() abort
let s:themis_vimspec_bundles += [themis#bundle('Bitwise')]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(1)
endfunction
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.before_all() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(1)", 1)
    let B = package#import('jp#Bitwise')
    " NOTE:
    " An int literal larger than or equal to 0x8000000000000000 will be rounded
    " to 0x7FFFFFFFFFFFFFFF after Vim 8.0.0219, so create it without literal
    let x8000000000000000 = 0/0
call s:themis_vimspec_scopes.back(1, l:)
endfunction

function! s:themis_vimspec_scope_2() abort
let s:themis_vimspec_bundles += [themis#bundle#new('.lshift()', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(2)
endfunction
function! s:themis_vimspec_scope_3() abort
let s:themis_vimspec_bundles += [themis#bundle#new('with small numbers', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(3)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00001"] = 'shifts bits to left'
function! s:themis_vimspec_bundles[-1].suite.T_00001() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
        Assert Equals(B.lshift(0, 0), 0)
        Assert Equals(B.lshift(0, 1), 0)
        Assert Equals(B.lshift(0, 31), 0)
        Assert Equals(B.lshift(0, 32), 0)
        Assert Equals(B.lshift(1, 0), 0x1)
        Assert Equals(B.lshift(1, 1), 0x2)
        Assert Equals(B.lshift(1, 31), 0x80000000)
        Assert Equals(B.lshift(0x80000000, 0), 0x80000000)
endfunction
call s:themis_vimspec_scopes.push(copy(l:), 3, 2)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_3()
    if has('num64')
function! s:themis_vimspec_scope_4() abort
let s:themis_vimspec_bundles += [themis#bundle#new('with 64bit number', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(4)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00002"] = 'shifts bits to left'
function! s:themis_vimspec_bundles[-1].suite.T_00002() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
          Assert Equals(B.lshift(1, 32), 0x100000000)
          Assert Equals(B.lshift(0x80000000, 1), 0x100000000)
          Assert Equals(B.lshift(1, 63), x8000000000000000)
          Assert Equals(B.lshift(1, 64), 1)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00003"] = 'shifts bits to left (random)'
function! s:themis_vimspec_bundles[-1].suite.T_00003() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
          Assert Equals(B.lshift(-6547820378035905891, -9), 5656521131977342976)
          Assert Equals(B.lshift(-3338945565435194024, -25), -1203960834368208896)
          Assert Equals(B.lshift(5765087922765281421, 52), -8588364489395535872)
          Assert Equals(B.lshift(8920998653320978603, 11), 7928609028908079104)
          Assert Equals(B.lshift(8442026461925972002, 38), -2096979230645551104)
          Assert Equals(B.lshift(3547367712430972932, 54), 72057594037927936)
          Assert Equals(B.lshift(8382076105951341210, 4), 4986009179254598048)
          Assert Equals(B.lshift(4785275337718270894, -6), -5188146770730811392)
          Assert Equals(B.lshift(-6707534047010871283, -13), 4640959416005296128)
          Assert Equals(B.lshift(5188294801009928667, -20), 4511955915741593600)
endfunction
call s:themis_vimspec_scopes.push(copy(l:), 4, 2)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_4()
    else
function! s:themis_vimspec_scope_5() abort
let s:themis_vimspec_bundles += [themis#bundle#new('with 32bit number', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(5)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00004"] = 'shifts bits to left'
function! s:themis_vimspec_bundles[-1].suite.T_00004() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
          Assert Equals(B.lshift(1, 32), 1)
          Assert Equals(B.lshift(0x80000000, 1), 0)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00005"] = 'shifts bits to left (random)'
function! s:themis_vimspec_bundles[-1].suite.T_00005() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
          Assert Equals(B.lshift(1483929134, 14), -1114931200)
          Assert Equals(B.lshift(152442939, 25), 1979711488)
          Assert Equals(B.lshift(505850863, -32), 505850863)
          Assert Equals(B.lshift(1997594360, 18), 2078277632)
          Assert Equals(B.lshift(2121708807, -5), 939524096)
          Assert Equals(B.lshift(344493590, -27), -1861107008)
          Assert Equals(B.lshift(630127521, 14), -1092075520)
          Assert Equals(B.lshift(-601661263, 0), -601661263)
          Assert Equals(B.lshift(661012213, -26), -644891328)
          Assert Equals(B.lshift(828605241, -14), 216268800)
endfunction
call s:themis_vimspec_scopes.push(copy(l:), 5, 2)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_5()
    endif
call s:themis_vimspec_scopes.push(copy(l:), 2, 1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_2()

function! s:themis_vimspec_scope_6() abort
let s:themis_vimspec_bundles += [themis#bundle#new('.rshift()', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(6)
endfunction
function! s:themis_vimspec_scope_7() abort
let s:themis_vimspec_bundles += [themis#bundle#new('with small numbers', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(7)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00006"] = 'shifts bits to right'
function! s:themis_vimspec_bundles[-1].suite.T_00006() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
        Assert Equals(B.rshift(0, 0), 0)
        Assert Equals(B.rshift(0, 1), 0)
        Assert Equals(B.rshift(0, 31), 0)
        Assert Equals(B.rshift(0, 32), 0)
        Assert Equals(B.rshift(0x80000000, 0), 0x80000000)
        Assert Equals(B.rshift(0x80000000, 1), 0x40000000)
        Assert Equals(B.rshift(0x80000000, 31), 0x1)
        Assert Equals(B.rshift(1, 0), 0x1)
        Assert Equals(B.rshift(1, 1), 0)
endfunction
call s:themis_vimspec_scopes.push(copy(l:), 7, 6)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_7()
    if has('num64')
function! s:themis_vimspec_scope_8() abort
let s:themis_vimspec_bundles += [themis#bundle#new('with 64bit number', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(8)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00007"] = 'shifts bits to right'
function! s:themis_vimspec_bundles[-1].suite.T_00007() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
          Assert Equals(B.rshift(0x80000000, 32), 0)
          Assert Equals(B.rshift(x8000000000000000, 32), 0x80000000)
          Assert Equals(B.rshift(x8000000000000000, 63), 1)
          Assert Equals(B.rshift(-1024, 1), 0x7ffffffffffffe00)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00008"] = 'shifts bits to right (random)'
function! s:themis_vimspec_bundles[-1].suite.T_00008() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
          Assert Equals(B.rshift(-268801553147510890, -39), 541744903342)
          Assert Equals(B.rshift(-8658667913393403549, 60), 8)
          Assert Equals(B.rshift(8684623827924321670, -54), 8481077956957345)
          Assert Equals(B.rshift(-2848134570708700373, 24), 929749578416)
          Assert Equals(B.rshift(-9109203526092417183, 23), 1113121574833)
          Assert Equals(B.rshift(1597408012962228558, 31), 743851071)
          Assert Equals(B.rshift(8548771603265437164, -19), 242970)
          Assert Equals(B.rshift(2784858960009211313, -9), 77)
          Assert Equals(B.rshift(5980153482236010223, -56), 23359974539984414)
          Assert Equals(B.rshift(5014075726800027940, -58), 78344933231250436)
endfunction
call s:themis_vimspec_scopes.push(copy(l:), 8, 6)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_8()
    else
function! s:themis_vimspec_scope_9() abort
let s:themis_vimspec_bundles += [themis#bundle#new('with 32bit number', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(9)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00009"] = 'shifts bits to right'
function! s:themis_vimspec_bundles[-1].suite.T_00009() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
          Assert Equals(B.rshift(0x80000000, 32), 0x80000000)
          Assert Equals(B.rshift(-1024, 1), 0x7ffffe00)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00010"] = 'shifts bits to right (random)'
function! s:themis_vimspec_bundles[-1].suite.T_00010() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
          Assert Equals(B.rshift(-488472937, -18), 232329)
          Assert Equals(B.rshift(2077835096, 9), 4058271)
          Assert Equals(B.rshift(-944346085, -27), 104706912)
          Assert Equals(B.rshift(-410125501, -23), 7587581)
          Assert Equals(B.rshift(-976767239, 10), 3240429)
          Assert Equals(B.rshift(999071336, 20), 952)
          Assert Equals(B.rshift(1103884747, -13), 2105)
          Assert Equals(B.rshift(1971440513, -1), 0)
          Assert Equals(B.rshift(-440231805, -25), 30115121)
          Assert Equals(B.rshift(1872776440, 23), 223)
endfunction
call s:themis_vimspec_scopes.push(copy(l:), 9, 6)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_9()
    endif
call s:themis_vimspec_scopes.push(copy(l:), 6, 1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_6()

function! s:themis_vimspec_scope_10() abort
let s:themis_vimspec_bundles += [themis#bundle#new('.compare()', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(10)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00011"] = 'compares as unsigned int'
function! s:themis_vimspec_bundles[-1].suite.T_00011() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
      Assert Equals(B.compare(2, 1), 1)
      Assert Equals(B.compare(0xFFFFFFFE, 0xFFFFFFFF), -1)
      Assert Equals(B.compare(0x0FFFFFFF, 0xFFFFFFFF), -1)
endfunction
call s:themis_vimspec_scopes.push(copy(l:), 10, 1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_10()

function! s:themis_vimspec_scope_11() abort
let s:themis_vimspec_bundles += [themis#bundle#new('.invert()', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(11)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00012"] = 'returns bitwise invert'
function! s:themis_vimspec_bundles[-1].suite.T_00012() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
      Assert Equals(B.invert(0), -0x1)
      Assert Equals(B.invert(0xffffffff), -0x100000000)
      Assert Equals(B.invert(0xf0f0f0f), -0xf0f0f10)
      Assert Equals(B.invert(0xf0f0f0f0), -0xf0f0f0f1)
      Assert Equals(B.invert(0xffff), -0x10000)
      Assert Equals(B.invert(0xff), -0x100)
      Assert Equals(B.invert(0xffffff), -0x1000000)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00013"] = 'returns bitwise invert (random)'
function! s:themis_vimspec_bundles[-1].suite.T_00013() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
      Assert Equals(B.invert(-2104009955), 2104009954)
      Assert Equals(B.invert(-1317510048), 1317510047)
      Assert Equals(B.invert(1806018573), -1806018574)
      Assert Equals(B.invert(-980665656), 980665655)
      Assert Equals(B.invert(-537231506), 537231505)
      Assert Equals(B.invert(-46151799), 46151798)
      Assert Equals(B.invert(1213208697), -1213208698)
      Assert Equals(B.invert(943205096), -943205097)
      Assert Equals(B.invert(2015127505), -2015127506)
      Assert Equals(B.invert(35201008), -35201009)
endfunction
call s:themis_vimspec_scopes.push(copy(l:), 11, 1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_11()

function! s:themis_vimspec_scope_12() abort
let s:themis_vimspec_bundles += [themis#bundle#new('.and()', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(12)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00014"] = 'returns bitwise AND'
function! s:themis_vimspec_bundles[-1].suite.T_00014() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
      Assert Equals(B.and(0, 0), 0)
      Assert Equals(B.and(0xffffffff, 0), 0)
      Assert Equals(B.and(0xffffffff, 0xffffffff), 0xffffffff)
      Assert Equals(B.and(0xf0f0f0f0, 0xf0f0f0f), 0)
      Assert Equals(B.and(0xf0f0f0f0, 0xf0f0f0f0), 0xf0f0f0f0)
      Assert Equals(B.and(0xffff0000, 0xffff), 0)
      Assert Equals(B.and(0xff000000, 0xff), 0)
      Assert Equals(B.and(0xffffff00, 0xffffff), 0xffff00)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00015"] = 'returns bitwise AND (random)'
function! s:themis_vimspec_bundles[-1].suite.T_00015() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
      Assert Equals(B.and(-1296912273, -1904774433), -2110640049)
      Assert Equals(B.and(432461732, -859843378), 143053956)
      Assert Equals(B.and(2098863212, 959746948), 957353988)
      Assert Equals(B.and(144789504, -1435475015), 136331264)
      Assert Equals(B.and(-1325876821, -209876503), -1334277719)
      Assert Equals(B.and(-484132304, 491371309), 16824864)
      Assert Equals(B.and(-1787481070, 1602359046), 352322562)
      Assert Equals(B.and(-516431469, 1421177042), 1077239954)
      Assert Equals(B.and(-2028633248, 1046228473), 101974368)
      Assert Equals(B.and(764178285, 2068092473), 688129577)
endfunction
call s:themis_vimspec_scopes.push(copy(l:), 12, 1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_12()

function! s:themis_vimspec_scope_13() abort
let s:themis_vimspec_bundles += [themis#bundle#new('.or()', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(13)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00016"] = 'returns bitwise OR'
function! s:themis_vimspec_bundles[-1].suite.T_00016() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
      Assert Equals(B.or(0, 0), 0)
      Assert Equals(B.or(0xffffffff, 0), 0xffffffff)
      Assert Equals(B.or(0xffffffff, 0xffffffff), 0xffffffff)
      Assert Equals(B.or(0xf0f0f0f0, 0xf0f0f0f), 0xffffffff)
      Assert Equals(B.or(0xf0f0f0f0, 0xf0f0f0f0), 0xf0f0f0f0)
      Assert Equals(B.or(0xffff0000, 0xffff), 0xffffffff)
      Assert Equals(B.or(0xff000000, 0xff), 0xff0000ff)
      Assert Equals(B.or(0xffffff00, 0xffffff), 0xffffffff)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00017"] = 'returns bitwise OR (random)'
function! s:themis_vimspec_bundles[-1].suite.T_00017() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
      Assert Equals(B.or(173374042, -686154780), -547390466)
      Assert Equals(B.or(988002410, 1611007623), 2062008047)
      Assert Equals(B.or(1617121838, 2063766753), 2070140655)
      Assert Equals(B.or(-68314761, -1067373081), -68305417)
      Assert Equals(B.or(2110784177, 1692066345), 2111496889)
      Assert Equals(B.or(-2063323858, -1250703135), -1250431505)
      Assert Equals(B.or(-555502256, 1817484023), -17317897)
      Assert Equals(B.or(1840020982, 1846433830), 1873706486)
      Assert Equals(B.or(-1642487163, -2106395568), -1636043051)
      Assert Equals(B.or(1706960204, 865619605), 2008969181)
endfunction
call s:themis_vimspec_scopes.push(copy(l:), 13, 1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_13()

function! s:themis_vimspec_scope_14() abort
let s:themis_vimspec_bundles += [themis#bundle#new('.xor()', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(14)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00018"] = 'returns bitwise XOR'
function! s:themis_vimspec_bundles[-1].suite.T_00018() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
      Assert Equals(B.xor(0, 0), 0)
      Assert Equals(B.xor(0xffffffff, 0), 0xffffffff)
      Assert Equals(B.xor(0xffffffff, 0xffffffff), 0)
      Assert Equals(B.xor(0xf0f0f0f0, 0xf0f0f0f), 0xffffffff)
      Assert Equals(B.xor(0xf0f0f0f0, 0xf0f0f0f0), 0)
      Assert Equals(B.xor(0xffff0000, 0xffff), 0xffffffff)
      Assert Equals(B.xor(0xff000000, 0xff), 0xff0000ff)
      Assert Equals(B.xor(0xffffff00, 0xffffff), 0xff0000ff)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00019"] = 'returns bitwise XOR (random)'
function! s:themis_vimspec_bundles[-1].suite.T_00019() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
      Assert Equals(B.xor(271738232, 581446732), 848972084)
      Assert Equals(B.xor(-1493178930, 1597520677), -104341781)
      Assert Equals(B.xor(-1605313579, -452835553), 1163041994)
      Assert Equals(B.xor(-2010996666, 1805365375), -474410951)
      Assert Equals(B.xor(189013461, 1428653660), 1583586185)
      Assert Equals(B.xor(927050540, 304702767), 627625475)
      Assert Equals(B.xor(-651395973, 726399460), -228096609)
      Assert Equals(B.xor(292595176, -1074885945), -1365364945)
      Assert Equals(B.xor(1544212087, -476653766), -1080288947)
      Assert Equals(B.xor(838539477, 1024734483), 217001414)
endfunction
call s:themis_vimspec_scopes.push(copy(l:), 14, 1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_14()

function! s:themis_vimspec_scope_15() abort
let s:themis_vimspec_bundles += [themis#bundle#new('.sign_extension()', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(15)
endfunction
    if has('num64')
function! s:themis_vimspec_scope_16() abort
let s:themis_vimspec_bundles += [themis#bundle#new('with 64bit number', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(16)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00020"] = 'applies sign extension'
function! s:themis_vimspec_bundles[-1].suite.T_00020() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
          " NOTE:
          " An int literal larger than or equal to 0x8000000000000000 will be rounded
          " to 0x7FFFFFFFFFFFFFFF after Vim 8.0.0219, so create it without literal
          let xFFFFFFFF00000000 = B.lshift(0xFFFFFFFF, 32)
          let xFFFFFFFF7FFFFFFF = or(0x7FFFFFFF, xFFFFFFFF00000000)
          let xFFFFFFFF80000000 = or(0x80000000, xFFFFFFFF00000000)
          let xFFFFFFFFFFFFFFFF = or(0xFFFFFFFF, xFFFFFFFF00000000)
          Assert Equals(B.sign_extension(0), 0)
          Assert Equals(B.sign_extension(-1), -1)
          Assert Equals(B.sign_extension(1), 1)
          Assert Equals(B.sign_extension(0x7FFFFFFF), 0x7FFFFFFF)
          Assert Equals(B.sign_extension(xFFFFFFFF7FFFFFFF), 0x7FFFFFFF)
          Assert Equals(B.sign_extension(0x80000000), xFFFFFFFF80000000)
          Assert Equals(B.sign_extension(xFFFFFFFF80000000), xFFFFFFFF80000000)
          Assert Equals(B.sign_extension(0xFFFFFFFF), xFFFFFFFFFFFFFFFF)
endfunction
call s:themis_vimspec_scopes.push(copy(l:), 16, 15)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_16()
    else
function! s:themis_vimspec_scope_17() abort
let s:themis_vimspec_bundles += [themis#bundle#new('with 32bit number', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(17)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00021"] = 'returns the argument directly'
function! s:themis_vimspec_bundles[-1].suite.T_00021() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
          Assert Equals(B.sign_extension(0), 0)
          Assert Equals(B.sign_extension(-1), -1)
          Assert Equals(B.sign_extension(1), 1)
          Assert Equals(B.sign_extension(0x7FFFFFFF), 0x7FFFFFFF)
          Assert Equals(B.sign_extension(0x80000000), 0x80000000)
endfunction
call s:themis_vimspec_scopes.push(copy(l:), 17, 15)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_17()
    endif
call s:themis_vimspec_scopes.push(copy(l:), 15, 1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_15()

function! s:themis_vimspec_scope_18() abort
let s:themis_vimspec_bundles += [themis#bundle#new('.lshift32()', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(18)
endfunction
    if has('num64')
function! s:themis_vimspec_scope_19() abort
let s:themis_vimspec_bundles += [themis#bundle#new('with 64bit number', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(19)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00022"] = 'shifts bits to left with the 32bit range'
function! s:themis_vimspec_bundles[-1].suite.T_00022() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
          Assert Equals(B.lshift32(0xFFFF0000, 8), 0xFF000000)
          Assert Equals(B.lshift32(0xFFFF0000, 32), 0xFFFF0000)
endfunction
call s:themis_vimspec_scopes.push(copy(l:), 19, 18)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_19()
    else
function! s:themis_vimspec_scope_20() abort
let s:themis_vimspec_bundles += [themis#bundle#new('with 32bit number', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(20)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00023"] = 'is save as lshift()'
function! s:themis_vimspec_bundles[-1].suite.T_00023() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
          Assert Equals(B.lshift(0, 0), 0)
          Assert Equals(B.lshift(0, 1), 0)
          Assert Equals(B.lshift(0, 31), 0)
          Assert Equals(B.lshift(0, 32), 0)
          Assert Equals(B.lshift(1, 0), 0x1)
          Assert Equals(B.lshift(1, 1), 0x2)
          Assert Equals(B.lshift(1, 31), 0x80000000)
          Assert Equals(B.lshift(0x80000000, 0), 0x80000000)

          Assert Equals(B.lshift(1, 32), 1)
          Assert Equals(B.lshift(0x80000000, 1), 0)
endfunction
call s:themis_vimspec_scopes.push(copy(l:), 20, 18)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_20()
    endif
call s:themis_vimspec_scopes.push(copy(l:), 18, 1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_18()

function! s:themis_vimspec_scope_21() abort
let s:themis_vimspec_bundles += [themis#bundle#new('.rshift32()', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(21)
endfunction
    if has('num64')
function! s:themis_vimspec_scope_22() abort
let s:themis_vimspec_bundles += [themis#bundle#new('with 64bit number', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(22)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00024"] = 'shifts bits to right with the 32bit range'
function! s:themis_vimspec_bundles[-1].suite.T_00024() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
          Assert Equals(B.rshift32(0xFFFF000000, 8), 0x00FF0000)
          Assert Equals(B.rshift32(0xFFFF0000, 32), 0xFFFF0000)
endfunction
call s:themis_vimspec_scopes.push(copy(l:), 22, 21)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_22()
    else
function! s:themis_vimspec_scope_23() abort
let s:themis_vimspec_bundles += [themis#bundle#new('with 32bit number', s:themis_vimspec_bundles[-1])]
let s:themis_vimspec_bundles[-1]._vimspec_hooks = {}
function! s:themis_vimspec_bundles[-1]._vimspec_hooks.start_test()
  call s:themis_vimspec_scopes.tmp_scope(23)
endfunction
let s:themis_vimspec_bundles[-1].suite_descriptions["T_00025"] = 'is save as rshift()'
function! s:themis_vimspec_bundles[-1].suite.T_00025() abort
execute s:themis_vimspec_scopes.extend("s:themis_vimspec_scopes.scope(0)", 0)
          Assert Equals(B.rshift(0, 0), 0)
          Assert Equals(B.rshift(0, 1), 0)
          Assert Equals(B.rshift(0, 31), 0)
          Assert Equals(B.rshift(0, 32), 0)
          Assert Equals(B.rshift(0x80000000, 0), 0x80000000)
          Assert Equals(B.rshift(0x80000000, 1), 0x40000000)
          Assert Equals(B.rshift(0x80000000, 31), 0x1)
          Assert Equals(B.rshift(1, 0), 0x1)
          Assert Equals(B.rshift(1, 1), 0)

          Assert Equals(B.rshift(0x80000000, 32), 0x80000000)
          Assert Equals(B.rshift(-1024, 1), 0x7ffffe00)
endfunction
call s:themis_vimspec_scopes.push(copy(l:), 23, 21)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_23()
    endif
call s:themis_vimspec_scopes.push(copy(l:), 21, 1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_21()
call s:themis_vimspec_scopes.push(copy(l:), 1, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1]._vimspec_hooks, -1)
call themis#util#adjust_func_line(s:themis_vimspec_bundles[-1].suite, -1)
call remove(s:themis_vimspec_bundles, -1)
endfunction
call s:themis_vimspec_scope_1()
