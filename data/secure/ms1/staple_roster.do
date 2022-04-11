clear
insheet using "staple_roster.tab", tab case names

label define staple_roster__id 1 `"Fiji Taro"' 2 `"Island Taro"' 3 `"Manioc"' 4 `"Kumala (Sweet potato)"' 5 `"Yam"' 6 `"Green Banana (Big Type)"' 7 `"Green Banana (Small Type)"' 8 `"Dry Coconut"' 
label values staple_roster__id staple_roster__id
label variable staple_roster__id `"Id in staple_roster"'

label variable interview__key `"Interview key (identifier in XX-XX-XX-XX format)"'

label variable stable_measure__1 `"stable_measure:Bundle"'

label variable stable_measure__2 `"stable_measure:Basket"'

label variable stable_measure__3 `"stable_measure:Pile/Heap"'

label variable stable_measure__4 `"stable_measure:Bunch"'

label variable stable_measure__5 `"stable_measure:Ring/tier"'

label variable stable_measure__6 `"stable_measure:Net"'

label variable stable_measure__7 `"stable_measure:Each"'

label variable interview__id `"Unique 32-character long identifier of the interview"'
