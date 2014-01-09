

#get the total duration in minutes between two different times
getTimeDifference = (str, end) ->
	difference = moment.utc(moment(end, "HH:mm").diff(moment(str, "HH:mm"))).format "HH:mm"
	difference = difference.split ':'
	(+difference[0]) * 60 + (+difference[1]) + ''


Template.time_and_date.rendered = ->
	$("#srttime, #endtime").timepicker({showMeridian: false, defaultTime: "9:00"}).on "changeTime.timepicker", (e) ->
  		newDataFormState[e.target.id] = e.time.value
  		if (e.target.id is 'srttime') and ((newDataFormState.endtime is null) or (newDataFormState.endtime < e.time.value))
  			$('#endtime').timepicker 'setTime', e.time.value
  		if (e.target.id is 'endtime') and ((newDataFormState.srttime is null) or (newDataFormState.srttime > e.time.value))
  			$('#srttime').timepicker 'setTime', e.time.value  
  		newDataFormState.length = getTimeDifference newDataFormState.srttime, newDataFormState.endtime 
  		newDataFormState.duration = newDataFormState.length + ' mins'
  		#need to find another way to set - this breaks the time select
  		Session.set 'newdataForm', newDataFormState


Template.time_and_date.helpers
	timechoiceIsDuration: -> ((Session.get 'newdataForm').timechoice) is 'length'
	timechoiceIsActual: -> ((Session.get 'newdataForm').timechoice) is 'actual'
	timechoiceIsSimple: -> ((Session.get 'newdataForm').timechoice) is'simple'
	datechoiceIsSelectDate: -> ((Session.get 'newdataForm').datechoice) is 'selectdate'
	defaultdate: -> helpers.formatdate 'default', 2
	date: -> 
		switch (Session.get 'newdataForm').datechoice
			when 'today' then helpers.formatdate 'verbose', 1
			when 'yesterday' then helpers.formatdate 'verbose'

resetDefaults = ->
	newDataFormState.duration = '0 mins'


Template.time_and_date.events =
	#date time type buttons
	#Date options: quick today/yesterday for dates
	#Time options: length/actual or no time log
	'click .timedate-btn' : (event) ->
		resetDefaults()
		newDataFormState[event.target.dataset.type] = event.target.dataset.selection
		Session.set 'newdataForm', newDataFormState


	#meta dropdown selection
	'blur #dateselector, keypress #dateselector, click #dateselector' : (event) ->
		newdate = event.target.value
		($ '#' +  event.target.id).attr 'value', newdate
		newDataFormState.selecteddate = newdate
		Session.set 'newdataForm', newDataFormState

	'keyup #total-length, blur #total-length, mouseup #total-length' : (event) ->
		newDataFormState.duration = (event.target.value ? '0') + ' mins'
		Session.set 'newdataForm', newDataFormState



		

