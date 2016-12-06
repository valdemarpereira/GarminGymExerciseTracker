using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.System as Sys;
using Toybox.Timer as Timer;

var delta = 1;

class GarminGymExerciseTrackerView extends Ui.View {
	var timer1;
	var requestUIUpdate = false;

	hidden var medFontHeight = Gfx.getFontHeight(Gfx.FONT_MEDIUM);
    hidden var largeFontHeight = Gfx.getFontHeight(Gfx.FONT_LARGE);
    hidden var smallFontHeight =  Gfx.getFontHeight(Gfx.FONT_SMALL);
    hidden var tinyFontHeight =  Gfx.getFontHeight(Gfx.FONT_SYSTEM_TINY);
    hidden var xtinyFontHeight = Gfx.getFontHeight(Gfx.FONT_SYSTEM_XTINY);
    
    hidden var selectedIndex;
    hidden var selectedCategories;
    
    //Track selected Categories and current Cat
    hidden var trackCategories = [];
	hidden var trackSelectedIndex = [];
    
    hidden var itemsToDisplay = 3;
	
	var bench = [ new Categorie("Dumbbell Bench Press", null, "b1"),
                 new Categorie("Incline Dumbbell Bench Press", null, "b2")];
                 
	var dumbbells = [ new Categorie("Hammer curls", null, "d1"),
                 new Categorie("Preacher Curls", null, "d2"),
                 new Categorie("Concentration Curls", null, "d4"),
                 new Categorie("Cross Body Hammer Curl", null, "d3")];
                 
    var barbell = [ new Categorie("Deadlift", null, "b1"),
                 new Categorie("Squat", null, "b2"),
                 new Categorie("Finger Curls", null, "b3"),
                 new Categorie("Deadrows", null, "b4")];
                 
    var cable = [ new Categorie("Hammer curls", null, "c1"),
                 new Categorie("Cable Cross", null, "c2"),
                 new Categorie("Low Cable Crossover", null, "c3"),
                 new Categorie("Triceps Pushdown - Rope", null, "c4"),
                 new Categorie("Seated Cable Rows", null, "c5"),
                 new Categorie("External Rotation", null, "c6"),
                 new Categorie("Front Cable Raise", null, "c7"),
                 new Categorie("Triceps Overhead Extension with Rope", null, "c8"),
                 new Categorie("Wide-Grip Lat Pulldown", null, "c9"),
                 new Categorie("Standing Biceps Cable Curl", null, "c10"),
                 new Categorie("Standing Cable Wood Chop", null, "c11")];

	var top = [ new Categorie("Dumbbells", dumbbells, null),
                 new Categorie("Bench", bench, null),
                 new Categorie("Cable Machine", cable, null),
                 new Categorie("Barbell", barbell, null)];
        	
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        selectedIndex = 0;
        selectedCategories = top;
        timer1 = new Timer.Timer();
        timer1.start(method(:callback), 50, true);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	requestUIUpdate = false;
   
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
    	if(isCategory(-1)){
			dc.drawText(dc.getWidth() / 2, dc.getHeight() / 6 - (medFontHeight / 2), Gfx.FONT_MEDIUM, getItemDisplayText(-1), Gfx.TEXT_JUSTIFY_CENTER);	
		} else {
			dc.drawText(dc.getWidth() / 2, (dc.getHeight() / 9) - (smallFontHeight / 2), Gfx.FONT_SMALL, getItemDisplayText(-1), Gfx.TEXT_JUSTIFY_CENTER);
        	dc.drawText(dc.getWidth() / 2, 5 * dc.getHeight() / 18 - (xtinyFontHeight/2), Gfx.FONT_SYSTEM_XTINY, getLastWorkoutDetails(-1), Gfx.TEXT_JUSTIFY_CENTER);
        }
    }

	function drawMiddleItem(dc) {
	
		if(isCategory(0)){
			dc.drawText(dc.getWidth() / 2, 3 * dc.getHeight() / 6 - (largeFontHeight / 2), Gfx.FONT_LARGE, getItemDisplayText(0), Gfx.TEXT_JUSTIFY_CENTER);	
		} else {
			var text = getItemDisplayText(0);
			
			var size = dc.getTextWidthInPixels(text, Gfx.FONT_LARGE);
    		if(size > dc.getWidth()) {
    			animateText(dc, text);
			} else {
				dc.drawText(dc.getWidth() / 2, 4 * dc.getHeight() / 9 - (largeFontHeight / 2), Gfx.FONT_LARGE, text, Gfx.TEXT_JUSTIFY_CENTER);
			}  
			
        	dc.drawText(dc.getWidth() / 2, 11 * dc.getHeight() / 18 - (smallFontHeight/2), Gfx.FONT_SYSTEM_TINY, getLastWorkoutDetails(0), Gfx.TEXT_JUSTIFY_CENTER);
        }
	}
    
    function animateText(dc, text) {
    	requestUIUpdate = true;
    	var size = dc.getTextWidthInPixels(text, Gfx.FONT_LARGE);
    	var width = dc.getWidth();
    	
    	var extra = size - width;
    	
    	var x = -extra / 2;
    	
    	dc.drawText(x + calculateDeltaAnimation(extra), 4 * dc.getHeight() / 9 - (largeFontHeight / 2), Gfx.FONT_LARGE, text, Gfx.TEXT_JUSTIFY_LEFT);
    }
    
    enum {
    	LEFT,
    	RIGHT
    }
    
    var direction = LEFT;
    var extraPadding = 5;
    
    function calculateDeltaAnimation(extra){
    	if(direction == LEFT){    	
    		delta -=3;
    	} else if (direction == RIGHT){    	
    		delta += 3;
    	}
    	
    	if(delta >= (extra  / 2) + extraPadding && direction == RIGHT) {
    		direction = LEFT;
    	} else if(direction == LEFT && delta <= (extra / -2) - extraPadding) {
    		direction = RIGHT;
    	}
    	return delta;
    }
    
    function callback() {
        if(requestUIUpdate) {
        	Ui.requestUpdate();
        }
    }
    
    
    function drawBottomItem(dc){
    	if(isCategory(1)){
			dc.drawText(dc.getWidth() / 2, 5 * dc.getHeight() / 6 - (medFontHeight / 2), Gfx.FONT_MEDIUM, getItemDisplayText(1), Gfx.TEXT_JUSTIFY_CENTER);	
		} else {
			dc.drawText(dc.getWidth() / 2, 7 * dc.getHeight() / 9 - (smallFontHeight / 2), Gfx.FONT_SMALL, getItemDisplayText(1), Gfx.TEXT_JUSTIFY_CENTER);
        	dc.drawText(dc.getWidth() / 2, 17 * dc.getHeight() / 18 - (xtinyFontHeight/2), Gfx.FONT_SYSTEM_XTINY, getLastWorkoutDetails(1), Gfx.TEXT_JUSTIFY_CENTER);
        }
    }
    
    function isCategory(selectedItemOffset){
    	var indexCat = selectedIndex + selectedItemOffset;
		
		if(indexCat < 0 ){
			indexCat = selectedCategories.size() - 1;
		}
		
		if(indexCat >= selectedCategories.size()){
			indexCat = 0;
		}
			
		return selectedCategories[indexCat].subCat != null;
    }
    function getItemDisplayText(selectedItemOffset) {
    	
		var indexCat = selectedIndex + selectedItemOffset;
		
		if(indexCat < 0 ){
			indexCat = selectedCategories.size() - 1;
		}
		
		if(indexCat >= selectedCategories.size()){
			indexCat = 0;
		}
			
		return selectedCategories[indexCat].catName + (selectedCategories[indexCat].subCat != null ? " >" : "");
    }
    
    function getLastWorkoutDetails(selectedItemOffset) {
    	var indexCat = selectedIndex + selectedItemOffset;
		
		if(indexCat < 0 ){
			indexCat = selectedCategories.size() - 1;
		}
		
		if(indexCat >= selectedCategories.size()){
			indexCat = 0;
		}
		
		return getRecordedExerciseValue(selectedCategories[indexCat].id)	;
    }
    
    function getRecordedExerciseValue(catId){
	
		var val = "";
		if(catId != null) {
					
			var weight = App.getApp().getProperty("W_" + catId);
			var sets = App.getApp().getProperty("S_" + catId);
			var reps = App.getApp().getProperty("R_" + catId);
					
			if(weight != null){
		 		val = "Wt.: " + weight;
		 	}
		 	if(reps != null){
		 		val = val + " Reps: " + reps;
		 	}
		 	if(sets != null){
		 		val = val + " Sets: " + sets;
		 	}
		}
		
		if(val.length() == 0){
			val = "---";
		}
		
		return val;
	}
    
    // Decrement the currently selected option index
    function incIndex() {
        if (null != selectedIndex) {
            selectedIndex += 1;
            if (selectedIndex >= selectedCategories.size()) {
                selectedIndex = 0;
            }
        }
    }

    // Decrement the currently selected option index
    function decIndex() {
        if (null != selectedIndex) {
            selectedIndex -= 1;
            if (selectedIndex < 0) {
                selectedIndex = selectedCategories.size() - 1;
            }
        }
    }
    
    // Process the current attention action
    function action() {
    	if(selectedCategories[selectedIndex].subCat != null){
    		trackCategories.add(selectedCategories);
    		trackSelectedIndex.add(selectedIndex);
    		selectedCategories = selectedCategories[selectedIndex].subCat;
    		selectedIndex = 0;
    	} else {
    		Ui.pushView(new RecordExercisePickerView(selectedCategories[selectedIndex].id), new RecordExercisePickerDelegate(selectedCategories[selectedIndex].id), Ui.SLIDE_IMMEDIATE);
    	}
    }
    
    function back(){
    	if(trackCategories.size() == 0){
    		// exit
    		return;
    	}
    	
    	selectedCategories = trackCategories[trackCategories.size() - 1];
    	trackCategories.remove(selectedCategories);
    	
    	selectedIndex = trackSelectedIndex[trackSelectedIndex.size() - 1];
    	trackSelectedIndex.remove(selectedIndex);
    }
    
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
}
