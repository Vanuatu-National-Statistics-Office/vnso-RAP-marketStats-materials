clear
insheet using "vegis_roster.tab", tab case names

label variable vegis_roster__id `"Id in vegis_roster"'

label variable interview__key `"Interview key (identifier in XX-XX-XX-XX format)"'

label define vegetable_code 1 `"Bowl Cabbage (white)"' 2 `"Bowl Cabbage (purple)"' 3 `"Chiness Cabbage"' 4 `"Cuccumber"' 5 `"Pumpkin"' 6 `"Island Cabbage"' 7 `"Lettuce"' 8 `"Tomatoes"' 9 `"Dried Coconut"' 10 `"Green Coconut"' 
label values vegetable_code vegetable_code
label variable vegetable_code `"vegetable_code"'

label define veg_measure_type 1 `"Basket"' 2 `"Net"' 3 `"Each"' 4 `"Bundle"' 
label values veg_measure_type veg_measure_type
label variable veg_measure_type `"veg_measure_type"'

label variable vegetable_price1 `"vegetable_price1"'

label variable vegetables_weight1 `"vegetables_weight1"'

label variable vegetable_price2 `"vegetable_price2"'

label variable vegetables_weight2 `"vegetables_weight2"'

label variable vegetable_price3 `"vegetable_price3"'

label variable vegetables_weight3 `"vegetables_weight3"'

label variable vegetable_price4 `"vegetable_price4"'

label variable vegetables_weight4 `"vegetables_weight4"'

label variable vegetable_price5 `"vegetable_price5"'

label variable vegetables_weight5 `"vegetables_weight5"'

label variable vegetable_type `"Roster list question"'

label variable interview__id `"Unique 32-character long identifier of the interview"'
