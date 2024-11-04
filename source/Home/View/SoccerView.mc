import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.ActivityRecording;
import Toybox.Activity;
import Toybox.System;
import Toybox.Timer;
import Toybox.Ant;
import Toybox.FitContributor;
using Toybox.Time;
using Toybox.Time.Gregorian;

class SoccerView extends WatchUi.View {
    private const METERS_TO_MILES = 0.000621371;
    private const MILLISECONDS_TO_SECONDS = 0.001;
    private var _session as Session?;
    private var _scoreSeparator as String;
    private var _undoErrorString as String;
    private var _homeString as String;
    private var _awayString as String;
	var homeTeamScore = 0;
	var awayTeamScore = 0;
	var lastScored = new [0];
	var myTimer = new Timer.Timer();
	var currentTime;
    var currentVersion = "v1.5.20241104";
    var matchSeconds =  0;
	var matchTimer = new Timer.Timer();
    var info as Activity.Info;
    private const HOME_FIELD_ID = 0;
    private const AWAY_FIELD_ID = 1;
    private var _homeFitField as Field?;
    private var _awayFitField as Field?;

    function initialize() {
        View.initialize();
        _scoreSeparator = WatchUi.loadResource($.Rez.Strings.ScoreSeparator) as String;
        _undoErrorString = WatchUi.loadResource($.Rez.Strings.UndoError) as String;
        setCurrentTime();
        myTimer.start(method(:makeTimeAppear), 1000, true);
    }
    
    function setCurrentTime() {
    	var myTime = System.getClockTime(); // ClockTime object
		currentTime = myTime.hour.format("%02d") + ":" + myTime.min.format("%02d") + ":" + myTime.sec.format("%02d");
    }
    
    function makeTimeAppear() {
    	setCurrentTime();

    	WatchUi.requestUpdate();
		return true;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    function timerCallback() {
        matchSeconds += 1;
        WatchUi.requestUpdate();
    }


    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        _homeString = $.homeString;
        _awayString = $.awayString;
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        updateLabel("id_prompt_label", "");

        View.onUpdate(dc);

        if (isSessionRecording()) {
            var minutes = matchSeconds / 60;
            var seconds = matchSeconds % 60;
            var matchTime = Lang.format("$1$:$2$", [minutes.format("%02d"), seconds.format("%02d")]);
            var timer = new WatchUi.Text({
                :text => matchTime,
                :color => Graphics.COLOR_LT_GRAY,
                :font => Graphics.FONT_LARGE,
                :locX => (dc.getWidth() / 2),
                :locY => (dc.getHeight() / 10) * 1,
                :justification => Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
            });
            timer.draw(dc);
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawLine(0, (dc.getHeight() / 5) * 1, dc.getWidth(), (dc.getHeight() / 5) * 1);

            var homeTeamText = new WatchUi.Text({
                :text => _homeString,
                :color => Graphics.COLOR_GREEN,
                :font => Graphics.FONT_MEDIUM,
                :locX => (dc.getWidth() / 2) - 30,
                :locY => (dc.getHeight() / 10) * 3,
                :justification => Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER
            });
            homeTeamText.draw(dc);

            var awayTeamText = new WatchUi.Text({
                :text => _awayString,
                :color => Graphics.COLOR_BLUE,
                :font => Graphics.FONT_MEDIUM,
                :locX => (dc.getWidth() / 2) + 30,
                :locY => (dc.getHeight() / 10) * 3,
                :justification => Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
            });
            awayTeamText.draw(dc);
            
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawLine(0, (dc.getHeight() / 5) * 2, dc.getWidth(), (dc.getHeight() / 5) * 2); 
            
            drawScore(dc);
            
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawLine(0, (dc.getHeight() / 5) * 3, dc.getWidth(), (dc.getHeight() / 5) * 3);

            var information = "";
            var position = info.currentLocation;
            if (position != null) {
                information += position.toDegrees()[0].format("%.2f") + " " + position.toDegrees()[1].format("%.2f") + " ";
            }

            var elapsedDistance = info.elapsedDistance;
            if (elapsedDistance != null) {
                elapsedDistance = elapsedDistance * METERS_TO_MILES;
                information += elapsedDistance.format(".2f") + "m";
            }

            var speed = info.currentSpeed ;
            if (speed != null && speed > 0.001) {
                information += speed.format("%.2f") + " ";
            } else {
                information = $.startTime;
            }
            var informationText = new WatchUi.Text({
                :text => information,
                :color => Graphics.COLOR_LT_GRAY,
                :font => Graphics.FONT_SMALL,
                :locX => (dc.getWidth() / 2),
                :locY => (dc.getHeight() / 10) * 7,
                :justification => Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
            });
            informationText.draw(dc);
            
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawLine(0, (dc.getHeight() / 5) * 4, dc.getWidth(), (dc.getHeight() / 5) * 4);

            var time = new WatchUi.Text({
                :text => currentTime,
                :color => Graphics.COLOR_LT_GRAY,
                :font => Graphics.FONT_LARGE,
                :locX => (dc.getWidth() / 2),
                :locY => (dc.getHeight() / 10) * 9,
                :justification => Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
            });
            time.draw(dc);
        } else {
            var appName = new WatchUi.Text({
                :text => WatchUi.loadResource(Rez.Strings.AppName),
                :color => Graphics.COLOR_RED,
                :font => Graphics.FONT_LARGE,
                :locX => (dc.getWidth() / 2),
                :locY => (dc.getHeight() / 10) * 3,
                :justification => (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER)
            });
            appName.draw(dc);

            var tips = new WatchUi.Text({
                :text => WatchUi.loadResource(Rez.Strings.Prompt),
                :color => Graphics.COLOR_BLUE,
                :font => Graphics.FONT_AUX3,
                :locX => (dc.getWidth() / 2),
                :locY => (dc.getHeight() / 2),
                :justification => (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER)
            });
            tips.draw(dc);

            var version = new WatchUi.Text({
                :text => currentVersion,
                :color => Graphics.COLOR_LT_GRAY,
                :font => Graphics.FONT_AUX3,
                :locX => (dc.getWidth() / 2),
                :locY => (dc.getHeight() / 10) * 7,
                :justification => Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
            });
            version.draw(dc);

            var time = new WatchUi.Text({
                :text => currentTime,
                :color => Graphics.COLOR_LT_GRAY,
                :font => Graphics.FONT_LARGE,
                :locX => (dc.getWidth() / 2),
                :locY => (dc.getHeight() / 10) * 9,
                :justification => Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
            });
            time.draw(dc);
        }
    }

    function updateGoals() as Void {
        var _records = $.match_records;
        homeTeamScore = 0;
        awayTeamScore = 0;

        for (var i = 0; i < _records.size(); i++) {
            var record = _records[i] as Dictionary<String, String>;
            if (record.hasKey("home_goal")) {
                homeTeamScore += 1;
            } else if (record.hasKey("away_goal")) {
                awayTeamScore += 1;
            }
        }
    	WatchUi.requestUpdate();
    }

    function drawScore(dc) {
    	var homeTeamScoreText = new WatchUi.Text({
            :text => homeTeamScore.toString(),
            :color => Graphics.COLOR_GREEN,
            :font => Graphics.FONT_LARGE,
            :locX => (dc.getWidth() / 2) - 30,
            :locY => WatchUi.LAYOUT_VALIGN_CENTER,
            :justification => Graphics.TEXT_JUSTIFY_RIGHT
        });
        homeTeamScoreText.draw(dc);
        
        var separator = new WatchUi.Text({
            :text => _scoreSeparator,
            :color => Graphics.COLOR_LT_GRAY,
            :font => Graphics.FONT_LARGE,
            :locX => (dc.getWidth() / 2),
            :locY => WatchUi.LAYOUT_VALIGN_CENTER,
            :justification => Graphics.TEXT_JUSTIFY_CENTER
        });
        separator.draw(dc);
        
        var awayTeamScoreText = new WatchUi.Text({
            :text => awayTeamScore.toString(),
            :color => Graphics.COLOR_BLUE,
            :font => Graphics.FONT_LARGE,
            :locX => (dc.getWidth() / 2) + 30,
            :locY => WatchUi.LAYOUT_VALIGN_CENTER,
            :justification => Graphics.TEXT_JUSTIFY_LEFT
        });
        awayTeamScoreText.draw(dc);
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

    //! Stop the recording if necessary
    public function stopRecording() as Void {
        var session = _session;
        if ((Toybox has :ActivityRecording) && isSessionRecording() && (session != null)) {
            session.stop();
            session.save();
            _session = null;
            WatchUi.requestUpdate();
        }
    }

    //! Start recording a session
    public function startRecording() as Void {
        _session = ActivityRecording.createSession({:name => "Goal Record", :sport => $.typesOfSport});
        _homeFitField = _session.createField(
                WatchUi.loadResource($.Rez.Strings.HomeGoalLabel) as String,
                HOME_FIELD_ID,
                FitContributor.DATA_TYPE_FLOAT,
                {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>WatchUi.loadResource($.Rez.Strings.HomeGoalLabel) as String}
            );
        _awayFitField = _session.createField(
                WatchUi.loadResource($.Rez.Strings.AwayGoalLabel) as String,
                AWAY_FIELD_ID,
                FitContributor.DATA_TYPE_FLOAT,
                {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>WatchUi.loadResource($.Rez.Strings.AwayGoalLabel) as String}
            );
        _session.start();
        info = Activity.getActivityInfo();
        matchTimer.start(method(:timerCallback), 1000, true);
        WatchUi.requestUpdate();
    }

    public function recordHomeGoal() as Void {
        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var value = today.hour * 10000 + today.min * 100 + today.sec * 1;
        _homeFitField.setData(value as Object); 
    }

    public function recordAwayGoal() as Void {
        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var value = today.hour * 10000 + today.min * 100 + today.sec * 1;
        _awayFitField.setData(value as Object); 
    }

    public function isSessionRecording() as Boolean {
        if (_session != null) {
            return _session.isRecording();
        }
        return false;
    }

    public function undo() as Void {
        var _records = $.match_records;
        var record = _records[_records.size()-1] as Dictionary<String, String>;
        if (record.hasKey("home_goal")) {
            _records.remove(record);
        } else if (record.hasKey("away_goal")) {
            _records.remove(record);
        } else {
            WatchUi.showToast(_undoErrorString, { :icon => null });
        }
        persistentData();
        updateGoals();
    	WatchUi.requestUpdate();
    }
}
