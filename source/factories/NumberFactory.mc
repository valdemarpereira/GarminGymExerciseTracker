using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Attention as Attention;

class NumberFactory extends Ui.PickerFactory {
	hidden var mCurrent;
    hidden var mStart;
    hidden var mStop;
    hidden var mIncrement;
    hidden var mPosfix;
    hidden var mFormat;

/*
    function getIndex(value) {
        var index = (value / mIncrement) - mStart;
        return index;
    }
*/
    function initialize(current, start, stop, increment, formatOpts ,posfix) {
    	
    	Sys.println(current);
        mCurrent = current;
        mStart = start;
        mStop = stop;
        mIncrement = increment;
        mPosfix = posfix;
        mFormat = formatOpts;
    }

    function getDrawable(index, selected) {    	
        return new Ui.Text( { :text=>getValue(index)+ "\n" + mPosfix, :color=>Gfx.COLOR_WHITE, :font=> Gfx.FONT_MEDIUM, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_CENTER } );
    }
	
    function getValue(index) {
    	var value = (mStart + (index * mIncrement));
    	
    	value += mCurrent - mStart;
    	
    	if(value > maxValue()){
			value = value - maxValue();
		}
    	
    	if(!"".equals(mFormat)){
        	value =  value.format(mFormat);
        }
    	return value;
    }

	function maxValue(){
		return (mStart + (getSize() * mIncrement));
	}
	
    function getSize() {
        return ( mStop - mStart ) / mIncrement + 1.00;
    }
}

