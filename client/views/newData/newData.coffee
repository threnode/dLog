
#general page set-up
Template.newData.rendered = ->
	($ ".date-btn").button
	($ ".dropdown-toggle").dropdown()


@NewDLog =
	logInfo :
		user: null
		inputTime: null
		inputLocation:
			exists: false
			latitude: null
			longitude: null
	timedata:
		timetype: 'length'
		length: null
		strtime: null
		endtime: null
	datedata: null
	metadata:
		category: null
		activity: null

@getLocation = ->
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition showPosition
  else
    console.log "Geolocation is not supported by this browser"
showPosition = (position) ->
  NewDLog.logInfo.inputLocation.latitude = position.coords.latitude
  NewDLog.logInfo.inputLocation.longitude = position.coords.longitude
  NewDLog.logInfo.inputLocation.exists = true

@newDataFormState =
	metacat: 'Select a catagory'
	metaact: 'Select an activity'
	activity: 'disabled'
	timechoice: 
		duration: 1
		actual: 0
		simple: 0
	datechoice : 
		today: 1
		yesterday: 0
		selectdate: 0
	setup: true

Session.set 'newdataForm', newDataFormState


getTimeDifference = (str, end) ->
	difference = moment.utc(moment(end, "HH:mm").diff(moment(str, "HH:mm"))).format "HH:mm"
	difference = difference.split ':'
	(+difference[0]) * 60 + (+difference[1]) + ''
# var now  = "04/09/2013 15:00:00";
# var then = "04/09/2013 14:20:30";

	
settozero = (value, key) ->
	newDataFormState[event.target.dataset.type][key] = 0


#event handler
Template.newData.events =
	#date selecction types
	'click .timedate-btn' : (event) ->
		_.each newDataFormState[event.target.dataset.type],  settozero
		newDataFormState[event.target.dataset.type][event.target.dataset.selection] = 1
		Session.set 'newdataForm', newDataFormState
		(NewDLog.timedata.timetype =  event.target.dataset.selection) if event.target.dataset.type is 'timechoice'
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


	
  
