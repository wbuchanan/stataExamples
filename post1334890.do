// Example posted to Statalist.org
// Response to post:
// http://www.statalist.org/forums/forum/general-stata-discussion/general/1334890-how-to-make-scales-the-same-size-on-a-twowayscatter
// Question about scale of graph/variables

// Load example data
sysuse auto.dta, clear

// Rename a couple variables to match the posting
rename (price mpg)(yvariable xvariable)

// Generates summary statistics for the variable xvariable
qui: su xvariable

// Stores the minimum value of xvariable
sca xmin = r(min)

// Stores the maximum value of xvariable
sca xmax = r(max)

// Do the same for the yvariable
qui: su yvariable
sca ymin = r(min)
sca ymax = r(max)

// Get the minimum value of the two variables
loc rmin `= min(xmin, ymin)'

// Get the maximum value of the two variables
loc rmax `= max(xmax, ymax)'

// Creates a graph with a 45 degree line with the same scales for the two 
// variables
tw scatter yvariable xvariable, ysca(range(`rmin'(1000)`rmax')) 			 ///   
xsca(range(`rmin'(1000)`rmax')) || function y=x, range(`rmin' `rmax')		 ///   
name(example1, replace)

// Since the literal translation of your question illustrated above doesn't  
// appear to be useful in many situations, I'll assume the intention was related 
// to the measurement scale of the variables

// This will standardize (z-score transformation) the yvariable 
egen yvar = std(yvariable), m(0) std(1)

// And this will do the same for the xvariable 
egen xvar = std(xvariable), m(0) std(1)

// Even though the same means and SD were specified above, if you want to 
// enforce the same scale on the graph, it would be good to explicitly set those 
// values in the command
tw scatter yvar xvar, ysca(range(-5(.5)5)) xsca(range(-5(.5)5)) || 			 ///   
function y=x, range(-5 5) name(example2, replace)


