clear
insheet using "fruits_roster.tab", tab case names

label define fruits_roster__id 1 `"Banana - ripe (Big type)"' 2 `"Banana - ripe (Small type)"' 3 `"Pawpaw"' 4 `"Water Melon"' 5 `"Pineapple"' 6 `"Lime"' 7 `"Orange"' 8 `"Breadfruit"' 9 `"Green Coconut"' 
label values fruits_roster__id fruits_roster__id
label variable fruits_roster__id `"Id in fruits_roster"'

label variable interview__key `"Interview key (identifier in XX-XX-XX-XX format)"'

label define fruit_code 1 `"Ripe Banana (Big type)"' 2 `"Ripe Banana (Small type)"' 3 `"Pawpaw"' 4 `"Water Melon"' 5 `"Pineapple"' 6 `"Lime"' 7 `"Orange"' 8 `"Breadfruit"' 9 `"Green Coconut"' 
label values fruit_code fruit_code
label variable fruit_code `"fruit_code"'

label variable F_measure_type__1 `"Fmeasure_type:Net"'

label variable F_measure_type__2 `"Fmeasure_type:Bunch"'

label variable F_measure_type__3 `"Fmeasure_type:Ring/Tier"'

label variable F_measure_type__4 `"Fmeasure_type:Each"'

label variable interview__id `"Unique 32-character long identifier of the interview"'
