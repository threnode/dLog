

#template variables
Template.datetoday.helpers 
	today: moment().format "dddd, MMMM Do YYYY"

#template variables
Template.dateyesterday.helpers 
	yesterday: (moment().subtract "days", 1).format "dddd, MMMM Do YYYY"

Template.dateselect.helpers 
	defaultdate: (moment().subtract "days", 2).format "YYYY-MM-DD"

Template.datedata.datechoice = 
	-> (Session.get 'newdataForm').datechoice

Template.dateselect.events =
	#meta dropdown selection
	'blur #dateselector' : (event) ->
		console.log event.target.value
		($ '#' +  event.target.id).attr 'value', event.target.value
		console.log moment(event.target.value).format 'X'
		NewDLog.datedata = moment(event.target.value).format 'X'