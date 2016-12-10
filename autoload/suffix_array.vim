function! s:LCP(a, a0, a1, b, b0, b1)
	let l = 0
	for i in range(min([a:a1-a:a0, a:b1-a:b0]))
		if a:a[i+a:a0] != a:b[i+a:b0]
			return l
		endif
		let l = l +1
	endfor
	return l
endfunction

func! s:MyCompare(i1, i2)
	return a:i1 == a:i2 ? 0 : a:i1 > a:i2 ? 1 : -1
endfunc

function! suffix_array#SuffixArray(strings)
	let s = []
	for j in range(len(a:strings))
		echom j . " " . a:strings[j][1] . ' ' . a:strings[j][2]
		for i in range(a:strings[j][1], a:strings[j][2] - 1)
			call add(s, [i,j])
		endfor
	endfor
	call sort(s, {a,b -> s:MyCompare(strpart(a:strings[a[1]][0], a[0]), strpart(a:strings[b[1]][0], b[0])) })
	return s
endfunction

function! suffix_array#LongestCommonSubstring(suffix_array, strings)
	let ret = [0,0,0]
	let bestl = 0
	for i in range(len(a:suffix_array))
		if i != 0
			if a:suffix_array[i][1] != a:suffix_array[i-1][1]
				let l = s:LCP(a:strings[a:suffix_array[i  ][1]][0], a:suffix_array[i  ][0], a:strings[a:suffix_array[i  ][1]][2],
				          \ a:strings[a:suffix_array[i-1][1]][0], a:suffix_array[i-1][0], a:strings[a:suffix_array[i-1][1]][2])
				if l > bestl
					let bestl = l
					if a:suffix_array[i][1] == 0
						let ret = [a:suffix_array[i][0], a:suffix_array[i-1][0], l]
					else
						let ret = [a:suffix_array[i-1][0], a:suffix_array[i][0], l]
					endif
				endif
			endif
		endif
	endfor
	return ret
endfunction
