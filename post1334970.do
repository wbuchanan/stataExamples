// Example from Statalist.org
// Response to post:
// http://www.statalist.org/forums/forum/general-stata-discussion/general/1334970-how-to-first-difference-observations
// Question about generating first differences without xtsetting the data first

// Clear all data from memory
clear

// Set the random number seed 
set seed 7779311

// Generate some fake data
set obs 10

// Create year values
qui: g int year = _n + 2006

// Random numbers of sectors across years
qui: g nsector = rpoisson(6)

// Create nsector observations of sectors within years
expandcl nsector, gen(sector) cl(year)

// Creates an ID variable for sectors
bys year: g sectorid = _n

// Number of firms within sectors/years
qui: g nfirms = int(runiform(15, 50))

// Expand the data to show firms within sectors and years
expandcl nfirms, gen(firms) cl(year sectorid)

// Create a firm id
bys year sectorid: g firmid = _n

// Create some amount value
g amount = rnormal(100000, 25000)

// Create some total value
g total = rnormal(1000000, 500000)
 
// Remove erroneous variables
drop nsector sector nfirms firms 

// If the primary key is known:
bys sectorid firmid (year): g difftotal = total - total[_n - 1]

