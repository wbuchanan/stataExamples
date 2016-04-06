// Example in response to the posting:
// http://www.statalist.org/forums/forum/general-stata-discussion/general/1333827-stata-tell-me-a-joke

// Drop the program if already loaded in memory
cap prog drop joke

// Define a program
program joke

    // Set the version under which Stata should interpret the syntax
    version 8.2

    // Preserve the current state of the data currently in memory
    preserve

        // Check for a data set with all of your jokes that persists independently 
        // from the program itself
        cap: confirm file `"`c(sysdir_personal)'jokes.dta"'

        // If the file doesn't already exist
        if _rc != 0 {
        
            // Clear any data currently loaded in memory
            clear
            
            // Set the number of observations
            qui: set obs 4
            
            // Store jokes in the joke variable 
            qui: g joke = "In order to solve this differential equation, you stare at it until the solution occurs to you (G. P{c o'}lya)" in 1
            qui: replace joke = "What is mind? No matter! What is matter? Never mind! (19th century at least)" in 2
            qui: replace joke = "Variance is the attitude of one statistician to another (R.A. Fisher)" in 3
            qui: replace joke =  "Using the data to guide the data analysis is almost as dangerous as not doing so (Frank Harrell)" in 4

            // Save the dataset along the path so it can be found easily regardless 
            // of the end user's operating system
            qui: save `"`c(sysdir_personal)'jokes.dta"', replace
            
        } // End IF Block to create initial file
        
        // If the file does already exist load the file into active memory
        else  qui: use `"`c(sysdir_personal)'jokes.dta"', clear
            
        // Print a random joke to the screen 
        di as smcl joke[ceil(`c(N)' * runiform())]

    // Return to the state of the data at the time the program was called
    restore

// End of the program definition    
end


