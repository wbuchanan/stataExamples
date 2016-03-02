/*

OP asked about the benefits of using Rasch Modeling:

"Why do I need a complex model here? I'd just look at the descriptive statistics and check the percentage answered correctly. The lower the rate, the harder the math question?. Duh, isn't that kinda obvious? I stil dont get the benefits of a Rasch model here. Could someone explain? Btw, I use Stata 12."

I tried to give both a simple example as well as help to illustrate the implications it has with some sample data used in the Stata manuals.

The problem with your simplification is that it doesn't consider the ability of the respondents, and forms a dependency on persons in doing so. For example, if you gave an item like:

2 + 2 = ?
a. 0
b. 2
c. 2i
d. 4
e. 4i

At a MENSA convention, you wouldn't learn anything about the difficulty of the item because your person sample would all be clustered at the high end of ability (theta). Now, give them same item to a room full of young children (e.g., 4-5 years old) and now you have a completely different result (e.g., many students wouldn't get it correctly). So, does this mean the item is or isn't difficult? In both of these situations looking at the descriptive statistics alone provides a heavily context dependent view of the item and the ability of the respondents. In IRT models (as well as CTT models if structured to do so) the difficulty of the item and the ability of the respondents are placed on the same scale. So the difficulty parameter provides you with the point where for the same ability the probability of a correct response is chance (e.g., if the difficulty parameter is say .875 and the respondent has theta = 0.875 the probability they answer the question correctly is chance). The bigger and more likely reason for your professors suggestion is the independence between person and item parameters. In other words, if your data satisfy the Rasch model assumptions the item parameters are independent of the persons responding and you could sample any other items from the same domain and the people would still have the same value of theta. 

Given that the only parameter being estimated is difficulty it isn't that complex. While this example isn't completely pertinent to Stata 12, I think it could help to illustrate things a bit for you:
*/


webuse masc.dta, clear
qui: egen totalsc = rowtotal(q1 - q9)
qui: g pctcorrect = 100 * (totalsc / 9)
raschjmle q1-q9

/*
 Iteration                 Delta           Log-likelihood
--------------------------------------------------------------
         1     0.502591842208104       -3402.304331969046
         2     0.142412255554409       -3397.822027114892
         3     0.020979991419945       -3397.719031584525
         4     0.003561687956111       -3397.716620516149
         5     0.000591506681447       -3397.716599152711
--------------------------------------------------------------
                                                                                                              
=================================================================================================        
Item           Difficulty     Std. Error        WMS       Std. WMS        UMS       Std. UMS             
-------------------------------------------------------------------------------------------------        
q1                  -0.40           0.08         0.85        -4.32         0.84        -2.86                  
q2                   0.11           0.08         1.03         1.04         1.05         1.04                  
q3                  -1.36           0.10         0.93        -1.39         0.86        -1.39                  
q4                   0.49           0.08         0.99        -0.25         1.02         0.38                  
q5                   1.66           0.09         0.93        -1.54         1.02         0.28                  
q6                   0.82           0.08         0.93        -2.05         0.95        -0.82                  
q7                   1.37           0.09         1.10         2.42         1.17         1.99                  
q8                  -1.87           0.11         0.77        -3.81         0.85        -1.14                  
q9                  -0.81           0.09         1.04         1.04         1.13         1.66                  
=================================================================================================        



SCALE QUALITY STATISTICS                          
==================================================
Statistic                  Items     Persons  
--------------------------------------------------
Observed Variance         1.3031      1.4411
Observed Std. Dev.        1.1415      1.2005
Mean Square Error         0.0080      0.7097
Root MSE                  0.0894      0.8425
Adjusted Variance         1.2951      0.7314
Adjusted Std. Dev.        1.1380      0.8552
Separation Index         12.7235      1.0151
Number of Strata         17.2980      1.6868
Reliability               0.9939      0.5075
==================================================

            SCORE TABLE                
==================================
  Score        Theta      Std. Err
----------------------------------
    0.00        -3.94         1.89     
    1.00        -2.55         1.12     
    2.00        -1.59         0.89     
    3.00        -0.89         0.80     
    4.00        -0.28         0.77     
    5.00         0.31         0.76     
    6.00         0.91         0.79     
    7.00         1.59         0.87     
    8.00         2.53         1.11     
    9.00         3.89         1.89     
==================================
*/

li pctcorrect theta in 1/20

/*

     +------------------------+
     | pctcorr~t        theta |
     |------------------------|
  1. | 44.444444   -4.0678244 |
  2. | 33.333333   -.28832417 |
  3. | 22.222222   -.93143046 |
  4. | 22.222222   -1.6661277 |
  5. | 33.333333   -1.6661277 |
     |------------------------|
  6. | 22.222222   -.93143046 |
  7. | 44.444444   -1.6661277 |
  8. | 88.888889   -.28832417 |
  9. | 44.444444    2.6333477 |
 10. | 88.888889   -.28832417 |
     |------------------------|
 11. | 22.222222    2.6333477 |
 12. | 33.333333   -1.6661277 |
 13. | 33.333333   -.93143046 |
 14. | 22.222222   -.93143046 |
 15. | 77.777778   -1.6661277 |
     |------------------------|
 16. | 22.222222    1.6665872 |
 17. | 88.888889   -1.6661277 |
 18. | 33.333333    2.6333477 |
 19. | 33.333333   -.93143046 |
 20. | 55.555556   -.93143046 |
     +------------------------+
	 
In particular, it probably helps to look at the 2nd observation in the last code chunk above. The respondent only answered a third of the questions correctly, so why would they have a higher level of theta than observation 5 who also answered 33% of the items correctly? In this case, the difference is due to the difficulty of the items that each subject answered. The second respondent answered two of the more difficult questions correctly, while the fifth respondent answered more of the simpler questions correctly. 
*/
