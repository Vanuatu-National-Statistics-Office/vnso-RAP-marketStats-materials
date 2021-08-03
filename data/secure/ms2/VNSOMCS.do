clear
insheet using "VNSOMCS.tab", tab case names

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

label variable product_type__0 `"product_type:0"'

label variable product_type__1 `"product_type:1"'

label variable product_type__2 `"product_type:2"'

label variable product_type__3 `"product_type:3"'

label variable product_type__4 `"product_type:4"'

label variable product_type__5 `"product_type:5"'

label variable product_type__6 `"product_type:6"'

label variable product_type__7 `"product_type:7"'

label variable product_type__8 `"product_type:8"'

label variable product_type__9 `"product_type:9"'

label variable product_type__10 `"product_type:10"'

label variable product_type__11 `"product_type:11"'

label variable product_type__12 `"product_type:12"'

label variable product_type__13 `"product_type:13"'

label variable product_type__14 `"product_type:14"'

label variable product_type__15 `"product_type:15"'

label variable product_type__16 `"product_type:16"'

label variable product_type__17 `"product_type:17"'

label variable product_type__18 `"product_type:18"'

label variable product_type__19 `"product_type:19"'

label variable fruit_type__0 `"fruit_type:0"'

label variable fruit_type__1 `"fruit_type:1"'

label variable fruit_type__2 `"fruit_type:2"'

label variable fruit_type__3 `"fruit_type:3"'

label variable fruit_type__4 `"fruit_type:4"'

label variable fruit_type__5 `"fruit_type:5"'

label variable fruit_type__6 `"fruit_type:6"'

label variable fruit_type__7 `"fruit_type:7"'

label variable fruit_type__8 `"fruit_type:8"'

label variable fruit_type__9 `"fruit_type:9"'

label variable vegetable_type__0 `"vegetable_type:0"'

label variable vegetable_type__1 `"vegetable_type:1"'

label variable vegetable_type__2 `"vegetable_type:2"'

label variable vegetable_type__3 `"vegetable_type:3"'

label variable vegetable_type__4 `"vegetable_type:4"'

label variable vegetable_type__5 `"vegetable_type:5"'

label variable vegetable_type__6 `"vegetable_type:6"'

label variable vegetable_type__7 `"vegetable_type:7"'

label variable vegetable_type__8 `"vegetable_type:8"'

label variable vegetable_type__9 `"vegetable_type:9"'
