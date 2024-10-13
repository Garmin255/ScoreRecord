import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
import Toybox.Application;
import Toybox.Application.Storage;

class SoccerDelegate extends WatchUi.BehaviorDelegate {
    private var _view as SoccerView;
    private var _prompString as String;
    private var _startString as String;
    private var _stopString as String;
    private var _homeString as String;
    private var _awayString as String;

    function initialize(view as SoccerView) {
        BehaviorDelegate.initialize();
        _view = view;
        _prompString = WatchUi.loadResource($.Rez.Strings.Prompt) as String;
        _startString = WatchUi.loadResource($.Rez.Strings.Start) as String;
        _stopString = WatchUi.loadResource($.Rez.Strings.Stop) as String;
        _homeString = WatchUi.loadResource($.Rez.Strings.Home) as String;
        _awayString = WatchUi.loadResource($.Rez.Strings.Away) as String;
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new SoccerMenuDelegate(_view), WatchUi.SLIDE_UP);
        return true;
    }

    public function onPreviousPage() as Boolean {
        if (_view.isSessionRecording()) {
            $.global_records.add({"home_goal" => nowString()});
            WatchUi.showToast(_homeString, { :icon => null });
            playVibate();
            Attention.playTone(Attention.TONE_SUCCESS);
            persistentData();
        } else {
            WatchUi.showToast(_prompString, { :icon => null });
        }
        _view.updateGoals();
        return true;
    }

    public function onNextPage() as Boolean {
        if (_view.isSessionRecording()) {
            $.global_records.add({"away_goal" => nowString()});
            WatchUi.showToast(_awayString, { :icon => null });
            playVibate();
            Attention.playTone(Attention.TONE_FAILURE);
            persistentData();
        } else {
            WatchUi.showToast(_prompString, { :icon => null });
        }
        _view.updateGoals();
        return true;
    }

    public function onSelect() as Boolean {
        var nowStr = nowString();
        if (!_view.isSessionRecording()) {
            $.global_records = [];
            $.global_records.add({"start_time" => nowStr});
            if (Attention has :playTone) {
                Attention.playTone(Attention.TONE_START);
            }
            $.match_dates.add(nowStr);
            persistentData();
            playVibate();
            WatchUi.showToast(_startString, { :icon => null });
            if (Toybox has :ActivityRecording) {
                _view.startRecording();
            }
        } else {
            $.global_records.add({"stop_time" => nowStr});
            if (Attention has :playTone) {
                Attention.playTone(Attention.TONE_LOUD_BEEP);
            }
            persistentData();
            playVibate();
            WatchUi.showToast(_stopString, { :icon => null });
            WatchUi.pushView(new Rez.Menus.MainMenu(), new SoccerMenuDelegate(_view), WatchUi.SLIDE_UP);
        }
        WatchUi.requestUpdate();
        return true;
    }

    public function nowString() as String { 
        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        return Lang.format(
            "$1$-$2$-$3$ $4$:$5$:$6$",
            [
                today.year,
                today.month,
                today.day,
                today.hour.format("%02d"),
                today.min.format("%02d"),
                today.sec.format("%02d"),
            ]
        );
    }
}