clear
insheet using "measurement_fruits.tab", tab case names

label define measurement_fruits__id 1 `"Net"' 2 `"Bunch"' 3 `"Ring/Tier"' 4 `"Each"' 
label values measurement_fruits__id measurement_fruits__id
label variable measurement_fruits__id `"Id in measurement_fruits"'

label variable interview__key `"Interview key (identifier in XX-XX-XX-XX format)"'

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

label variable interview__id `"Unique 32-character long identifier of the interview"'

label variable fruits_roster__id `"Id in "fruits_roster""'
