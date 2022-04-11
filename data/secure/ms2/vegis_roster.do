clear
insheet using "vegis_roster.tab", tab case names

label define vegis_roster__id 1 `"Bowl Cabbage (White)"' 2 `"Bowl Cabbage (Purple)"' 3 `"Carrot"' 4 `"Chinese Cabbage"' 5 `"Cucumber"' 6 `"Pumpkin"' 7 `"Island Cabbage"' 8 `"Lettuce"' 9 `"Tomato (Big Type)"' 10 `"Tomato (Small Type)"' 11 `"Potato"' 12 `"Onion"' 13 `"Capsicum"' 14 `"Bean"' 15 `"Chilli"' 16 `"Sweet Corn"' 17 `"Broccoli"' 
label values vegis_roster__id vegis_roster__id
label variable vegis_roster__id `"Id in vegis_roster"'

label variable interview__key `"Interview key (identifier in XX-XX-XX-XX format)"'

label define vegetable_code 1 `"Bowl Cabbage (white)"' 2 `"Bowl Cabbage (purple)"' 3 `"Carrot"' 4 `"Chinese Cabbage"' 5 `"Cucumber"' 6 `"Pumpkin"' 7 `"Island Cabbage"' 8 `"Lettuce"' 9 `"Tomatoes"' 10 `"Potato"' 11 `"Onion"' 12 `"Capsicum"' 13 `"Bean"' 14 `"Chilli"' 15 `"Sweet Corn"' 16 `"Broccoli"' 
label values vegetable_code vegetable_code
label variable vegetable_code `"vegetable_code"'

label variable veg_measure_type__2 `"veg_measure_type:Net"'

label variable veg_measure_type__3 `"veg_measure_type:Each"'

label variable veg_measure_type__4 `"veg_measure_type:Bundle"'

label variable interview__id `"Unique 32-character long identifier of the interview"'
