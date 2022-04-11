clear
insheet using "root_crop_roster.tab", tab case names

label variable root_crop_roster__id `"Id in root_crop_roster"'

label variable interview__key `"Interview key (identifier in XX-XX-XX-XX format)"'

label define root_crop_code 1 `"Fiji Taro"' 2 `"Island Taro"' 3 `"Manioc"' 4 `"Sweet Kumala"' 5 `"Yam"' 6 `"Green Banana (Big Type)"' 7 `"Green Banana (Small Type)"' 
label values root_crop_code root_crop_code
label variable root_crop_code `"root_crop_code"'

label define measure_type 1 `"Basket"' 2 `"Net"' 3 `"Bundle"' 4 `"Each"' 5 `"Heap/Pile"' 6 `"B/Type Bunch"' 7 `"B/Type Ring/Tier"' 
label values measure_type measure_type
label variable measure_type `"measure_type"'

label variable staple_price1 `"staple_price1"'

label variable staple_wieght1 `"staple_wieght1"'

label variable staple_price2 `"staple_price2"'

label variable staple_wieght2 `"staple_wieght2"'

label variable staple_price3 `"staple_price3"'

label variable staple_wieght3 `"staple_wieght3"'

label variable staple_price4 `"staple_price4"'

label variable staple_wieght4 `"staple_wieght4"'

label variable staple_price5 `"staple_price5"'

label variable staple_wieght5 `"staple_wieght5"'

label variable product_type `"Roster list question"'

label variable interview__id `"Unique 32-character long identifier of the interview"'
