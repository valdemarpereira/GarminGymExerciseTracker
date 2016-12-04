using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;

class GarminGymExerciseTrackerView extends Ui.View {

	hidden var medFontHeight = Gfx.getFontHeight(Gfx.FONT_MEDIUM);
    hidden var largeFontHeight = Gfx.getFontHeight(Gfx.FONT_LARGE);
    hidden var smallFontHeight =  Gfx.getFontHeight(Gfx.FONT_SYSTEM_TINY);
    hidden var selectedIndex;
    hidden var selectedCategories;
    
    //Track selected Categories and current Cat
    hidden var trackCategories = [];
	hidden var trackSelectedIndex = [];
    
    hidden var itemsToDisplay = 3;
	
	var cats23 = [ new Categorie("Cat 321", null, "23_1"),
                 new Categorie("Cat 322", null, "23_2"),
                 new Categorie("Cat 323", null, "23_3"),
                 new Categorie("Cat 324", null, "23_4")];
                 

	var cats2 = [ new Categorie("Cat 21", null, "2_1"),
                 new Categorie("Cat 22", null, "2_2"),
                 new Categorie("Cat 23", cats23, null),
                 new Categorie("Cat 24", null, "2_3")];
                 

	var top = [ new Categorie("Cat 1", null, "t_1"),
                 new Categorie("Cat 2", cats2, null),
                 new Categorie("Cat 3", null, "t_3"),
                 new Categorie("Cat 4", null, "t_4"),
                 new Categorie("Cat 5", null, "t_5"),
                 new Categorie("Cat 6", null, "t_6")];
        	
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        selectedIndex = 0;
        selectedCategories = top;
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
        dc.drawText(dc.getWidth() / 2, 5 * dc.getHeight() / 18 - (smallFontHeight/2), Gfx.FONT_SYSTEM_TINY, getLastWorkoutDetails(-1), Gfx.TEXT_JUSTIFY_CENTER);
    }

	function drawMiddleItem(dc) {
		dc.drawText(dc.getWidth() / 2, 4 * dc.getHeight() / 9 - (largeFontHeight / 2), Gfx.FONT_LARGE, getItemDisplayText(0), Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, 11 * dc.getHeight() / 18 - (smallFontHeight/2), Gfx.FONT_SYSTEM_TINY, getLastWorkoutDetails(0), Gfx.TEXT_JUSTIFY_CENTER);
	}
    
    function drawBottomItem(dc){
    	dc.drawText(dc.getWidth() / 2, 7 * dc.getHeight() / 9 - (medFontHeight / 2), Gfx.FONT_MEDIUM, getItemDisplayText(1), Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, 17 * dc.getHeight() / 18 - (smallFontHeight/2), Gfx.FONT_SYSTEM_TINY, getLastWorkoutDetails(1), Gfx.TEXT_JUSTIFY_CENTER);
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
		 	if(sets != null){
		 		val = val + " Sets: " + sets;
		 	}
		 	if(reps != null){
		 		val = val + " Reps: " + reps;
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
    		Ui.pushView(new RecordExercisePickerView(), new RecordExercisePickerDelegate(selectedCategories[selectedIndex].id), Ui.SLIDE_IMMEDIATE);
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
