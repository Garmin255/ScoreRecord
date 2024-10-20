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

    //! Constructor
    public function initialize() {
        Menu2InputDelegate.initialize();
    }

    //! Handle an item being selected
    //! @param item The selected menu item
    public function onSelect(item as MenuItem) as Void {
        var index = item.getId() as Number;
        // swtich (item.getId() as Number) {
        //     case $.TEAM1_TEAM2:
        //         break;
        //     case $.SCHOOL_STAND:
        //         break;
        //     case $.HOME_AWAY:
        //     default:
        //         break;
        // }
        $.setTeamIndex(index);
        $.getTeamIndex();
    }

    //! Handle the back key being pressed
    public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }
}
