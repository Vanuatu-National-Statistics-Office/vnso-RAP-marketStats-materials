insheet using "fruits_roster.tab", tab case names

label variable fruits_roster__id `"Roster instance identifier"'

label variable interview__key `"Interview key (identifier in XX-XX-XX-XX format)"'

label variable fruit_quantity `"fruit_quantity"'

label define fruit_measure 1 `"Plastic bag"' 2 `"Kilo"' 3 `"bunch"' 4 `"ring/tier"' 5 `"pile/heap"' 6 `"fruit"' 
label values fruit_measure fruit_measure
label variable fruit_measure `"fruit_quantity"'

label variable fruits_food `""'

label variable interview__id `"Unique 32-character long identifier of the interview"'
