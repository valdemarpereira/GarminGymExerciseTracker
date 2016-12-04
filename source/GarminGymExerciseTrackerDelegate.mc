using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class GarminGymExerciseTrackerDelegate extends Ui.BehaviorDelegate {

	// Handle key  events
    function onKey(evt) {
        var app = App.getApp();
        var key = evt.getKey();
        if (Ui.KEY_DOWN == key) {
            app.mainView.incIndex();
        } else if (Ui.KEY_UP == key) {
            app.mainView.decIndex();
        } else if (Ui.KEY_ENTER == key) {
            app.mainView.action();
        } else if (Ui.KEY_START == key) {
            app.mainView.action();
        } else if (Ui.KEY_ESC == key) {
            app.mainView.back();
        }else {
            return false;
        }
        Ui.requestUpdate();
        return true;
    }
    
    
    function initialize() {
        BehaviorDelegate.initialize();
    }

}