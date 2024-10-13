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
class RecordsMenu2DetailDelegate extends WatchUi.Menu2InputDelegate {
    var _records = [] as Array<Dictionary<String, String>>;

    //! Constructor
    public function initialize(records as Array<Dictionary<String, String>>) {
        Menu2InputDelegate.initialize();
        _records = records;
    }

    //! Handle an item being selected
    //! @param item The selected menu item
    public function onSelect(item as MenuItem) as Void {
        System.println(_records.toString());
        var view = new $.ReportView(_records);
        WatchUi.pushView(view, new $.ReportViewDelegate(view), WatchUi.SLIDE_UP);
    }

    //! Handle the back key being pressed
    public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }
}
