insheet using "VNSOMS2019.tab", tab case names

label variable interview__id `"Unique 32-character long identifier of the interview"'

label variable interview__key `"Interview key (identifier in XX-XX-XX-XX format)"'

label variable sssys_irnd `"Random number in the range 0..1 associated with interview"'

label variable has__errors `"Errors count in the interview"'

label define interview__status 0 `"Restored"' 20 `"Created"' 40 `"SupervisorAssigned"' 60 `"InterviewerAssigned"' 65 `"RejectedBySupervisor"' 80 `"ReadyForInterview"' 85 `"SentToCapi"' 95 `"Restarted"' 100 `"Completed"' 120 `"ApprovedBySupervisor"' 125 `"RejectedByHeadquarters"' 130 `"ApprovedByHeadquarters"' -1 `"Deleted"' 
label values interview__status interview__status
label variable interview__status `"Status of the interview"'

label define market_location 1 `"Port Vila Municipal Market"' 2 `"Luganville Municipal Market"' 3 `"Manples Market - Port Vila"' 
label values market_location market_location
label variable market_location `"market_location"'

label variable survey_date `"survey_date"'

label variable farmer_number `"farmer_number"'

label define staple_food_sale 1 `"Yes"' 2 `"No"' 
label values staple_food_sale staple_food_sale
label variable staple_food_sale `"staple_food_sale"'

label variable staple_food__0 `"staple_food:0"'

label variable staple_food__1 `"staple_food:1"'

label variable staple_food__2 `"staple_food:2"'

label variable staple_food__3 `"staple_food:3"'

label variable staple_food__4 `"staple_food:4"'

label variable staple_food__5 `"staple_food:5"'

label variable staple_food__6 `"staple_food:6"'

label variable staple_food__7 `"staple_food:7"'

label variable staple_food__8 `"staple_food:8"'

label variable staple_food__9 `"staple_food:9"'

label define vegetables_sale 1 `"Yes"' 2 `"No"' 
label values vegetables_sale vegetables_sale
label variable vegetables_sale `"vegetables_sale"'

label variable vegetable_food__0 `"vegetable_food:0"'

label variable vegetable_food__1 `"vegetable_food:1"'

label variable vegetable_food__2 `"vegetable_food:2"'

label variable vegetable_food__3 `"vegetable_food:3"'

label variable vegetable_food__4 `"vegetable_food:4"'

label variable vegetable_food__5 `"vegetable_food:5"'

label variable vegetable_food__6 `"vegetable_food:6"'

label variable vegetable_food__7 `"vegetable_food:7"'

label variable vegetable_food__8 `"vegetable_food:8"'

label variable vegetable_food__9 `"vegetable_food:9"'

label define fruit_sale 1 `"Yes"' 2 `"No"' 
label values fruit_sale fruit_sale
label variable fruit_sale `"fruit_sale"'

label variable fruits_food__0 `"fruits_food:0"'

label variable fruits_food__1 `"fruits_food:1"'

label variable fruits_food__2 `"fruits_food:2"'

label variable fruits_food__3 `"fruits_food:3"'

label variable fruits_food__4 `"fruits_food:4"'

label variable fruits_food__5 `"fruits_food:5"'

label variable fruits_food__6 `"fruits_food:6"'

label variable fruits_food__7 `"fruits_food:7"'

label variable fruits_food__8 `"fruits_food:8"'

label variable fruits_food__9 `"fruits_food:9"'
