//
// Copyright 2016-2021 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

import Toybox.Lang;
import Toybox.WatchUi;

//! Input handler for the confirmation dialog
class ConfirmationDialogDelegate extends WatchUi.ConfirmationDelegate {
    private var _confirmString as String;
    private var _cancelString as String;

    //! Constructor
    //! @param view The app view
    public function initialize() {
        ConfirmationDelegate.initialize();
        _confirmString = WatchUi.loadResource($.Rez.Strings.Confirm) as String;
        _cancelString = WatchUi.loadResource($.Rez.Strings.Cancel) as String;
    }

    //! Handle a confirmation selection
    //! @param value The confirmation value
    //! @return true if handled, false otherwise
    public function onResponse(value as Confirm) as Boolean {
        if (value == WatchUi.CONFIRM_YES) {
            $.defaultData();
            System.exit();
        }
        return true;
    }
}