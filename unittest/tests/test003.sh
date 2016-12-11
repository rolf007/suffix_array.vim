source "${BASH_SOURCE%/*}"/../setup.sh

# Test lists

cat >>$vimtestdir/.vimrc <<EOL
EOL

cat >>$vimtestdir/test.vim <<EOL

let list0 = ['first', 'some', 'random', 'foo', 'then', 'the', 'matching', 'stuff', 'then', 'an', 'epilogue']
let list1 = ['also', 'random', 'goo', 'then', 'the', 'matching', 'stuff', 'also', 'epilogue']
let lists = [[list0, 0, len(list0)], [list1, 0, len(list1)]]
let suffix_array = suffix_array#SuffixArray(lists)
call assert_equal([[7, 1], [0, 1], [9, 0], [10, 0], [8, 1], [0, 0], [3, 0], [2, 1], [5, 1], [6, 0], [2, 0], [1, 1], [1, 0], [6, 1], [7, 0], [4, 1], [5, 0], [8, 0], [3, 1], [4, 0]], suffix_array)

let longest = suffix_array#LongestCommonSubstring(suffix_array, lists)
call assert_equal([4, 3, 4], longest)
call assert_equal(['then', 'the', 'matching', 'stuff'], list0[longest[0] : longest[0]+longest[2]-1])
call assert_equal(['then', 'the', 'matching', 'stuff'], list1[longest[1] : longest[1]+longest[2]-1])

EOL

HOME=$vimtestdir vim -X a.txt

popd > /dev/null
source "${BASH_SOURCE%/*}"/../tear_down.sh
exit 0

vim:tw=78:ts=4:ft=vim:

