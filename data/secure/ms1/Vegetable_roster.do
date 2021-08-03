insheet using "Vegetable_roster.tab", tab case names

label variable Vegetable_roster__id `"Roster instance identifier"'

label variable interview__key `"Interview key (identifier in XX-XX-XX-XX format)"'

label variable vegetable_quantity `"vegetable_quantity"'

label define vegetable_measure 1 `"Net"' 2 `"Kilo"' 3 `"Plastic bag"' 4 `"fruit"' 5 `"bundle"' 6 `"pile/heap"' 
label values vegetable_measure vegetable_measure
label variable vegetable_measure `"vegetable_quantity"'

label variable vegetable_food `""'

label variable interview__id `"Unique 32-character long identifier of the interview"'
