using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class RecordExercisePickerView extends Ui.Picker {
	 
    function initialize() {            
        var title = new Ui.Text({:text=>"Record Exercise", :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});
        var separator = new Ui.Text({:text=>"-", :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_CENTER, :color=>Gfx.COLOR_WHITE});
        Picker.initialize({:title=>title, :pattern=>[new NumberFactory(1,150,0.5, "%.1f", "Kg"), separator, new NumberFactory(1,50,1, "", "Reps"), separator, new NumberFactory(1,50,1,"", "Sets")]});
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
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
    
    	// TODO: Store Values
		
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }
}