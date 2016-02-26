/*
Example file used to show how one of the commands from https://github.com/wbuchanan/StataRegex
can be used to perform regular expression tasks over variable lists.
*/

clear
set obs 1000
set seed 7779311
tempvar hasparen hasspace hashyphen area exchange extension areas exchanges extensions
g `hasparen' = .
g `hasspace' = .
g `hashyphen' = .
g `area' = .
g `exchange' = .
g `extension' = .
g `areas' = ""
g `exchanges' = ""
g `extensions' = ""

forv i = 1/3 {
    qui: replace `hasparen' = rbinomial(1, .5)
    qui: replace `hasspace' = rbinomial(1, .5)
    qui: replace `hashyphen' = rbinomial(1, .5)    
    
    qui: replace `area' = int(runiform(1, 999))
    qui: replace `exchange' = int(runiform(1, 999))
    qui: replace `extension' = int(runiform(1, 9999))
    
    qui: replace `areas' = cond(inrange(`area', 1, 9), "  " + strofreal(`area'), ///   
                           cond(inrange(`area', 10, 99), strofreal(`area') + " ", ///   
                           strofreal(`area')))
    qui: replace `areas' = "(" + `areas' + ")" if `hasparen' == 1
    
    qui: replace `exchanges' = cond(inrange(`exchange', 1, 9), " " + strofreal(`exchange') + " ", ///   
                           cond(inrange(`exchange', 10, 99), " " + strofreal(`exchange'), ///   
                           strofreal(`exchange')))
    
    qui: replace `extensions' = cond(inrange(`extension', 1, 9), " " + strofreal(`extension') + " ", ///   
                           cond(inrange(`extension', 10, 99), " " + strofreal(`extension'), ///   
                           cond(inrange(`extension', 100, 999), strofreal(`extension') + " ", ///   
                           strofreal(`extension'))))
    
    qui: g phone`i' = cond(`hasspace' == 1 & `hashyphen' == 1, ///   
                    `areas' + " " + `exchanges' + " - " + `extensions', ///   
                    cond(`hasspace' == 0 & `hashyphen' == 1, ///   
                    `areas' + `exchanges' + "-" + `extensions', ///   
                    cond(`hasspace' == 1 & `hashyphen' == 0, ///   
                    `areas' + " " + `exchanges' + " " + `extensions', ///   
                    `areas' + `exchanges' + `extensions')))
}

// Shows Java-based regular expression function opperating over multiple variables and assigning the 
// results to a single variable named clnphone
jregex replace phone* clnphone, p(`"(\(\d{3}\) )(\d{3})( - )(\d{4})"') rep(`"$1$2$3$4"')