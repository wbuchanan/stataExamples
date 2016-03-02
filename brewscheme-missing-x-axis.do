/* 
This example was in response to trouble shooting a user question about 
- brewscheme - (https://wbuchanan.github.io/brewscheme) and why the x-axis was 
not visible.  There is still more work to answer all of the OP's questions, but 
this also serves as another example of using brewscheme. 
*/

discard

clear

#d ;

/* 1. create theme
minor_tick specified twice in the gsize option. 
*/
brewtheme matthiasg, graphsi("x 6.45" "y 4") 
numsty("legend_cols 0" "legend_rows 2" "zyx2rows 0" "zyx2cols 1")   
gsize("label med" "small_label small" "text medium" "body medsmall"    
"small_body small" "heading large" "matrix_label medlarge" 
"note small" "star medsmall" "text_option medsmall" 
"minor_tick half_tiny" "tick_biglabel medium" 
"title_gap vsmall" "key_gap vsmall" "key_linespace vsmall" 
"legend_key_xsize 4" "legend_key_ysize medsmall" 
"clegend_width huge" "pielabel_gap zero" "plabel small" "pboxlabel small" 
"sts_risktable_space third_tiny" "sts_risktable_tgap zero" 
"sts_risktable_lgap zero" "pie_explode medium")    
relsize("bar_groupgap 67pct" "dot_supgroupgap 67pct" "box_gap 33pct" 
"box_supgroupgap 200pct" "box_outergap 20pct" "box_fence 67pct")   
symbolsi("smallsymbol small" "histogram medlarge" "ci medium" "ci2 medium" 
"matrix medium" "refmarker medlarge" "parrowbarb zero")    
color("tick gs12" "grid gs12" "major_grid gs12" "minor_grid gs12" 
"matrix navy" "matrixmarkline navy" "histback gold" "clegend white" 
"clegend_line black" "pboxlabelfill bluishgray" "plabelfill bluishgray")    
linepattern("foreground solid" "grid solid" 
"major_grid solid" "minor_grid dot" "text_option solid")    
linesty("textbox foreground" "grid grid" "major_grid major_grid" 
"minor_grid minor_grid" "legend legend")  
linewidth("p medium" "foreground thin" "background thin" "grid thin" 
"major_grid thin" "minor_grid thin" "tick thin" "minortick thin" 
"ci_area medium" "ci2_area medium" "histogram medium" "refmarker medium" 
"matrixmark medium" "dots vvthin" "dot_area medium" "dotmark thin" 
"plotregion thin" "legend thin" "clegend thin" "pie medium" "sunflower medium" 
"text_option thin" "pbar vvvthin") 
textboxsty("note small_body" "leg_caption body")  
axissty("horizontal_default horizontal_withgrid" 
"vertical_default vertical_withgrid" "bar_super horizontal_nolinetick" 
"dot_super horizontal_nolinetick" "bar_scale_horiz horizontal_withgrid" 
"bar_scale_vert vertical_withgrid" "box_scale_horiz horizontal_withgrid" 
"box_scale_vert vertical_withgrid") 
clockdir("caption_position 7" "legend_position 6" "by_legend_position 6" 
"p 3" "legend_caption_position 7")    
gridringsty("caption_ring 5" "legend_caption_ring 5")   
anglesty("vertical_tick horizontal")   
yesno("extend_axes_high yes" "grid_draw_min yes" "grid_draw_max yes"
"draw_major_grid yes" "caption_span no") 
barlabelsty("bar none");

// 2. create scheme file (using theme)
brewscheme, schemename(matthiasg) themefile(matthiasg) allstyle(ggplot2) 
allcolors(5) allsaturation(75);


// 3. Example  
sysuse auto.dta, clear;

format %12,0gc price;
format %12,0gc weight;

/* 
Unless you're planning on hand coding a lot of graphs, I would personally 
avoid setting the scheme globally
set scheme custom

And pass the scheme as an argument to the graph command */
twoway (fpfitci price weight) 
(scatter price weight if rep78==1, sort) 
(scatter price weight if rep78==2, sort) 
(scatter price weight if rep78==3, sort) 
(scatter price weight if rep78==4, sort) 
(scatter price weight if rep78==5, sort), title("Example Graph") 
legend(order(3 "1978 Repair Record = 1" 4 "1978 Repair Record = 2" 
5 "1978 Repair Record = 3" 6 "1978 Repair Record = 4" 
7 "1978 Repair Record = 5" 1 "Confidence Interval")) scheme(matthiasg);
