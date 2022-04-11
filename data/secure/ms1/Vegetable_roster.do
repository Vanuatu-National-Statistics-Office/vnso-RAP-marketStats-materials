clear
insheet using "Vegetable_roster.tab", tab case names

label define Vegetable_roster__id 1 `"Bowl Cabbage (White)"' 2 `"Bowl Cabbage (Purple)"' 3 `"Carrot"' 4 `"Chinese Cabbage"' 5 `"Cucumber"' 6 `"Pumpkin"' 7 `"Island Cabbage"' 8 `"Lettuce"' 9 `"Tomato"' 10 `"Potato"' 11 `"Onion"' 12 `"Capsicum"' 13 `"Bean"' 14 `"Chilli"' 15 `"Sweet corn"' 16 `"Broccoli"' 
label values Vegetable_roster__id Vegetable_roster__id
label variable Vegetable_roster__id `"Id in Vegetable_roster"'

label variable interview__key `"Interview key (identifier in XX-XX-XX-XX format)"'

label variable vegetable_measure__1 `"vegetable_quantity:Net"'

label variable vegetable_measure__2 `"vegetable_quantity:Each"'

label variable vegetable_measure__3 `"vegetable_quantity:Plastic bag"'

label variable vegetable_measure__4 `"vegetable_quantity:fruit"'

label variable vegetable_measure__5 `"vegetable_quantity:bundle"'

label variable vegetable_measure__6 `"vegetable_quantity:pile/heap"'

label variable interview__id `"Unique 32-character long identifier of the interview"'
