/*
Response to post 1339510

http://www.statalist.org/forums/forum/general-stata-discussion/general/1339510-how-to-graph-and-interpret-the-interaction-between-2-continuous-variables-in-poisson-model-with-a-countinous-dependent-variable

Question regarding graphing the interaction of two continuous variables after fitting a poisson model to the data.
*/

// Loads example data set from Mitchell's book
sysuse gss_ivrm, clear

// Specifies the poisson model with the continuous interactions and polynomials
// in the OP's original example
poisson children c.educ##(c.educ c.realrinc) c.realrinc#c.realrinc, vce(robust)

// Estimates the marginal effects over the continuous variables
margins, at(educ=(0(5)20) realrinc=(259(100000)480144.5))

// Plots the marginal effects 
marginsplot
