using Toybox.WatchUi as Ui;

class GarminGymExerciseTrackerView extends Ui.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.clear();
        
        // Draw selected box
        dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.fillRectangle(0, dc.getHeight() / itemsToDisplay, dc.getWidth(), dc.getHeight() / itemsToDisplay);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);

        // Draw frames
        dc.drawLine(0, dc.getHeight() / itemsToDisplay, dc.getWidth(), dc.getHeight() / itemsToDisplay);
        dc.drawLine(0, 2 * dc.getHeight() / itemsToDisplay, dc.getWidth(), 2 * dc.getHeight() / itemsToDisplay);
        
        
        
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
