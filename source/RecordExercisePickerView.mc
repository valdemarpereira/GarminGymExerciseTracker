using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class RecordExercisePickerView extends Ui.Picker {
	 enum {
    	WEIGHT,
    	REPS,
    	SETS
    }
    
    function initialize(catId) {            
        var title = new Ui.Text({:text=>"Record Exercise", :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});
        var separator = new Ui.Text({:text=>"-", :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_CENTER, :color=>Gfx.COLOR_WHITE});
        Picker.initialize({:title=>title,:pattern=>[new NumberFactory(getRecordedData(WEIGHT, catId), 1, 150, 0.5, "%.1f", "Kg"), separator, new NumberFactory(getRecordedData(REPS, catId), 1,50,1, "", "Reps"), separator, new NumberFactory(getRecordedData(SETS, catId), 1,50,1,"", "Sets")]});
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
    
    function getRecordedData(type, catId) {
    	var value;
    	
    	if(type == WEIGHT) {
    		value = App.getApp().getProperty("W_" + catId);
    		return (value == null ? 0 : value.toFloat());
    	} else if(type == REPS){
    	    value = App.getApp().getProperty("R_" + catId);
    	} else {
    		value = App.getApp().getProperty("S_" + catId);
    	}
    	
    	return (value == null ? 0 : value.toNumber());
    }
    
}

class RecordExercisePickerDelegate extends Ui.PickerDelegate {
    
    hidden var mCatId = null;
    
    function initialize(catId){
    	 mCatId = catId;
    }
    
    function onCancel() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
    	var weight = values[0];
    	var reps = values[2];
    	var sets = values[4];

		App.getApp().setProperty("W_" + mCatId, weight);
		App.getApp().setProperty("R_" + mCatId, reps);
		App.getApp().setProperty("S_" + mCatId, sets);
		
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }
}