//
// Copyright 2018-2021 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Application.Storage;
import Toybox.Position;

//! This is the menu input delegate for the main menu of the application
class RecordsMenu2Delegate extends WatchUi.Menu2InputDelegate {
    private var _prompString as String;
    private var _startString as String;
    private var _stopString as String;
    private var _homeString as String;
    private var _awayString as String;

    //! Constructor
    public function initialize() {
        Menu2InputDelegate.initialize();
        _startString = WatchUi.loadResource($.Rez.Strings.Start) as String;
        _stopString = WatchUi.loadResource($.Rez.Strings.Stop) as String;
        _homeString = $.homeString;
        _awayString = $.awayString;
    }

    //! Handle an item being selected
    //! @param item The selected menu item
    public function onSelect(item as MenuItem) as Void {
            var records = Storage.getValue(item.getLabel()) as Array<Dictionary<String, String>>;

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

    //! Handle the back key being pressed
    public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }
}
