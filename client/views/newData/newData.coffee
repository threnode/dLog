
settings =
	summarypanelID: '#new-data-summary-panel'






#HELPER FUNCTIONS

#get location - lat and long
@getLocation = ->
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition showPosition
  else
    console.log "Geolocation is not supported by this browser"
showPosition = (position) ->
  NewDLog.logInfo.inputLocation.latitude = position.coords.latitude
  NewDLog.logInfo.inputLocation.longitude = position.coords.longitude
  NewDLog.logInfo.inputLocation.exists = true




resetDefaults = (type) ->
	switch type
		when 'timechoice' then newDataFormState.newmetaSummary.duration = '0 mins'	
		when 'datechoice' then newDataFormState.newmetaSummary.selecteddate = helpers.formatdate 'default', 2
			

#event handler
Template.newData.events =
	

	#Save log entry to collection	
	'click #save-log' : (event) ->
		NewDLog.logInfo.inputTime = moment().format 'X' 
		NewDLog.logInfo.user = Meteor.userId()
		getLocation()
		if NewDLog.datedata is null
			day = if newDataFormState.datechoice.today then (moment().format 'X') else ((moment().subtract "days", 1).format 'X')
			NewDLog.datedata = day
		if NewDLog.timedata.timetype is 'actual'
			NewDLog.timedata.length = helpers.getTimeDifference NewDLog.timedata.strtime, NewDLog.timedata.endtime
		console.log 'saved'
		console.log NewDLog


	
  
