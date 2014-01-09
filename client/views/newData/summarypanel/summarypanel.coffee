

Template.summarypanel.helpers
	isActual: -> (Session.get 'newdataForm').timechoice is 'actual'
	hasDuration: -> (Session.get 'newdataForm').timechoice isnt 'simple'
	duration: -> (Session.get 'newdataForm').duration
	timechoice: -> (Session.get 'newdataForm').timechoice
	verbosedate: -> getDate 'verbose'
	shortdate: -> getDate 'short'
	srttime: -> (Session.get 'newdataForm').srttime
	endtime: -> (Session.get 'newdataForm').endtime
	category: -> (Session.get 'newdataForm').category
	activity: -> (Session.get 'newdataForm').activity
	hasCategory: -> true if ((Session.get 'newdataForm').category)?
	hasActivity: -> true if ((Session.get 'newdataForm').activity)?

getDate = (format) ->
	options = {'today': false, 'yesterday' : 1, 'selectdate' : 2}	
	datechoice = newDataFormState.datechoice
	if newDataFormState.datechoice is 'selectdate'
		newdate = newDataFormState.selecteddate
		subtractdate = false
	else 
		subtractdate = options[datechoice]
	helpers.formatdate format, subtractdate, newdate

