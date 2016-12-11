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

func! s:MyCompare(x, y) dict
	let len_x = self.strings[a:x[1]][2] - a:x[0]
	let len_y = self.strings[a:y[1]][2] - a:y[0]
	let l = min([len_x, len_y])
	for j in range(l)
		let c_x = self.strings[a:x[1]][0][j+a:x[0]]
		let c_y = self.strings[a:y[1]][0][j+a:y[0]]
		if c_x < c_y
			return -1
		elseif c_x > c_y
			return 1
		endif
	endfor
	return len_x == len_y ? 0 : len_x > len_y ? 1 : -1
endfunc

function! suffix_array#SuffixArray(strings)
	let s = []
	for j in range(len(a:strings))
		echom j . " " . a:strings[j][1] . ' ' . a:strings[j][2]
		for i in range(a:strings[j][1], a:strings[j][2] - 1)
			call add(s, [i,j])
		endfor
	endfor
	call sort(s, "s:MyCompare", {"strings":a:strings})
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
