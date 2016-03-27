// Load sample data
webuse grunfeld, clear

// Rescale the investment variable
qui: g double ret = invest/1500

// Simplification of some of the previously used code
bys company (year): g cumul = cond(_n == 1, ret, ret + l.ret)	

// Drop all but records for a few companies
qui: keep if company < 8

// Define value labels for a country variable that will be created
la def country 	1 "FR" 2 "US" 3 "DE" 4 "AT" 5 "BE" 6 "ES" 7 "CY" 8 "FI" 	 ///   
				9 "IT" 10 "NL" 11 "GR" 12 "SI", modify

// Create a country indicator
qui: g byte country = 	cond(inlist(company, 1, 4, 7) == 1, 1, 				 ///   
						cond(inlist(company, 2, 5) == 1, 2,					 ///   
						cond(inlist(company, 3, 6) == 1, 3, .)))

// Apply value labels to the country variable						
la val country country						

// Generate EMU identifier
qui: g byte emu = cond(country == 2, 0, 1)    

// compute abnormal returns for countries and countrygroups (EMU)
// averages for each country
egen mcc = mean(cumul), by(year country)  

// emu average based on averaging all emu companies
egen mec = mean(cumul), by(year emu)         

// Maintain current state of the data in memory
preserve

	// Reduces the data to only unique country by year records
	qui: collapse (firstnm) mcc mec, by(country year)

	// Adds variable labels to populate the legend
	la var mcc "Mean Abnormal Returns by Country"
	la var mec "Mean Abnormal Returns by Country Group"

	// Sets the data as panel
	xtset country year
	
	// Use xtline to graph the two overlaid lines in subplots
	// Uses the graph scheme from the brewscheme examples
	xtline mcc mec, scheme(ggplot2ex1)
	
	// Export so it can be shared on the StataList
	gr export ~/Desktop/Programs/StataPrograms/stataExamples/post1332782-ex1.png, as(png) replace

	// Can also overlay the lines in separate graphs for each variable
	// This scheme file is also illustrated in the brewscheme examples
	xtline mcc, scheme(manycolorex1) overlay
	
	// Export so it can be shared on the StataList
	gr export ~/Desktop/Programs/StataPrograms/stataExamples/post1332782-ex2.png, as(png) replace

// Return to previous state of the data
restore
