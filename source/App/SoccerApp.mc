import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Application.Storage;
import Toybox.Position;

var match_dates = [] as Array<String>;
var global_records = [] as Array<Dictionary<String, String>>;

class SoccerApp extends Application.AppBase {
    var _soccerView as SoccerView?;

    function initialize() {
        AppBase.initialize();
    }


    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
        var value = Storage.getValue("match_dates");
        if (value != null) {
            match_dates = value;
        }
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        if (_soccerView != null) {

            _soccerView.stopRecording();
        }
        Position.enableLocationEvents(Position.LOCATION_DISABLE, method(:onPosition));
    }


    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
         _soccerView = new SoccerView();
        return [ _soccerView, new SoccerDelegate(_soccerView) ];
  
    }

    public function onPosition(info as Info) as Void {
    }

}

function getApp() as SoccerApp {
    return Application.getApp() as SoccerApp;
}

function recordsInformation() as String {
    var result = "";
    for (var i = 0; i < $.global_records.size(); i++) {
        var record = $.global_records[i] as Dictionary<String, String>;
        var keys = record.keys(); 
        result += keys[0] + ": " + record.get(keys[0]) + "\n";
        
    }
    return result;
}

function persistentData() as Void {
    Storage.setValue("match_dates", $.match_dates);
    Storage.setValue($.match_dates[$.match_dates.size()-1], $.global_records);
}

function defaultData() as Void {
    Storage.clearValues();
}