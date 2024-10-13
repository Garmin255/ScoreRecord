import Toybox.Lang;
import Toybox.WatchUi;

class ReportViewDelegate extends WatchUi.BehaviorDelegate {
    var _view as ReportView;

    public function initialize(view as ReportView) {
        BehaviorDelegate.initialize();
        _view = view;
    }

    public function onPreviousPage() as Boolean {
        _view.setReportType($.HOME);
        return true;
    }

    public function onNextPage() as Boolean {
        _view.setReportType($.AWAY);
        return true;
    }
    
    public function onSelect() as Boolean {
        _view.setReportType($.ALL);
        return true;
    }
}