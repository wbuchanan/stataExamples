/*

Simple data entry example in response to the post:
http://www.statalist.org/forums/forum/general-stata-discussion/general/1335869-the-likert-scale

OP clarified that question was related to data entry and labeling values
based on the question the example below shows how the task could be accomplished.

*/

// Clear all data from memory
clear

// Input data directly into Stata.  
// The input command requires space delimited values
input str3 id int(i1 i2 i3 i4 i5 i20)
"  1" 1 4 2 3 5 5
"  2" 1 3 3 2 4 1 
end

// Defines a set of value labels
la def responsesets 1 "Strongly Disagree" 2 "Disagree" 3 "Neutral" 4 "Agree" ///   
					5 "Strongly Agree"
					
// Get the list of variables that are not string types					
qui: ds, not(type string)

// Apply the value labels to these variables 
/* Thanks to Clyde Schecter for pointing out that the -label value- command
can accept a variable list argument thereby eliminating the need to loop over 
the values returned by the -ds- command.  */
la val `r(varlist)' responsesets

// Displays the data in the results pane
li
