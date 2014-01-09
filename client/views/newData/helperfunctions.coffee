
#global helper functions

@helpers = {}

#use moment.js to format dates
#default formats are listed in the defaults.coffee file
#subtracted days takes a positive integer representing the number of days to subtract
#actual takes a date in the format 'yyyy-mm-dd'
helpers.formatdate = (format, subtractdays, actual, timestamp) ->
	if actual then (newdate = moment actual) else (newdate = moment())
	if subtractdays then newdate.subtract( "days", subtractdays)
	newdate.format dateformats[format]



