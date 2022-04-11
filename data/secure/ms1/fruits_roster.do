clear
insheet using "fruits_roster.tab", tab case names

label define fruits_roster__id 1 `"Banana ripe (Big type)"' 2 `"Pawpaw"' 3 `"Water melon"' 4 `"Pineapple"' 5 `"Lime"' 6 `"Orange"' 7 `"Breadfruit"' 8 `"Green coconut"' 9 `"Banana ripe (Small type)"' 
label values fruits_roster__id fruits_roster__id
label variable fruits_roster__id `"Id in fruits_roster"'

label variable interview__key `"Interview key (identifier in XX-XX-XX-XX format)"'

label variable fruit_measure__1 `"fruit_quantity:Net"'

label variable fruit_measure__2 `"fruit_quantity:Each"'

label variable fruit_measure__3 `"fruit_quantity:bunch"'

label variable fruit_measure__4 `"fruit_quantity:ring/tier"'

label variable fruit_measure__5 `"fruit_quantity:pile/heap"'

label variable interview__id `"Unique 32-character long identifier of the interview"'
