import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SoccerMenuDelegate extends WatchUi.MenuInputDelegate {
    private var _recordsString as String;
    private var _defaultsString as String;

    function initialize() {
        MenuInputDelegate.initialize();
        _recordsString = WatchUi.loadResource($.Rez.Strings.Records) as String;
        _defaultsString = WatchUi.loadResource($.Rez.Strings.Defaults) as String;
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :item_records) {
            System.println("Records");
            var mainMenu = new WatchUi.Menu2({:title=>_recordsString});
            for (var i = 0; i < $.match_dates.size(); i++) {
                var match_date = $.match_dates[i] as String;
                mainMenu.addItem(new WatchUi.MenuItem(match_date, null, null, null));
            }
            WatchUi.pushView(mainMenu, new $.RecordsMenu2Delegate(), WatchUi.SLIDE_UP);
        } else if (item == :item_default) {
            pushDialog();
        } else if (item == :item_exit) {
            System.println("Exit");
            System.exit();
        }
    }

    private function pushDialog() as Boolean {
        var dialog = new WatchUi.Confirmation(_defaultsString);
        WatchUi.pushView(dialog, new $.ConfirmationDialogDelegate(), WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}