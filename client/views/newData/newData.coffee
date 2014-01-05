
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

#get the total duration in minutes between two different times
getTimeDifference = (str, end) ->
	difference = moment.utc(moment(end, "HH:mm").diff(moment(str, "HH:mm"))).format "HH:mm"
	difference = difference.split ':'
	(+difference[0]) * 60 + (+difference[1]) + ''


#set all values to 0 in a series of key value pairs	
settozero = (value, key) ->
	newDataFormState[event.target.dataset.type][key] = 0



#event handler
Template.newData.events =
	#date time type buttons
	#Date options: quick today/yesterday for dates
	#Time options: length/actual or no time log
	'click .timedate-btn' : (event) ->
		console.log event

		sectiontype = event.target.dataset.type #date ot time
		selectedoption = event.target.dataset.selection
		newDataFormState.newmetaSummary[sectiontype] = selectedoption
		_.each newDataFormState[sectiontype],  settozero
		newDataFormState[sectiontype][selectedoption] = 1
		Session.set 'newdataForm', newDataFormState
		#only need to track time as date is for quick today/yesterday selection hence no need to track
		(NewDLog.timedata.timetype =  selectedoption) if sectiontype is 'timechoice' 

	#Save log entry to collection	
	'click #save-log' : (event) ->
		NewDLog.logInfo.inputTime = moment().format 'X' 
		NewDLog.logInfo.user = Meteor.userId()
		getLocation()
		if NewDLog.datedata is null
			day = if newDataFormState.datechoice.today then (moment().format 'X') else ((moment().subtract "days", 1).format 'X')
			NewDLog.datedata = day
		if NewDLog.timedata.timetype is 'actual'
			NewDLog.timedata.length = getTimeDifference NewDLog.timedata.strtime, NewDLog.timedata.endtime
		console.log 'saved'
		console.log NewDLog


	
  
