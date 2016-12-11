func! s:MyCompare(x, y) dict
	let offset_x = a:x[0]
	let offset_y = a:y[0]
	let len_x = self.ends[a:x[1]] - offset_x
	let len_y = self.ends[a:y[1]] - offset_y
	let l = min([len_x, len_y])
	let str_x = self.strs[a:x[1]]
	let str_y = self.strs[a:y[1]]
	let j = 0
	while j < l
		let c_x = str_x[j+offset_x]
		let c_y = str_y[j+offset_y]
		if c_x < c_y
			return -1
		elseif c_x > c_y
			return 1
		endif
		let j = j + 1
	endwhile
	return len_x == len_y ? 0 : len_x > len_y ? 1 : -1
endfunc

function! suffix_array#SuffixArray(strings)
	let s = []
	let j = 0
	let l = len(a:strings)
	let sort_dict = {"strs":[], "ends":[]}
	while j < l
		let e = a:strings[j][2]
		let i = a:strings[j][1]
		while i < e
			call add(s, [i,j])
			let i = i + 1
		endwhile
		call add(sort_dict["strs"], a:strings[j][0])
		call add(sort_dict["ends"], a:strings[j][2])
		let j = j + 1
	endwhile
	let lens = len(s)

	call sort(s, "s:MyCompare", sort_dict)
	return s
endfunction

function! suffix_array#LongestCommonSubstring(suffix_array, strings)
	let s:suffix_array = a:suffix_array
	let s:strings = a:strings
	let ret = [0,0,0]
	let bestl = 0
	let suffix_array_len = len(a:suffix_array)
	let i = 1
	while i < suffix_array_len
		let aaa = s:suffix_array[i  ][1]
		let bbb = s:suffix_array[i-1][1]
		if aaa != bbb
			let str_info_x = s:strings[aaa]
			let str_info_y = s:strings[bbb]
			let str_x = str_info_x[0]
			let idx_x = s:suffix_array[i  ][0]
			let str_y = str_info_y[0]
			let idx_y = s:suffix_array[i-1][0]
			let lll = min([str_info_x[2]-idx_x, str_info_y[2]-idx_y])
			if lll >= bestl
				let l = 0
				while l < lll
					if str_x[l+idx_x] != str_y[l+idx_y]
						break
					endif
					let l = l + 1
				endwhile
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
		let i = i + 1
	endwhile
	return ret
endfunction
