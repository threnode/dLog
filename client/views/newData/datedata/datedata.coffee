


Template.datedata.helpers
	datechoice: -> (Session.get 'newdataForm').datechoice
	defaultdate: (moment().subtract "days", 2).format "YYYY-MM-DD"
	yesterday: (moment().subtract "days", 1).format "dddd, MMMM Do YYYY"
	today: moment().format "dddd, MMMM Do YYYY"

Template.datedata.events =
	#meta dropdown selection
	'blur #dateselector' : (event) ->
		console.log event.target.value
		($ '#' +  event.target.id).attr 'value', event.target.value
		console.log moment(event.target.value).format 'X'
		NewDLog.datedata = moment(event.target.value).format 'X'