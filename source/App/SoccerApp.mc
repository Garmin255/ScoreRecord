import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Application.Storage;
import Toybox.Position;
import Toybox.Attention;

var match_datas = [] as Array<String>;
var match_records = [] as Array<Dictionary<String, String>>;

enum {
    HOME_AWAY,
    TEAM1_TEAM2,
    SCHOOL_STAND,
}

var teamIndex = $.HOME_AWAY;

class SoccerApp extends Application.AppBase {
    var _soccerView as SoccerView?;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
        var value = Storage.getValue("match_datas");
        if (value != null) {
            match_datas = value;
        }
        value =  Storage.getValue("team_index");
        if (value != null) {
            teamIndex = value;
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
    for (var i = 0; i < $.match_records.size(); i++) {
        var record = $.match_records[i] as Dictionary<String, String>;
        var keys = record.keys(); 
        result += keys[0] + ": " + record.get(keys[0]) + "\n";
        
    }
    return result;
}

function persistentData() as Void {
    Storage.setValue("match_datas", $.match_datas);
    if ($.match_datas.size() > 0) {
        Storage.setValue($.match_datas[$.match_datas.size()-1], $.match_records);
    }
}

function resetData() as Void {
    Storage.clearValues();
}

function removeLastMatchData() as Void {
    if ($.match_datas.size() > 0) {
        var last_data = $.match_datas[$.match_datas.size() - 1];
        Storage.deleteValue(last_data);
        $.match_datas.remove(last_data);
    }
}

function playVibate() as Void {
    if (Attention has :vibrate) {
        var vibrateData = [
                new Attention.VibeProfile(25, 100),
                new Attention.VibeProfile(50, 100),
                new Attention.VibeProfile(75, 100),
                new Attention.VibeProfile(100, 100),
                new Attention.VibeProfile(75, 100),
                new Attention.VibeProfile(50, 100),
                new Attention.VibeProfile(25, 100)
                ];

        Attention.vibrate(vibrateData);
    }
}