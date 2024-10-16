import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SoccerMenuDelegate extends WatchUi.MenuInputDelegate {
    private var _view as SoccerView;
    private var _recordsString as String;
    private var _resetString as String;
    private var _exitString as String;
    private var _startString as String;
    private var _stopString as String;
    private var _giveUpString as String;
    private var _homeString as String;
    private var _awayString as String;
    private var _noRecordsString as String;

    function initialize(view as SoccerView) {
        MenuInputDelegate.initialize();
        _view = view;
        _recordsString = WatchUi.loadResource($.Rez.Strings.Records) as String;
        _resetString = WatchUi.loadResource($.Rez.Strings.Reset) as String;
        _exitString = WatchUi.loadResource($.Rez.Strings.Exit) as String;
        _startString = WatchUi.loadResource($.Rez.Strings.Start) as String;
        _stopString = WatchUi.loadResource($.Rez.Strings.Stop) as String;
        _giveUpString = WatchUi.loadResource($.Rez.Strings.GiveUp) as String;
        _homeString = WatchUi.loadResource($.Rez.Strings.Home) as String;
        _awayString = WatchUi.loadResource($.Rez.Strings.Away) as String;
        _noRecordsString = WatchUi.loadResource($.Rez.Strings.NoRecords) as String;
    }

    function onMenuItem(item as Symbol) as Void {
        var records = $.match_records;
        if (item == :item_continue) {
            System.println("Continue");
            if (_view.isSessionRecording()) {
                var lastRecord = records[records.size()-1];
                if (lastRecord.hasKey("stop_time")) {
                    records.remove(lastRecord);
                }
            }
        } else if (item == :item_save) {
            System.println("Save");
            if (_view.isSessionRecording()) {
                if (Attention has :playTone) {
                    Attention.playTone(Attention.TONE_STOP);
                }
                persistentData();
                playVibate();
                WatchUi.showToast(_stopString, { :icon => null });
                if (Toybox has :ActivityRecording) {
                    _view.stopRecording();
                }
                showReport();
            }
        } else if (item == :item_giveup) {
            if (_view.isSessionRecording()) {
                if (Attention has :playTone) {
                    Attention.playTone(Attention.TONE_RESET);
                }
                removeLastMatchData();
                persistentData();
                playVibate();
                WatchUi.showToast(_giveUpString, { :icon => null });
                if (Toybox has :ActivityRecording) {
                    _view.stopRecording();
                }
            }
        } else if (item == :item_records) {
            System.println("Records");
            var mainMenu = new WatchUi.Menu2({:title=>_recordsString});
            if ($.match_datas.size() > 0) {
                for (var i = 0; i < $.match_datas.size(); i++) {
                    var match_date = $.match_datas[i] as String;
                    mainMenu.addItem(new WatchUi.MenuItem(match_date, null, null, null));
                }
                WatchUi.pushView(mainMenu, new $.RecordsMenu2Delegate(), WatchUi.SLIDE_UP);
            } else {
                WatchUi.showToast(_noRecordsString, { :icon => null });
            }
        } else if (item == :item_reset) {
            pushDialog(_resetString, true);
        } else if (item == :item_exit) {
            pushDialog(_exitString, false);
        }
    }

    private function pushDialog(confirmInfo as String, shouldResetData as Boolean) as Boolean {
        var dialog = new WatchUi.Confirmation(confirmInfo);
        WatchUi.pushView(dialog, new $.ConfirmationDialogDelegate(shouldResetData), WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    private function showReport() as Void {
        var records = $.match_records;
        var start_time = "";
        var stop_time = "";
        var home_goal = "";
        var away_goal = "";
        var title = "";
        var home_goals = 0;
        var away_goals = 0;
        var mainMenu = new WatchUi.Menu2({:title=>""});

        for (var i = 0; i < records.size(); i++) {
            var record = records[i] as Dictionary<String, String>;
            if (record.hasKey("start_time")) {
                var value = record.get("start_time");
                var index = value.find(" ");
                start_time = value.substring(index+1, null);
                mainMenu.addItem(new WatchUi.MenuItem(start_time, _startString, null, null));
            } else if (record.hasKey("stop_time")) {
                var value = record.get("stop_time");
                var index = value.find(" ");
                stop_time = value.substring(index+1, null);
                mainMenu.addItem(new WatchUi.MenuItem(stop_time, _stopString, null, null));
            } else if (record.hasKey("home_goal")) {
                var value = record.get("home_goal");
                var index = value.find(" ");
                home_goal = value.substring(index+1, null);
                mainMenu.addItem(new WatchUi.MenuItem(home_goal, _homeString, null, null));
                home_goals += 1;
            } else if (record.hasKey("away_goal")) {
                var value = record.get("away_goal");
                var index = value.find(" ");
                away_goal = value.substring(index+1, null);
                mainMenu.addItem(new WatchUi.MenuItem(away_goal, _awayString, null, null));
                away_goals += 1;
            }
        }
        title = home_goals + " - " + away_goals;
        mainMenu.setTitle(title);
        WatchUi.pushView(mainMenu, new $.RecordsMenu2DetailDelegate(records), WatchUi.SLIDE_UP);
    }
}