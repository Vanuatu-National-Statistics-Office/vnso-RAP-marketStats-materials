clear
insheet using "VNSOMS2019.tab", tab case names

label variable interview__id `"Unique 32-character long identifier of the interview"'

label variable interview__key `"Interview key (identifier in XX-XX-XX-XX format)"'

label variable assignment__id `"Assignment id (identifier in numeric format)"'

label variable sssys_irnd `"Random number in the range 0..1 associated with interview"'

label variable has__errors `"Errors count in the interview"'

label define interview__status 0 `"Restored"' 20 `"Created"' 40 `"SupervisorAssigned"' 60 `"InterviewerAssigned"' 65 `"RejectedBySupervisor"' 80 `"ReadyForInterview"' 85 `"SentToCapi"' 95 `"Restarted"' 100 `"Completed"' 120 `"ApprovedBySupervisor"' 125 `"RejectedByHeadquarters"' 130 `"ApprovedByHeadquarters"' -1 `"Deleted"' 
label values interview__status interview__status
label variable interview__status `"Status of the interview"'

label define week 1 `"Week 1"' 2 `"Week 2"' 
label values week week
label variable week `"week"'

label define day 1 `"1"' 2 `"2"' 3 `"3"' 4 `"4"' 5 `"5"' 6 `"6"' 7 `"7"' 8 `"8"' 9 `"9"' 10 `"10"' 11 `"11"' 12 `"12"' 13 `"13"' 14 `"14"' 15 `"15"' 16 `"16"' 17 `"17"' 18 `"18"' 19 `"19"' 20 `"20"' 21 `"21"' 22 `"22"' 23 `"23"' 24 `"24"' 25 `"25"' 26 `"26"' 27 `"27"' 28 `"28"' 29 `"29"' 30 `"30"' 31 `"31"' 
label values day day
label variable day `"day"'

label define month 1 `"January"' 2 `"February"' 3 `"March"' 4 `"April"' 5 `"May"' 6 `"June"' 7 `"July"' 8 `"August"' 9 `"September"' 10 `"October"' 11 `"November"' 12 `"December"' 
label values month month
label variable month `"month"'

label variable year `"year"'

label define market_location 1 `"Port Vila Municipal Market"' 2 `"Luganville Municipal Market"' 3 `"Manples Market - Port Vila"' 4 `"Fresh Water Market"' 5 `"Lenakel Market"' 
label values market_location market_location
label variable market_location `"market_location"'

label variable survey_date `"survey_date"'

label variable farmer_number `"farmer_number"'

label variable supply_location `"supply_location"'

label define staple_food_sale 1 `"Yes"' 2 `"No"' 
label values staple_food_sale staple_food_sale
label variable staple_food_sale `"staple_food_sale"'

label variable stap_food__1 `"stap_food:Fiji Taro"'

label variable stap_food__2 `"stap_food:Island Taro"'

label variable stap_food__3 `"stap_food:Manioc"'

label variable stap_food__4 `"stap_food:Kumala (Sweet potato)"'

label variable stap_food__5 `"stap_food:Yam"'

label variable stap_food__6 `"stap_food:Green Banana (Big Type)"'

label variable stap_food__7 `"stap_food:Green Banana (Small Type)"'

label variable stap_food__8 `"stap_food:Dry Coconut"'

label define vegetables_sale 1 `"Yes"' 2 `"No"' 
label values vegetables_sale vegetables_sale
label variable vegetables_sale `"vegetables_sale"'

label variable veg_sale__1 `"veg_sale:Bowl Cabbage (White)"'

label variable veg_sale__2 `"veg_sale:Bowl Cabbage (Purple)"'

label variable veg_sale__3 `"veg_sale:Carrot"'

label variable veg_sale__4 `"veg_sale:Chinese Cabbage"'

label variable veg_sale__5 `"veg_sale:Cucumber"'

label variable veg_sale__6 `"veg_sale:Pumpkin"'

label variable veg_sale__7 `"veg_sale:Island Cabbage"'

label variable veg_sale__8 `"veg_sale:Lettuce"'

label variable veg_sale__9 `"veg_sale:Tomato"'

label variable veg_sale__10 `"veg_sale:Potato"'

label variable veg_sale__11 `"veg_sale:Onion"'

label variable veg_sale__12 `"veg_sale:Capsicum"'

label variable veg_sale__13 `"veg_sale:Bean"'

label variable veg_sale__14 `"veg_sale:Chilli"'

label variable veg_sale__15 `"veg_sale:Sweet corn"'

label variable veg_sale__16 `"veg_sale:Broccoli"'

label define fruit_sale 1 `"Yes"' 2 `"No"' 
label values fruit_sale fruit_sale
label variable fruit_sale `"fruit_sale"'

label variable fruit_code__1 `"fruit_code:Banana ripe (Big type)"'

label variable fruit_code__2 `"fruit_code:Pawpaw"'

label variable fruit_code__3 `"fruit_code:Water melon"'

label variable fruit_code__4 `"fruit_code:Pineapple"'

label variable fruit_code__5 `"fruit_code:Lime"'

label variable fruit_code__6 `"fruit_code:Orange"'

label variable fruit_code__7 `"fruit_code:Breadfruit"'

label variable fruit_code__8 `"fruit_code:Green coconut"'

label variable fruit_code__9 `"fruit_code:Banana ripe (Small type)"'
