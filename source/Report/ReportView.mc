import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Application.Storage;
import Toybox.Position;

enum ReportType {
    ALL = "ALL",
    HOME = "HOME",
    AWAY = "AWAY",
}

class ReportView extends WatchUi.View {
    var _records = [] as Array<Dictionary<String, String>>;
    private var _homeString as String;
    private var _awayString as String;
    var _reportType = $.ALL;

    function initialize(records as Array<Dictionary<String, String>>) {
        View.initialize();
        _records = records;
        
        _homeString = $.homeString;
        _awayString = $.awayString;
    }
    
    function getReportType(reportType as ReportType) as String {
        return reportType.toString();
    }
    
    function setReportType(reportType as ReportType) as Void {
        _reportType = reportType;
        WatchUi.requestUpdate();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.ReportLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        updateLabel("id_label", getInfo());
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    private function updateLabel(labelId as String, labelText as String) as Void {
        var drawable = View.findDrawableById(labelId);
        if (drawable != null) {
            (drawable as Text).setText(labelText);
        }
    }

    function getInfo() as String {
        var start_time = "";
        var stop_time = "";
        var home_goal = "";
        var away_goal = "";
        var home_goals = 0;
        var away_goals = 0;

        var match_info = "";
        var total_info = "";

        for (var i = 0; i < _records.size(); i++) {
            var record = _records[i] as Dictionary<String, String>;
            if (record.hasKey("start_time")) {
                var value = record.get("start_time");
                var index = value.find(" ");
                start_time = value.substring(index+1, null);
            } else if (record.hasKey("stop_time")) {
                var value = record.get("stop_time");
                var index = value.find(" ");
                stop_time = value.substring(index+1, null);
            } else if (record.hasKey("home_goal")) {
                if (_reportType.equals($.ALL.toString()) || _reportType.equals($.HOME.toString()) ) {
                    var value = record.get("home_goal");
                    var index = value.find(" ");
                    home_goal = value.substring(index+1, null);
                    
                    match_info += home_goal + " " + _homeString + "\n";
                }
                home_goals += 1;
            } else if (record.hasKey("away_goal")) {
                if (_reportType.equals($.ALL.toString()) || _reportType.equals($.AWAY.toString()) ) {
                    var value = record.get("away_goal");
                    var index = value.find(" ");
                    away_goal = value.substring(index+1, null);
                    
                    match_info += away_goal + " " + _awayString + "\n";
                }
                away_goals += 1;
            }
        }

        total_info += start_time + "-" + stop_time + "\n";
        total_info += home_goals + "-" + away_goals + "\n\n" + match_info;

        return total_info;
    }
}
