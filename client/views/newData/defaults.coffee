#date formats via moment
@dateformats =
	verbose: "dddd, MMMM Do YYYY"
	short: "MM-DD-YYYY"
	default: "YYYY-MM-DD"
	timestamp: 'X'

#object model for Metadata collection
@NewMetaData =
	label: null
	children: []
	weight: null
	created: null
	lastupdated: null

#object model for Activity collection
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


#New Log form state tracking and defaults
@newDataFormState =
	duration: '0 mins'
	timechoice: 'length'
	datechoice: 'today'
	verbosedate: moment().format "dddd, MMMM Do YYYY"
	shortdate:  moment().format "MM-DD-YYYY"
	srttime: '09:00'
	endtime: '09:00'
	CategoryDropdownText: 'Select a catagory'
	ActivityDropdownText: 'Select an activity'
	ActivityDropdownDisabled: true
	setup: true

@newDataFormStateDefaults = _.clone newDataFormState


#set defaults
Session.set 'newdataForm', newDataFormState