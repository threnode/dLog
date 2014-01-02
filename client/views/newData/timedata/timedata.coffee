Template.timedata.timechoice = 
	-> (Session.get 'newdataForm').timechoice

Template.timedata.rendered = ->
	$('#timepicker1, #timepicker2').timepicker()