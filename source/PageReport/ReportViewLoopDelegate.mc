//
// Copyright 2015-2023 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

import Toybox.Lang;
import Toybox.WatchUi;

//! Input handler for the main primate views
class ReportViewLoopDelegate extends WatchUi.BehaviorDelegate {
    private var _index as Number;

    //! Constructor
    //! @param index The current page index
    public function initialize(index as Number) {
        BehaviorDelegate.initialize();
        _index = index;
    }

    //! On select behavior show the detail view
    //! @return true if handled, false otherwise
    public function onSelect() as Boolean {
        System.println("===");
        return true;
    }
}
