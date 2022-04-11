clear
insheet using "VNSOMCS_1.tab", tab case names

label variable interview__id `"Unique 32-character long identifier of the interview"'

label variable interview__key `"Interview key (identifier in XX-XX-XX-XX format)"'

label variable assignment__id `"Assignment id (identifier in numeric format)"'

label variable sssys_irnd `"Random number in the range 0..1 associated with interview"'

label variable has__errors `"Errors count in the interview"'

label define interview__status 0 `"Restored"' 20 `"Created"' 40 `"SupervisorAssigned"' 60 `"InterviewerAssigned"' 65 `"RejectedBySupervisor"' 80 `"ReadyForInterview"' 85 `"SentToCapi"' 95 `"Restarted"' 100 `"Completed"' 120 `"ApprovedBySupervisor"' 125 `"RejectedByHeadquarters"' 130 `"ApprovedByHeadquarters"' -1 `"Deleted"' 
label values interview__status interview__status
label variable interview__status `"Status of the interview"'

label define market 1 `"Port Vila Municipal Market"' 2 `"Luganville Municipal Market"' 3 `"Manples Market"' 4 `"Lenakel Market"' 
label values market market
label variable market `"market"'

label variable market_gps__Latitude `"market_gps: Latitude"'

label variable market_gps__Longitude `"market_gps: Longitude"'

label variable market_gps__Accuracy `"market_gps: Accuracy"'

label variable market_gps__Altitude `"market_gps: Altitude"'

label variable market_gps__Timestamp `"market_gps: Timestamp"'

label variable survey_date `"survey_date"'

label define week 1 `"Week 1"' 2 `"Week 2"' 
label values week week
label variable week `"week"'

label define month 1 `"January"' 2 `"February"' 3 `"March"' 4 `"April"' 5 `"May"' 6 `"June"' 7 `"July"' 8 `"August"' 9 `"September"' 10 `"October"' 11 `"November"' 12 `"December"' 
label values month month
label variable month `"month"'

label variable year `"year"'

label variable root_crop_type__1 `"root_crop_type:Fiji Taro"'

label variable root_crop_type__2 `"root_crop_type:Island Taro"'

label variable root_crop_type__3 `"root_crop_type:Manioc"'

label variable root_crop_type__4 `"root_crop_type:Sweet Potato (Kumala)"'

label variable root_crop_type__5 `"root_crop_type:Yam"'

label variable root_crop_type__6 `"root_crop_type:Banana - green (Big type)"'

label variable root_crop_type__7 `"root_crop_type:Banana - green (Small type)"'

label variable root_crop_type__8 `"root_crop_type:Dry Coconut"'

label variable fruit_type__1 `"fruit_type:Banana - ripe (Big type)"'

label variable fruit_type__2 `"fruit_type:Banana - ripe (Small type)"'

label variable fruit_type__3 `"fruit_type:Pawpaw"'

label variable fruit_type__4 `"fruit_type:Water Melon"'

label variable fruit_type__5 `"fruit_type:Pineapple"'

label variable fruit_type__6 `"fruit_type:Lime"'

label variable fruit_type__7 `"fruit_type:Orange"'

label variable fruit_type__8 `"fruit_type:Breadfruit"'

label variable fruit_type__9 `"fruit_type:Green Coconut"'

label variable vegetable_type__1 `"vegetable_type:Bowl Cabbage (White)"'

label variable vegetable_type__2 `"vegetable_type:Bowl Cabbage (Purple)"'

label variable vegetable_type__3 `"vegetable_type:Carrot"'

label variable vegetable_type__4 `"vegetable_type:Chinese Cabbage"'

label variable vegetable_type__5 `"vegetable_type:Cucumber"'

label variable vegetable_type__6 `"vegetable_type:Pumpkin"'

label variable vegetable_type__7 `"vegetable_type:Island Cabbage"'

label variable vegetable_type__8 `"vegetable_type:Lettuce"'

label variable vegetable_type__9 `"vegetable_type:Tomato (Big Type)"'

label variable vegetable_type__10 `"vegetable_type:Tomato (Small Type)"'

label variable vegetable_type__11 `"vegetable_type:Potato"'

label variable vegetable_type__12 `"vegetable_type:Onion"'

label variable vegetable_type__13 `"vegetable_type:Capsicum"'

label variable vegetable_type__14 `"vegetable_type:Bean"'

label variable vegetable_type__15 `"vegetable_type:Chilli"'

label variable vegetable_type__16 `"vegetable_type:Sweet Corn"'

label variable vegetable_type__17 `"vegetable_type:Broccoli"'
