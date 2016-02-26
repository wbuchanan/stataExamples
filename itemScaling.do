/* 
This is a response to a the thread:
http://www.statalist.org/forums/forum/general-stata-discussion/general/1328218-rescaling-variables-for-scale-construction

The OP's original question was:

"I have a 15 point additive scale I have created from several variables. 3 
variables are coded 0-4 (Strongly disagree to Strongly agree) and the fourth is 
coded 0-3 (poor, fair, good ,excellent). A colleague is suggesting that I change 
the last variable to a 0-4 scale to match the other variables by adding 1 to the 
good and excellent options. Since it's an additive scale, I fail to see what 
would be gained by doing so. Is there something here that I'm not seeing? Any 
thoughts would be appreciated."

*/

// Clears any data from memory
clear

// Sets random number seed
set seed 7779311

// Correlation matrix to simulate underlying latent for each ordinal variable
mat corr = (1, 			.75524244, 	.72977111, .54909616 \ ///   
			.75524244, 	1, 			.49770521, .58979257 \ ///   
			.72977111, 	.49770521, 	1,		   .79877923 \ ///   
			.54909616, 	.58979257, 	.79877923, 1) 
mat m = (0, 0, 0, 0)
mat sd = (1, 1, 1, 1)

// Simulate a thousand observations
drawnorm v1 v2 v3 v4, n(1000) sds(sd) m(m) corr(corr) 

// Used for random error associated with each item
qui: g e = .

// For variables using 5 choice response sets
forv i = 1/3 {

	// Generate some error
	replace e = runiform()

	// Add the error to the value of the underlying variable
	replace v`i' = v`i' + e
	
	// Categorize the variable into quintiles 
	xtile item`i' = v`i', n(5)
	
	// Reminder that the items are ordinal and do not actually have a true 0 value
	qui: replace item`i' = item`i' + 1
	
} // end loop

// random error for 4 choice response set item
replace e = runiform()

// Add error to latent for variable 4
replace v4 = v4 + e

// Cut into quartiles
xtile item4 = v4, n(4)

// Reminder that the items are ordinal and do not actually have a true 0 value
qui: replace item4 = item4 + 1

// Fit CFA to the items using ordinal family and logit link
gsem (Theta -> (item1 item2 item3 item4), ologit)

// Get predicted values of theta from the CFA
predict cfa_theta, mu ebmeans

// Fit a partial credit model (e.g., 1PL for ordinal items)
irt pcm item*

// Get the predicted values of theta from the PCM
predict pcm_theta, latent ebmeans

// Fit a generalized partial credit model (e.g., 2PL for ordinal items)
irt gpcm item*

// Get the predicted values of theta from the GPCM
predict gpcm_theta, latent ebmeans

// Fit a graded response model (e.g., assumes a different structure for the item thresholds)
irt grm item*

// Get the predicted values of theta from the GRM
predict grm_theta, latent ebmeans

// Create a simple sum score (this is the sufficient statistic for the PCM)
egen simplesum = rowtotal(item1 item2 item3 item4)

// Loop over the item responses
forv i = 1/4 {
	
	// Used to get min/max values in a generalized manner
	qui: su item`i', de
	
	// Wasn't sure if Dirk was suggesting to use this to normalize items or not
	g pitem`i' = 100 * (item`i' - `r(min)')/(`r(max)' - `r(min)')

	// Gets the total number of responses
	qui: levelsof item`i', loc(i`i')
	
	// Normalizes items based on Ben's response in # 8
	g nitem`i' = item`i' * (1/`: word count `i`i''')
	
} // End Loop

qui: su simplesum, de

// If Dirk's suggestion was based on the sum score and scale min/max
g pomp1score = (simplesum - `r(min)') / (`r(max)' - `r(min)')

// Sums normalized pomp items
egen pompsum = rowtotal(pitem1 pitem2 pitem3 pitem4)

// Sums normalized items
egen normsum = rowtotal(nitem1 nitem2 nitem3 nitem4)

// Standardized score based on simple sum only
egen stdscore = std(simplesum), m(0) std(1)

// Standardized score based on normalizing items with the POMP equation
egen pomp2score = std(pompsum), m(0) std(1)

// Standardized score based on normalized item sum scale
egen normscore = std(normsum), m(0) std(1)

// drops items no longer needed
drop pitem* nitem* v* e* 

// sets display order
order *theta *score

