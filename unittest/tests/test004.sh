
source "${BASH_SOURCE%/*}"/../setup.sh

# Speed test

cat >>$vimtestdir/.vimrc <<EOL
EOL

cat >>$vimtestdir/test.vim <<EOL

let longstr  = "htnic54ywi568ywcyuwo54yu8cwkl8uklcrhsghwk4x5thglktschrtglckshtrglsxihertlie58hltxsiuhtglsci85htcnlis8he5tclmh"
let longstr .= "586um9w8y5o68w5lyrltkcyulr58yulsrhuldc8udxlutn5iyuhtr68yumslryujsrclyj5clmrgstlxrtjlscrj6lisrjlisyjhclthjcmst"
let longstr .= "s58uvymsru85yvs8r96lrictryuvlm58usve5hcsmorh5ylbi9rd5mrreoij5mltvmrjylbimjxyxlryjhbmlxir5jyvlxlhjrxylvixlriyh"
let longstr .= "5s8umvs8u5vor5yvhjl5ryjld6rjyvldjryvdiomrj5y,odjriyvoidrj6yvjrdloyjv5idmorij5yvlisrj5ylvidjr5l767vijdlr5jvi7l"
let longstr .= "9587p6u8dumsoef84y6v74ow8y2of546g9uoy0lknunjb90vgdcro8t9856vs5ro78y6cs5yvhtfvrt7csse75vst7rhtcs7etsetcs7e4tch"
let longstr .= "w4sr5y8smvryh8lmcd5iml6seiul5yvhdbnugcvil8mft5yvilhdilmctxlivyhbdicr5myvhdcf8i5ltrilmydvhlrjylmr85lyvr6lsymhr"
let longstr .= "DTBU69V7D67Y8SUMCL845LS86YVUBMDLTC59,ODVOL4M7YUBJFM6Y7VY5,CU5VBH,9Æ6KTMB5YV8MSUC5RL8MS5YCU8SM5YUHVMSE5HCSM8L"
let longstr .= "8U4M7ODYV8LMU548VMSUCE846UY5W48O57BUIK09RYT89E589877YH2SRCFNH5ETV7I5HREB68Y7JBV8RT78VSR7IN5YHCWE75THCETCNHI7N"
let longstr .= "S598UVY6D7BM6F8O7JODU85CUJYB8TCDL54UM6S8U389W45VL4Y5BUN0I9770BUI9B98UNVINUHCUIERHT8 HT8E5YH 85RHY 8RHY58SR78E"
let longstr .= "S8I46U7FHBTF8MCUTRDYL8NUBHDMY6VTFIYJHBLIYGCJDLCRE5O6EUS8L6YU8VRDYBUF70IN6709VN6RI8UTCIEY45HXIN7E5TCIN75ETHCN7"

let longstr .= "HTNIC54YWI568YWCYUWO54YU8CWKL8UKLCRHSGHWK4X5THGLKTSCHRTGLCKSHTRGLSXIHERTLIE58HLTXSIUHTGLSCI85HTCNLIS8HE5TCLMH"
let longstr .= "586UM9W8Y5O68W5LYRLTKCYULR58YULSRHULDC8UDXLUTN5IYUHTR68YUMSLRYUJSRCLYJ5CLMRGSTLXRTJLSCRJ6LISRJLISYJHCLTHJCMST"
let longstr .= "S58UVYMSRU85YVS8R96LRICTRYUVLM58USVE5HCSMORH5YLBI9RD5MRREOIJ5MLTVMRJYLBIMJXYXLRYJHBMLXIR5JYVLXLHJRXYLVIXLRIYH"
let longstr .= "5S8UMVS8U5VOR5YVHJL5RYJLD6RJYVLDJRYVDIOMRJ5Y,ODJRIYVOIDRJ6YVJRDLOYJV5IDMORIJ5YVLISRJ5YLVIDJR5L767VIJDLR5JVI7L"
let longstr .= "9587P6U8DUMSOEF84Y6V74OW8Y2OF546G9UOY0LKNUNJB90VGDCRO8T9856VS5RO78Y6CS5YVHTFVRT7CSSE75VST7RHTCS7ETSETCS7E4TCH"
let longstr .= "W4SR5Y8SMVRYH8LMCD5IML6SEIUL5YVHDBNUGCVIL8MFT5YVILHDILMCTXLIVYHBDICR5MYVHDCF8I5LTRILMYDVHLRJYLMR85LYVR6LSYMHR"
let longstr .= "dtbu69v7d67y8sumcl845ls86yvubmdltc59,odvol4m7yubjfm6y7vy5,cu5vbh,9æ6ktmb5yv8msuc5rl8ms5ycu8sm5yuhvmse5hcsm8l"
let longstr .= "8u4m7odyv8lmu548vmsuce846uy5w48o57buik09ryt89e589877yh2srcfnh5etv7i5hreb68y7jbv8rt78vsr7in5yhcwe75thcetcnhi7n"
let longstr .= "s598uvy6d7bm6f8o7jodu85cujyb8tcdl54um6s8u389w45vl4y5bun0i9770bui9b98unvinuhcuierht8 ht8e5yh 85rhy 8rhy58sr78e"
let longstr .= "s8i46u7fhbtf8mcutrdyl8nubhdmy6vtfiyjhbliygcjdlcre5o6eus8l6yu8vrdybuf70in6709vn6ri8utciey45hxin7e5tcin75ethcn7"
echom len(longstr)

for i in range(0,2000,100)
	let starttime = reltime()
	let suffix_array = suffix_array#SuffixArray([[longstr, 0, i]])
	let difftime = reltimefloat(reltime(starttime))
	echom i . ', ' . string(difftime) . ', ' . string(difftime*1000000.0/(i*log(i)))
endfor


EOL

HOME=$vimtestdir vim -X a.txt

popd > /dev/null
source "${BASH_SOURCE%/*}"/../tear_down.sh
exit 0

vim:tw=78:ts=4:ft=vim:
