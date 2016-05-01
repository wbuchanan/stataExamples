/*
Response to post:

http://www.statalist.org/forums/forum/general-stata-discussion/general/1338269-breaking-execution-of-stata

OP encountered an error with code that another community member replicated with 
a standard dataset.  It seems to be a case of macro expansion affecting things.
*/
sysuse auto.dta, clear
loc variables mpg price weight
foreach var of loc variables {
	loc vlabel `: variable label `var''
	gr bar `var', over(foreign, label(angle(45)) sort(`var') reverse) 		 ///   
	ytitle(`"% `vlabel'"') graphr(color(white) ilcolor(black)) 				 ///   
	plotr(lcolor(black)) name(`var')
}

