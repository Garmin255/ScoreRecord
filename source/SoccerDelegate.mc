import Toybox.Lang;
import Toybox.WatchUi;

class SoccerDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new SoccerMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}