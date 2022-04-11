clear
insheet using "measurement_rootcrop.tab", tab case names

label define measurement_rootcrop__id 1 `"Basket"' 2 `"Net"' 3 `"Bundle"' 4 `"Each"' 5 `"Heap/Pile"' 6 `"Bunch"' 7 `"Ring/Tier"' 
label values measurement_rootcrop__id measurement_rootcrop__id
label variable measurement_rootcrop__id `"Id in measurement_rootcrop"'

label variable interview__key `"Interview key (identifier in XX-XX-XX-XX format)"'

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

label variable interview__id `"Unique 32-character long identifier of the interview"'

label variable root_crop_roster__id `"Id in "root_crop_roster""'
