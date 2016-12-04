using Toybox.WatchUi as Ui;

class GarminGymExerciseTrackerDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new GarminGymExerciseTrackerMenuDelegate(), Ui.SLIDE_UP);
        return true;
    }

}