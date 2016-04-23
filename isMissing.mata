// Begin Mata session
mata:

// Gets a matrix of binary indicators indicating locations of missing values
real matrix isMissing(transmorphic matrix values) {

	// Matrix containing the returned results
	real matrix m

	// Scalars used if needing to iterate over the data
	real scalar i, j

	// If no missing values are found return a single element matrix
	if (missing(values) == 0) m = (0)

	// Otherwise
	else {

		// Create a matrix of the same dimensions as the data
		m = J(rows(values), cols(values), .)

		// Loop over observations
		for(i = 1; i <= rows(values); i++) {

			// Loop over variables
			for(j = 1; j <= cols(values); j++) {

				// Set elements indicating whether or not there are missing data
				m[i, j] = missing(values[i, j])

			} // End Loop over variables

		} // End Loop over records

	} // End ELSE Block

	// Return the matrix
	return(m)

} // End Function definition

// End Mata interpreter
end


