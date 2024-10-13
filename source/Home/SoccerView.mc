import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.ActivityRecording;
using Toybox.WatchUi as Ui;
using Toybox.System;
using Toybox.Graphics as Gfx;

class SoccerView extends WatchUi.View {
    private var _session as Session?;
	var homeTeamScore = 0;
	var awayTeamScore = 0;
	var lastScored = new [0];
	var myTimer = new Timer.Timer();
	var currentTime;

    function initialize() {
        View.initialize();
        setCurrentTime();
        myTimer.start(method(:makeTimeAppear), 1000, true);
    }
    
    function setCurrentTime() {
    	var myTime = System.getClockTime(); // ClockTime object
		currentTime = myTime.hour.format("%02d") + ":" + myTime.min.format("%02d") + ":" + myTime.sec.format("%02d");
    }
    
    function makeTimeAppear() {
    	setCurrentTime();

    	Ui.requestUpdate();
		return true;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
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

        if (isSessionRecording()) {
            var homeTeamText = new Ui.Text({
                :text => WatchUi.loadResource(Rez.Strings.Home),
                :color => Graphics.COLOR_GREEN,
                :font => Graphics.FONT_MEDIUM,
                :locX => (dc.getWidth() / 2) - 30,
                :locY => (dc.getHeight() / 6),
                :justification => Gfx.TEXT_JUSTIFY_RIGHT
            });
            homeTeamText.draw(dc);
            
            var awayTeamText = new Ui.Text({
                :text => WatchUi.loadResource(Rez.Strings.Away),
                :color => Graphics.COLOR_BLUE,
                :font => Graphics.FONT_MEDIUM,
                :locX => (dc.getWidth() / 2) + 30,
                :locY => (dc.getHeight() / 6),
                :justification => Gfx.TEXT_JUSTIFY_LEFT
            });
            awayTeamText.draw(dc);
            
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawLine(0, dc.getHeight() / 3, dc.getWidth(), dc.getHeight() / 3); 
            
            drawScore(dc);
            
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawLine(0, (dc.getHeight() / 3) * 2, dc.getWidth(), (dc.getHeight() / 3) * 2);
            
            var time = new Ui.Text({
                :text => currentTime,
                :color => Graphics.COLOR_LT_GRAY,
                :font => Graphics.FONT_LARGE,
                :locX => (dc.getWidth() / 2),
                :locY => (dc.getHeight() / 4) * 3,
                :justification => Gfx.TEXT_JUSTIFY_CENTER
            });
            time.draw(dc);
        } else {
            var tips = new Ui.Text({
                :text => WatchUi.loadResource(Rez.Strings.Prompt),
                :color => Graphics.COLOR_BLUE,
                :font => Graphics.FONT_MEDIUM,
                :locX => (dc.getWidth() / 2),
                :locY => (dc.getHeight() / 2),
                :justification => (Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER)
            });
            tips.draw(dc);
        }
    }

    function updateGoals() as Void {
        var _records = $.global_records;

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
    	Ui.requestUpdate();
    }

    function drawScore(dc) {
    	var homeTeamScoreText = new Ui.Text({
            :text => homeTeamScore.toString(),
            :color => Graphics.COLOR_GREEN,
            :font => Graphics.FONT_LARGE,
            :locX => (dc.getWidth() / 2) - 30,
            :locY => WatchUi.LAYOUT_VALIGN_CENTER,
            :justification => Gfx.TEXT_JUSTIFY_RIGHT
        });
        homeTeamScoreText.draw(dc);
        
        var separator = new Ui.Text({
            :text => ":",
            :color => Graphics.COLOR_LT_GRAY,
            :font => Graphics.FONT_LARGE,
            :locX => (dc.getWidth() / 2),
            :locY => WatchUi.LAYOUT_VALIGN_CENTER,
            :justification => Gfx.TEXT_JUSTIFY_CENTER
        });
        separator.draw(dc);
        
        var awayTeamScoreText = new Ui.Text({
            :text => awayTeamScore.toString(),
            :color => Graphics.COLOR_BLUE,
            :font => Graphics.FONT_LARGE,
            :locX => (dc.getWidth() / 2) + 30,
            :locY => WatchUi.LAYOUT_VALIGN_CENTER,
            :justification => Gfx.TEXT_JUSTIFY_LEFT
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
        _session = ActivityRecording.createSession({:name => "BlueDream", :sport => Activity.SPORT_SOCCER});
        _session.start();
        WatchUi.requestUpdate();
    }

    public function isSessionRecording() as Boolean {
        if (_session != null) {
            return _session.isRecording();
        }
        return false;
    }
}
