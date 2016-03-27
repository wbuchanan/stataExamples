adopath ++ ~/Desktop/Programs/StataPrograms/d/d3
mata: mata clear 
mata: mata mlib index
run ~/Desktop/Programs/Java/Stata/jsonio.ado
run colorScale.mata
run d3axes.mata
run d3cross.mata
run d3data.mata
run d3margins.mata
run d3scatterTip.mata
run d3splomExtents.mata
run d3xyBrush.mata
run splomplot.mata
run vectorToScalar.mata
run d3splom.mata
run d3splom.ado 
d3splom using /Applications/Stata/ado/base/a/auto.dta, out("`c(pwd)'/splomExample/") file("auto.json") vln("varnames") style("/Users/billy/Desktop/Programs/StataPrograms/d/d3/examples/splomExample/splom.css") om("make, foreign rep78") pal("category10") col("obj_function(d) { return d[rep78]; }")