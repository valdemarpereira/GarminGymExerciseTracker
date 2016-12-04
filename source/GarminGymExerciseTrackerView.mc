using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class GarminGymExerciseTrackerView extends Ui.View {

	hidden var medFontHeight = Gfx.getFontHeight(Gfx.FONT_MEDIUM);
    hidden var largeFontHeight = Gfx.getFontHeight(Gfx.FONT_LARGE);
    hidden var smallFontHeight =  Gfx.getFontHeight(Gfx.FONT_SMALL);
    
    hidden var itemsToDisplay = 3;
        	
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
        
        // Draw text
        drawTopItem(dc);
        drawMiddleItem(dc);
        drawBottomItem(dc);
    }
    
    function drawTopItem(dc){
    	dc.drawText(dc.getWidth() / 2, (dc.getHeight() / 9) - (medFontHeight / 2), Gfx.FONT_MEDIUM, getItemDisplayText(-1), Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, 5 * dc.getHeight() / 18 - (smallFontHeight/2), Gfx.FONT_SMALL, getLastWorkoutDetails(-1), Gfx.TEXT_JUSTIFY_CENTER);
    }

	function drawMiddleItem(dc) {
		dc.drawText(dc.getWidth() / 2, 4 * dc.getHeight() / 9 - (largeFontHeight / 2), Gfx.FONT_LARGE, getItemDisplayText(0), Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, 11 * dc.getHeight() / 18 - (smallFontHeight/2), Gfx.FONT_SMALL, getLastWorkoutDetails(0), Gfx.TEXT_JUSTIFY_CENTER);
	}
    
    function drawBottomItem(dc){
    	dc.drawText(dc.getWidth() / 2, 7 * dc.getHeight() / 9 - (medFontHeight / 2), Gfx.FONT_MEDIUM, getItemDisplayText(1), Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, 17 * dc.getHeight() / 18 - (smallFontHeight/2), Gfx.FONT_SMALL, getLastWorkoutDetails(1), Gfx.TEXT_JUSTIFY_CENTER);
    }
    
    function getItemDisplayText(selectedItemOffset) {
    	return "TEXT";
    }
    
    function getLastWorkoutDetails(selectedItemOffset) {
    	return "WorkoutDisplay";
    }
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
