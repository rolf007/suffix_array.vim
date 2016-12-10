source "${BASH_SOURCE%/*}"/../setup.sh

# Test typical usecase

cat >>$vimtestdir/.vimrc <<EOL
EOL

cat >>$vimtestdir/test.vim <<EOL

let strings = ["stabxabcdefg01234", "wxyzstabcdefg7654fg01"]

let strs = [[strings[0], 0, len(strings[0])], [strings[1], 0, len(strings[1])]]
let suffix_array = suffix_array#SuffixArray(strs)
call assert_equal([[19, 1], [12, 0], [20, 1], [13, 0], [14, 0], [15, 0], [16, 0], [16, 1], [15, 1], [14, 1], [13, 1], [5, 0], [6, 1], [2, 0], [6, 0], [7, 1], [3, 0], [7, 0], [8, 1], [8, 0], [9, 1], [9, 0], [10, 1], [17, 1], [10, 0], [11, 1], [18, 1], [11, 0], [12, 1], [4, 1], [0, 0], [5, 1], [1, 0], [0, 1], [4, 0], [1, 1], [2, 1], [3, 1]], suffix_array)
let longest = suffix_array#LongestCommonSubstring(suffix_array, strs)
call assert_equal([5, 6, 7], longest)
call assert_equal("abcdefg", strpart(strings[0], longest[0], longest[2]))
call assert_equal("abcdefg", strpart(strings[1], longest[1], longest[2]))

let strs0 = [[strings[0], 0, longest[0]], [strings[1], 0, longest[1]]]
let suffix_array0 = suffix_array#SuffixArray(strs0)
call assert_equal([[2, 0], [3, 0], [4, 1], [0, 0], [5, 1], [1, 0], [0, 1], [4, 0], [1, 1], [2, 1], [3, 1]], suffix_array0)
let longest0 = suffix_array#LongestCommonSubstring(suffix_array0, strs0)
call assert_equal([0, 4, 2], longest0)
call assert_equal("st", strpart(strings[0], longest0[0], longest0[2]))
call assert_equal("st", strpart(strings[1], longest0[1], longest0[2]))

let strs1 = [[strings[0], longest[0]+longest[2], len(strings[0])], [strings[1], longest[1]+longest[2], len(strings[1])]]
let suffix_array1 = suffix_array#SuffixArray(strs1)
call assert_equal([[19, 1], [12, 0], [20, 1], [13, 0], [14, 0], [15, 0], [16, 0], [16, 1], [15, 1], [14, 1], [13, 1], [17, 1], [18, 1]], suffix_array1)
let longest1 = suffix_array#LongestCommonSubstring(suffix_array1, strs1)
call assert_equal([12, 19, 2], longest1)
call assert_equal("01", strpart(strings[0], longest1[0], longest1[2]))
call assert_equal("01", strpart(strings[1], longest1[1], longest1[2]))

EOL

HOME=$vimtestdir vim -X a.txt

popd > /dev/null
source "${BASH_SOURCE%/*}"/../tear_down.sh
exit 0

vim:tw=78:ts=4:ft=vim:
