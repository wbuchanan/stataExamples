/* 
 Example showing D3 color palette being used with ggplot2 style theme aesthetics
*/

// Change the end of line delimiter
#d ;

// Generate the theme file used to simulate ggplot2 aesthetics
brewtheme ggtheme, numticks("major 5" "horizontal_major 5" "vertical_major 5"     
"horizontal_minor 10" "vertical_minor 10") color("plotregion gs15"          
"matrix_plotregion gs15" "background gs15" "textbox gs15" "legend gs15"       
"box gs15" "mat_label_box gs15" "text_option_fill gs15" "clegend gs15"        
"histback gs15" "pboxlabelfill gs15" "plabelfill gs15" "pmarkbkfill gs15"      
"pmarkback gs15") linew("major_grid medthick" "minor_grid thin" "legend medium"    
"clegend medium") clockdir("legend_position 3") yesno("draw_major_grid yes"     
"draw_minor_grid yes" "legend_force_draw yes" "legend_force_nodraw no"        
"draw_minor_vgrid yes" "draw_minor_hgrid yes" "extend_grid_low yes"         
"extend_grid_high yes" "extend_axes_low no" "extend_axes_high no")          
gridsty("minor minor") axissty("horizontal_default horizontal_withgrid"       
"vertical_default vertical_withgrid") linepattern("major_grid solid"        
"minor_grid solid") linesty("major_grid major_grid" "minor_grid minor_grid")     
ticksty("minor minor_notick" "minor_notick minor_notick")               
ticksetsty("major_vert_withgrid minor_vert_nolabel"                 
"major_horiz_withgrid minor_horiz_nolabel"                      
"major_horiz_nolabel major_horiz_default"                       
"major_vert_nolabel major_vert_default") gsize("minortick_label minuscule"        
"minortick tiny") numsty("legend_cols 1" "legend_rows 0" "zyx2rows 0" 
"zyx2cols 1") verticaltext("legend top");

// Change the end of line delimiter back to a carriage return
#d cr

// Creates the scheme using the D3js category10 palette
brewscheme, scheme(ggd3) allsty(category10) allc(10) themef(ggtheme) 		 ///   
symbols(diamond triangle square)

// Load the auto.dta dataset
sysuse auto.dta, clear

// Create the same graph with each of the different schemes
tw  scatter mpg weight if rep78 == 1 || scatter mpg weight if rep78 == 2 ||  ///    
scatter mpg weight if rep78 == 3 || scatter mpg weight if rep78 == 4 ||  	 ///    
scatter mpg weight if rep78 == 5,  scheme(ggd3) legend(order(1 "rep78 == 1"  ///   
2 "rep78 == 2" 3 "rep78 == 3" 4 "rep78 == 4" 5 "rep78 == 5")) name(ggd3, replace)

// Export the example graph    
gr export ~/Desktop/Programs/StataPrograms/stataExamples/ggd3-Example.png, as(png) replace

