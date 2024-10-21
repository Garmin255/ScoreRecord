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
class TeamNameMenu2Delegate extends WatchUi.Menu2InputDelegate {
    private var _success as String;

    //! Constructor
    public function initialize() {
        Menu2InputDelegate.initialize();
        _success = WatchUi.loadResource($.Rez.Strings.Success) as String;
    }

    //! Handle an item being selected
    //! @param item The selected menu item
    public function onSelect(item as MenuItem) as Void {
        var index = item.getId() as Number;
        WatchUi.showToast(_success, { :icon => null });
        
        $.setTeamIndex(index);
        $.getTeamIndex();
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }

    //! Handle the back key being pressed
    public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }
}
