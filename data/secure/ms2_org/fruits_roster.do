clear
insheet using "fruits_roster.tab", tab case names

label variable fruits_roster__id `"Id in fruits_roster"'

label variable interview__key `"Interview key (identifier in XX-XX-XX-XX format)"'

label define fruit_code 1 `"Green Banana (Big type)"' 2 `"Green Banana (Small type )"' 3 `"Ripe Banana (Big type)"' 4 `"Ripe Banana (Small type)"' 5 `"Pawpaw"' 6 `"Water Melon"' 7 `"Pineapple"' 8 `"Lime"' 9 `"Orange"' 10 `"Breadfruit"' 
label values fruit_code fruit_code
label variable fruit_code `"fruit_code"'

label define F_measure_type 1 `"Basket"' 2 `"Net"' 5 `"S/Type Bunch"' 6 `"S/Type Ring/Tier"' 7 `"Each"' 
label values F_measure_type F_measure_type
label variable F_measure_type `"Fmeasure_type"'

label variable fruit_price1 `"fruit_price1"'

label variable fruit_weight1 `"fruit_weight1"'

label variable fruit_price2 `"fruit_price2"'

label variable fruit_weight2 `"fruit_weight2"'

label variable fruit_price3 `"fruit_price3"'

label variable fruit_weight3 `"fruit_weight3"'

label variable fruit_price4 `"fruit_price4"'

label variable fruit_weight4 `"fruit_weight4"'

label variable fruit_price5 `"fruit_price5"'

label variable fruit_weight5 `"fruit_weight5"'

label variable fruit_type `"Roster list question"'

label variable interview__id `"Unique 32-character long identifier of the interview"'
