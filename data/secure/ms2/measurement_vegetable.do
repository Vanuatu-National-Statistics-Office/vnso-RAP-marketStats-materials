clear
insheet using "measurement_vegetable.tab", tab case names

label define measurement_vegetable__id 2 `"Net"' 3 `"Each"' 4 `"Bundle"' 
label values measurement_vegetable__id measurement_vegetable__id
label variable measurement_vegetable__id `"Id in measurement_vegetable"'

label variable interview__key `"Interview key (identifier in XX-XX-XX-XX format)"'

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

label variable interview__id `"Unique 32-character long identifier of the interview"'

label variable vegis_roster__id `"Id in "vegis_roster""'
