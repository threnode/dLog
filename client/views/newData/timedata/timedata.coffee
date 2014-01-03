Template.timedata.timechoice = 
	-> (Session.get 'newdataForm').timechoice

Template.timedata.rendered = ->
	#$('#strtime, #endtime').timepicker()
	$("#strtime, #endtime").timepicker({showMeridian: false, defaultTime: "9:00"}).on "changeTime.timepicker", (e) ->
  		NewDLog.timedata[e.target.id] = e.time.value
  		if (e.target.id is 'strtime') and ((NewDLog.timedata.endtime is null) or (NewDLog.timedata.endtime < e.time.value))
  			$('#endtime').timepicker 'setTime', e.time.value
  		if (e.target.id is 'endtime') and ((NewDLog.timedata.strtime is null) or (NewDLog.timedata.strtime > e.time.value))
  			$('#strtime').timepicker 'setTime', e.time.value  
  		




Template.timelength.events =
	#meta dropdown selection
	'blur #total-length' : (event) ->
		NewDLog.timedata.length = event.target.value

