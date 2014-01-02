

#template variables
Template.datetoday.helpers 
	today: moment().format "dddd, MMMM Do YYYY"

#template variables
Template.dateyesterday.helpers 
	yesterday: (moment().subtract "days", 1).format "dddd, MMMM Do YYYY"

Template.dateselect.helpers 
	defaultdate: '2013-01-08'

Template.datedata.datechoice = 
	-> (Session.get 'newdataForm').datechoice

