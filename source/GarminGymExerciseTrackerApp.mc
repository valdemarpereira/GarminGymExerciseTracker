using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class GarminGymExerciseTrackerApp extends App.AppBase {
	var mainView;
	var viewDelegate;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
    	mainView = new GarminGymExerciseTrackerView();
    	viewDelegate = new GarminGymExerciseTrackerDelegate();
        return [ mainView, viewDelegate ];
    }

}
