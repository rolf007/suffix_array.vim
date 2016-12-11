source "${BASH_SOURCE%/*}"/../setup.sh

# Test banana

cat >>$vimtestdir/.vimrc <<EOL
EOL

cat >>$vimtestdir/test.vim <<EOL

" show that 'a' (5) comes before 'ana' (3)
let suffix_array = suffix_array#SuffixArray([["banana", 0, 6]])
call assert_equal([[5, 0], [3, 0], [1, 0], [0, 0], [4, 0], [2, 0]], suffix_array)

" show that 'a(x)' (5) comes before 'ana(x)' (3) because 'x' is not part of
" the string considered
let suffix_array = suffix_array#SuffixArray([["bananax", 0, 6]])
call assert_equal([[5, 0], [3, 0], [1, 0], [0, 0], [4, 0], [2, 0]], suffix_array)

EOL

HOME=$vimtestdir vim -X a.txt

popd > /dev/null
source "${BASH_SOURCE%/*}"/../tear_down.sh
exit 0

vim:tw=78:ts=4:ft=vim:
