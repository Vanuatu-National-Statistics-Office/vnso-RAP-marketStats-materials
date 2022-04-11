clear
insheet using "root_crop_roster.tab", tab case names

label define root_crop_roster__id 1 `"Fiji Taro"' 2 `"Island Taro"' 3 `"Manioc"' 4 `"Sweet Potato (Kumala)"' 5 `"Yam"' 6 `"Banana - green (Big type)"' 7 `"Banana - green (Small type)"' 8 `"Dry Coconut"' 
label values root_crop_roster__id root_crop_roster__id
label variable root_crop_roster__id `"Id in root_crop_roster"'

label variable interview__key `"Interview key (identifier in XX-XX-XX-XX format)"'

label define root_crop_code 1 `"Fiji Taro"' 2 `"Island Taro"' 3 `"Manioc"' 4 `"Sweet Potato (Kumala)"' 5 `"Yam"' 6 `"Green Banana (Big Type)"' 7 `"Green Banana (Small Type)"' 8 `"Dry Coconut"' 
label values root_crop_code root_crop_code
label variable root_crop_code `"root_crop_code"'

label variable measure_type__1 `"measure_type:Basket"'

label variable measure_type__2 `"measure_type:Net"'

label variable measure_type__3 `"measure_type:Bundle"'

label variable measure_type__4 `"measure_type:Each"'

label variable measure_type__5 `"measure_type:Heap/Pile"'

label variable measure_type__6 `"measure_type:Bunch"'

label variable measure_type__7 `"measure_type:Ring/Tier"'

label variable interview__id `"Unique 32-character long identifier of the interview"'
