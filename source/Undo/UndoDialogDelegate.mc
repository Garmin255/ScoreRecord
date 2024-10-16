//
// Copyright 2016-2021 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

import Toybox.Lang;
import Toybox.WatchUi;

//! Input handler for the confirmation dialog
class UndoDialogDelegate extends WatchUi.ConfirmationDelegate {
    private var _view as SoccerView;

    //! Constructor
    //! @param view The app view
    public function initialize(view as SoccerView) {
        ConfirmationDelegate.initialize();
        _view = view;
    }

    //! Handle a confirmation selection
    //! @param value The confirmation value
    //! @return true if handled, false otherwise
    public function onResponse(value as Confirm) as Boolean {
        if (value == WatchUi.CONFIRM_YES) {
            _view.undo();
        }
        return true;
    }
}