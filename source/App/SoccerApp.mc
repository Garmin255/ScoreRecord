import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Application.Storage;
import Toybox.Position;
import Toybox.Attention;
import Toybox.Activity;

var match_datas = [] as Array<String>;
var match_records = [] as Array<Dictionary<String, String>>;

enum {
    HOME_AWAY,
    TEAM1_TEAM2,
    SCHOOL_STAND,
}

var teamIndex = $.HOME_AWAY;
var homeString as String;
var awayString as String;

var homeAway as String;
var team1Team2 as String;
var schoolStand as String;
var startTime as String;
var typesOfSport = Activity.SPORT_SOCCER;

function getTeamNameString(index as Number) as String {
    var result = "";
    switch (index) {
        case $.HOME_AWAY:
            result = $.homeAway;
            break;
        case $.TEAM1_TEAM2:
            result = $.team1Team2;
            break;
        case $.SCHOOL_STAND:
            result = $.schoolStand;
            break;
        default:
            result = $.homeAway;
            break;
    }
    return result;
}

function getTypesOfSportString(index as Number) as String {
    var result = "";
    switch (index) {
        case Activity.SPORT_GENERIC:
            result = sportGeneric;
            break;
        case Activity.SPORT_RUNNING:
            result = sportRunning;
            break;
        case Activity.SPORT_CYCLING:
            result = sportCycling;
            break;
        case Activity.SPORT_TRANSITION:
            result = sportTransition;
            break;
        case Activity.SPORT_FITNESS_EQUIPMENT:
            result = sportFitnessEquipment;
            break;
        case Activity.SPORT_SWIMMING:
            result = sportSwimming;
            break;
        case Activity.SPORT_BASKETBALL:
            result = sportBasketball;
            break;
        case Activity.SPORT_SOCCER:
            result = sportSoccer;
            break;
        case Activity.SPORT_TENNIS:
            result = sportTennis;
            break;
        case Activity.SPORT_AMERICAN_FOOTBALL:
            result = sportAmericanFootball;
            break;
        case Activity.SPORT_TRAINING:
            result = sportTraining;
            break;
        case Activity.SPORT_WALKING:
            result = sportWalking;
            break;
        case Activity.SPORT_CROSS_COUNTRY_SKIING:
            result = sportCrossCountrySkiing;
            break;
        case Activity.SPORT_ALPINE_SKIING:
            result = sportAlpineSkiing;
            break;
        case Activity.SPORT_SNOWBOARDING:
            result = sportSnowboarding;
            break;
        case Activity.SPORT_ROWING:
            result = sportRowing;
            break;
        case Activity.SPORT_MOUNTAINEERING:
            result = sportMountaineering;
            break;
        case Activity.SPORT_HIKING:
            result = sportHiking;
            break;
        case Activity.SPORT_MULTISPORT:
            result = sportMultisport;
            break;
        case Activity.SPORT_PADDLING:
            result = sportPaddling;
            break;
        case Activity.SPORT_FLYING:
            result = sportFlying;
            break;
        case Activity.SPORT_E_BIKING:
            result = sportEBiking;
            break;
        case Activity.SPORT_MOTORCYCLING:
            result = sportMotorcycling;
            break;
        case Activity.SPORT_BOATING:
            result = sportBoating;
            break;
        case Activity.SPORT_DRIVING:
            result = sportDriving;
            break;
        case Activity.SPORT_GOLF:
            result = sportGolf;
            break;
        case Activity.SPORT_HANG_GLIDING:
            result = sportHangGliding;
            break;
        case Activity.SPORT_HORSEBACK_RIDING:
            result = sportHorsebackRiding;
            break;
        case Activity.SPORT_HUNTING:
            result = sportHunting;
            break;
        case Activity.SPORT_FISHING:
            result = sportFishing;
            break;
        case Activity.SPORT_INLINE_SKATING:
            result = sportInlineSkating;
            break;
        case Activity.SPORT_ROCK_CLIMBING:
            result = sportRockClimbing;
            break;
        case Activity.SPORT_SAILING:
            result = sportSailing;
            break;
        case Activity.SPORT_ICE_SKATING:
            result = sportIceSkating;
            break;
        case Activity.SPORT_SKY_DIVING:
            result = sportSkyDiving;
            break;
        case Activity.SPORT_SNOWSHOEING:
            result = sportSnowshoeing;
            break;
        case Activity.SPORT_SNOWMOBILING:
            result = sportSnowmobiling;
            break;
        case Activity.SPORT_STAND_UP_PADDLEBOARDING:
            result = sportStandUpPaddleboarding;
            break;
        case Activity.SPORT_SURFING:
            result = sportSurfing;
            break;
        case Activity.SPORT_WAKEBOARDING:
            result = sportWakeboarding;
            break;
        case Activity.SPORT_WATER_SKIING:
            result = sportWaterSkiing;
            break;
        case Activity.SPORT_KAYAKING:
            result = sportKayaking;
            break;
        case Activity.SPORT_RAFTING:
            result = sportRafting;
            break;
        case Activity.SPORT_WINDSURFING:
            result = sportWindsurfing;
            break;
        case Activity.SPORT_KITESURFING:
            result = sportKitesurfing;
            break;
        case Activity.SPORT_TACTICAL:
            result = sportTactical;
            break;
        case Activity.SPORT_JUMPMASTER:
            result = sportJumpmaster;
            break;
        case Activity.SPORT_BOXING:
            result = sportBoxing;
            break;
        case Activity.SPORT_FLOOR_CLIMBING:
            result = sportFloorClimbing;
            break;
        case Activity.SPORT_BASEBALL:
            result = sportBaseball;
            break;
        case Activity.SPORT_SOFTBALL_FAST_PITCH:
            result = sportSoftballFastPitch;
            break;
        case Activity.SPORT_SOFTBALL_SLOW_PITCH:
            result = sportSoftballSlowPitch;
            break;
        case Activity.SPORT_SHOOTING:
            result = sportShooting;
            break;
        case Activity.SPORT_AUTO_RACING:
            result = sportAutoRacing;
            break;
        case Activity.SPORT_WINTER_SPORT:
            result = sportWinterSport;
            break;
        case Activity.SPORT_GRINDING:
            result = sportGrinding;
            break;
        case Activity.SPORT_HEALTH_MONITORING:
            result = sportHealthMonitoring;
            break;
        case Activity.SPORT_MARINE:
            result = sportMarine;
            break;
        case Activity.SPORT_HIIT:
            result = sportHIIT;
            break;
        case Activity.SPORT_VIDEO_GAMING:
            result = sportVideoGaming;
            break;
        case Activity.SPORT_RACKET:
            result = sportRacket;
            break;
        case Activity.SPORT_WHEELCHAIR_PUSH_WALK:
            result = sportWheelchairPushWalk;
            break;
        case Activity.SPORT_WHEELCHAIR_PUSH_RUN:
            result = sportWheelchairPushRun;
            break;
        case Activity.SPORT_MEDITATION:
            result = sportMeditation;
            break;
        case Activity.SPORT_PARA_SPORT:
            result = sportParaSport;
            break;
        case Activity.SPORT_DISC_GOLF:
            result = sportDiscGolf;
            break;
        case Activity.SPORT_TEAM_SPORT:
            result = sportTeamSport;
            break;
        case Activity.SPORT_CRICKET:
            result = sportCricket;
            break;
        case Activity.SPORT_RUGBY:
            result = sportRugby;
            break;
        case Activity.SPORT_HOCKEY:
            result = sportHockey;
            break;
        case Activity.SPORT_LACROSSE:
            result = sportLacrosse;
            break;
        case Activity.SPORT_VOLLEYBALL:
            result = sportVolleyball;
            break;
        case Activity.SPORT_WATER_TUBING:
            result = sportWaterTubing;
            break;
        case Activity.SPORT_WAKESURFING:
            result = sportWakesurfing;
            break;
        case Activity.SPORT_INVALID:
            result = sportInvalid;
            break;
        default:
            result = sportSoccer; // 假设有相应的值
            break;
    }
    return result;
}

// SPORT_GENERIC
var sportGeneric as String;

// SPORT_RUNNING
var sportRunning as String;

// SPORT_CYCLING
var sportCycling as String;

// SPORT_TRANSITION
var sportTransition as String;

// SPORT_FITNESS_EQUIPMENT
var sportFitnessEquipment as String;

// SPORT_SWIMMING
var sportSwimming as String;

// SPORT_BASKETBALL
var sportBasketball as String;

// SPORT_SOCCER
var sportSoccer as String;

// SPORT_TENNIS
var sportTennis as String;

// SPORT_AMERICAN_FOOTBALL
var sportAmericanFootball as String;

// SPORT_TRAINING
var sportTraining as String;

// SPORT_WALKING
var sportWalking as String;

// SPORT_CROSS_COUNTRY_SKIING
var sportCrossCountrySkiing as String;

// SPORT_ALPINE_SKIING
var sportAlpineSkiing as String;

// SPORT_SNOWBOARDING
var sportSnowboarding as String;

// SPORT_ROWING
var sportRowing as String;

// SPORT_MOUNTAINEERING
var sportMountaineering as String;

// SPORT_HIKING
var sportHiking as String;

// SPORT_MULTISPORT
var sportMultisport as String;

// SPORT_PADDLING
var sportPaddling as String;

// SPORT_FLYING
var sportFlying as String;

// SPORT_E_BIKING
var sportEBiking as String;

// SPORT_MOTORCYCLING
var sportMotorcycling as String;

// SPORT_BOATING
var sportBoating as String;

// SPORT_DRIVING
var sportDriving as String;

// SPORT_GOLF
var sportGolf as String;

// SPORT_HANG_GLIDING
var sportHangGliding as String;

// SPORT_HORSEBACK_RIDING
var sportHorsebackRiding as String;

// SPORT_HUNTING
var sportHunting as String;

// SPORT_FISHING
var sportFishing as String;

// SPORT_INLINE_SKATING
var sportInlineSkating as String;

// SPORT_ROCK_CLIMBING
var sportRockClimbing as String;

// SPORT_SAILING
var sportSailing as String;

// SPORT_ICE_SKATING
var sportIceSkating as String;

// SPORT_SKY_DIVING
var sportSkyDiving as String;

// SPORT_SNOWSHOEING
var sportSnowshoeing as String;

// SPORT_SNOWMOBILING
var sportSnowmobiling as String;

// SPORT_STAND_UP_PADDLEBOARDING
var sportStandUpPaddleboarding as String;

// SPORT_SURFING
var sportSurfing as String;

// SPORT_WAKEBOARDING
var sportWakeboarding as String;

// SPORT_WATER_SKIING
var sportWaterSkiing as String;

// SPORT_KAYAKING
var sportKayaking as String;

// SPORT_RAFTING
var sportRafting as String;

// SPORT_WINDSURFING
var sportWindsurfing as String;

// SPORT_KITESURFING
var sportKitesurfing as String;

// SPORT_TACTICAL
var sportTactical as String;

// SPORT_JUMPMASTER
var sportJumpmaster as String;

// SPORT_BOXING
var sportBoxing as String;

// SPORT_FLOOR_CLIMBING
var sportFloorClimbing as String;

// SPORT_BASEBALL
var sportBaseball as String;

// SPORT_FAST_PITCH_SOFTBALL
var sportSoftballFastPitch as String;

// SPORT_SLOW_PITCH_SOFTBALL
var sportSoftballSlowPitch as String;

// SPORT_SHOOTING
var sportShooting as String;

// SPORT_AUTO_RACING
var sportAutoRacing as String;

// SPORT_WINTER_SPORT
var sportWinterSport as String;

// SPORT_GRINDING
var sportGrinding as String;

// SPORT_HEALTH_MONITORING
var sportHealthMonitoring as String;

// SPORT_MARINE
var sportMarine as String;

// SPORT_HIIT
var sportHIIT as String;

// SPORT_VIDEO_GAMING
var sportVideoGaming as String;

// SPORT_RACKET
var sportRacket as String;

// SPORT_WHEELCHAIR_PUSH_WALK
var sportWheelchairPushWalk as String;

// SPORT_WHEELCHAIR_PUSH_RUN
var sportWheelchairPushRun as String;

// SPORT_MEDITATION
var sportMeditation as String;

// SPORT_PARA_SPORT
var sportParaSport as String;

// SPORT_DISC_GOLF
var sportDiscGolf as String;

// SPORT_TEAM_SPORT
var sportTeamSport as String;

// SPORT_CRICKET
var sportCricket as String;

// SPORT_RUGBY
var sportRugby as String;

// SPORT_HOCKEY
var sportHockey as String;

// SPORT_LACROSSE
var sportLacrosse as String;

// SPORT_VOLLEYBALL
var sportVolleyball as String;

// SPORT_WATER_TUBING
var sportWaterTubing as String;

// SPORT_WAKESURFING
var sportWakesurfing as String;

// SPORT_INVALID
var sportInvalid as String;

class SoccerApp extends Application.AppBase {
    var _soccerView as SoccerView?;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
        loadTypesOfSportString();
        getTypesOfSport();
        var value = Storage.getValue("match_datas");
        if (value != null) {
            match_datas = value;
        }
        $.getTeamIndex();
        homeAway = Lang.format(
            "$1$-$2$",
            [
                WatchUi.loadResource(Rez.Strings.Home),
                WatchUi.loadResource(Rez.Strings.Away)
            ]
        );
        team1Team2 = Lang.format(
            "$1$-$2$",
            [
                WatchUi.loadResource(Rez.Strings.Home1),
                WatchUi.loadResource(Rez.Strings.Away1)
            ]
        );
        schoolStand = Lang.format(
            "$1$-$2$",
            [
                WatchUi.loadResource(Rez.Strings.Home2),
                WatchUi.loadResource(Rez.Strings.Away2)
            ]
        );
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        if (_soccerView != null) {

            _soccerView.stopRecording();
        }
        Position.enableLocationEvents(Position.LOCATION_DISABLE, method(:onPosition));
    }


    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
         _soccerView = new SoccerView();
        return [ _soccerView, new SoccerDelegate(_soccerView) ];
  
    }

    public function onPosition(info as Toybox.Position.Info) as Void {
    }

}

function getApp() as SoccerApp {
    return Application.getApp() as SoccerApp;
}

function recordsInformation() as String {
    var result = "";
    for (var i = 0; i < $.match_records.size(); i++) {
        var record = $.match_records[i] as Dictionary<String, String>;
        var keys = record.keys(); 
        result += keys[0] + ": " + record.get(keys[0]) + "\n";
        
    }
    return result;
}

function persistentData() as Void {
    Storage.setValue("match_datas", $.match_datas);
    if ($.match_datas.size() > 0) {
        Storage.setValue($.match_datas[$.match_datas.size()-1], $.match_records);
    }
}

function resetData() as Void {
    Storage.clearValues();
}

function removeLastMatchData() as Void {
    if ($.match_datas.size() > 0) {
        var last_data = $.match_datas[$.match_datas.size() - 1];
        Storage.deleteValue(last_data);
        $.match_datas.remove(last_data);
    }
}

function playVibate() as Void {
    if (Attention has :vibrate) {
        var vibrateData = [
                new Attention.VibeProfile(25, 100),
                new Attention.VibeProfile(50, 100),
                new Attention.VibeProfile(75, 100),
                new Attention.VibeProfile(100, 100),
                new Attention.VibeProfile(75, 100),
                new Attention.VibeProfile(50, 100),
                new Attention.VibeProfile(25, 100)
                ];

        Attention.vibrate(vibrateData);
    }
}

public function setTeamIndex(index as Number) {
    Storage.setValue("team_index", index);
}

public function getTeamIndex() {
    var value = Storage.getValue("team_index");
    if (value != null) {
        teamIndex = value;
    }
    switch (teamIndex) {
        case $.TEAM1_TEAM2:
            homeString = WatchUi.loadResource(Rez.Strings.Home1);
            awayString = WatchUi.loadResource(Rez.Strings.Away1);
            break;
        case $.SCHOOL_STAND:
            homeString = WatchUi.loadResource(Rez.Strings.Home2);
            awayString = WatchUi.loadResource(Rez.Strings.Away2);
            break;
        case $.HOME_AWAY:
        default:
            homeString = WatchUi.loadResource(Rez.Strings.Home);
            awayString = WatchUi.loadResource(Rez.Strings.Away);
            break;
    }
}

function pushComfirmDialog(confirmInfo as String, shouldResetData as Boolean) as Boolean {
    var dialog = new WatchUi.Confirmation(confirmInfo);
    WatchUi.pushView(dialog, new $.ConfirmationDialogDelegate(shouldResetData), WatchUi.SLIDE_IMMEDIATE);
    return true;
}

public function loadTypesOfSportString() as Void {
    sportGeneric = WatchUi.loadResource(Rez.Strings.SPORT_GENERIC);
    sportRunning = WatchUi.loadResource(Rez.Strings.SPORT_RUNNING);
    sportCycling = WatchUi.loadResource(Rez.Strings.SPORT_CYCLING);
    sportTransition = WatchUi.loadResource(Rez.Strings.SPORT_TRANSITION);
    sportFitnessEquipment = WatchUi.loadResource(Rez.Strings.SPORT_FITNESS_EQUIPMENT);
    sportSwimming = WatchUi.loadResource(Rez.Strings.SPORT_SWIMMING);
    sportBasketball = WatchUi.loadResource(Rez.Strings.SPORT_BASKETBALL);
    sportSoccer = WatchUi.loadResource(Rez.Strings.SPORT_SOCCER);
    sportTennis = WatchUi.loadResource(Rez.Strings.SPORT_TENNIS);
    sportAmericanFootball = WatchUi.loadResource(Rez.Strings.SPORT_AMERICAN_FOOTBALL);
    sportTraining = WatchUi.loadResource(Rez.Strings.SPORT_TRAINING);
    sportWalking = WatchUi.loadResource(Rez.Strings.SPORT_WALKING);
    sportCrossCountrySkiing = WatchUi.loadResource(Rez.Strings.SPORT_CROSS_COUNTRY_SKIING);
    sportAlpineSkiing = WatchUi.loadResource(Rez.Strings.SPORT_ALPINE_SKIING);
    sportSnowboarding = WatchUi.loadResource(Rez.Strings.SPORT_SNOWBOARDING);
    sportRowing = WatchUi.loadResource(Rez.Strings.SPORT_ROWING);
    sportMountaineering = WatchUi.loadResource(Rez.Strings.SPORT_MOUNTAINEERING);
    sportHiking = WatchUi.loadResource(Rez.Strings.SPORT_HIKING);
    sportMultisport = WatchUi.loadResource(Rez.Strings.SPORT_MULTISPORT);
    sportPaddling = WatchUi.loadResource(Rez.Strings.SPORT_PADDLING);
    sportFlying = WatchUi.loadResource(Rez.Strings.SPORT_FLYING);
    sportEBiking = WatchUi.loadResource(Rez.Strings.SPORT_E_BIKING);
    sportMotorcycling = WatchUi.loadResource(Rez.Strings.SPORT_MOTORCYCLING);
    sportBoating = WatchUi.loadResource(Rez.Strings.SPORT_BOATING);
    sportDriving = WatchUi.loadResource(Rez.Strings.SPORT_DRIVING);
    sportGolf = WatchUi.loadResource(Rez.Strings.SPORT_GOLF);
    sportHangGliding = WatchUi.loadResource(Rez.Strings.SPORT_HANG_GLIDING);
    sportHorsebackRiding = WatchUi.loadResource(Rez.Strings.SPORT_HORSEBACK_RIDING);
    sportHunting = WatchUi.loadResource(Rez.Strings.SPORT_HUNTING);
    sportFishing = WatchUi.loadResource(Rez.Strings.SPORT_FISHING);
    sportInlineSkating = WatchUi.loadResource(Rez.Strings.SPORT_INLINE_SKATING);
    sportRockClimbing = WatchUi.loadResource(Rez.Strings.SPORT_ROCK_CLIMBING);
    sportSailing = WatchUi.loadResource(Rez.Strings.SPORT_SAILING);
    sportIceSkating = WatchUi.loadResource(Rez.Strings.SPORT_ICE_SKATING);
    sportSkyDiving = WatchUi.loadResource(Rez.Strings.SPORT_SKY_DIVING);
    sportSnowshoeing = WatchUi.loadResource(Rez.Strings.SPORT_SNOWSHOEING);
    sportSnowmobiling = WatchUi.loadResource(Rez.Strings.SPORT_SNOWMOBILING);
    sportStandUpPaddleboarding = WatchUi.loadResource(Rez.Strings.SPORT_STAND_UP_PADDLEBOARDING);
    sportSurfing = WatchUi.loadResource(Rez.Strings.SPORT_SURFING);
    sportWakeboarding = WatchUi.loadResource(Rez.Strings.SPORT_WAKEBOARDING);
    sportWaterSkiing = WatchUi.loadResource(Rez.Strings.SPORT_WATER_SKIING);
    sportKayaking = WatchUi.loadResource(Rez.Strings.SPORT_KAYAKING);
    sportRafting = WatchUi.loadResource(Rez.Strings.SPORT_RAFTING);
    sportWindsurfing = WatchUi.loadResource(Rez.Strings.SPORT_WINDSURFING);
    sportKitesurfing = WatchUi.loadResource(Rez.Strings.SPORT_KITESURFING);
    sportTactical = WatchUi.loadResource(Rez.Strings.SPORT_TACTICAL);
    sportJumpmaster = WatchUi.loadResource(Rez.Strings.SPORT_JUMPMASTER);
    sportBoxing = WatchUi.loadResource(Rez.Strings.SPORT_BOXING);
    sportFloorClimbing = WatchUi.loadResource(Rez.Strings.SPORT_FLOOR_CLIMBING);
    sportBaseball = WatchUi.loadResource(Rez.Strings.SPORT_BASEBALL);
    sportSoftballFastPitch = WatchUi.loadResource(Rez.Strings.SPORT_SOFTBALL_FAST_PITCH);
    sportSoftballSlowPitch = WatchUi.loadResource(Rez.Strings.SPORT_SOFTBALL_SLOW_PITCH);
    sportShooting = WatchUi.loadResource(Rez.Strings.SPORT_SHOOTING);
    sportAutoRacing = WatchUi.loadResource(Rez.Strings.SPORT_AUTO_RACING);
    sportWinterSport = WatchUi.loadResource(Rez.Strings.SPORT_WINTER_SPORT);
    sportGrinding = WatchUi.loadResource(Rez.Strings.SPORT_GRINDING);
    sportHealthMonitoring = WatchUi.loadResource(Rez.Strings.SPORT_HEALTH_MONITORING);
    sportMarine = WatchUi.loadResource(Rez.Strings.SPORT_MARINE);
    sportHIIT = WatchUi.loadResource(Rez.Strings.SPORT_HIIT);
    sportVideoGaming = WatchUi.loadResource(Rez.Strings.SPORT_VIDEO_GAMING);
    sportRacket = WatchUi.loadResource(Rez.Strings.SPORT_RACKET);
    sportWheelchairPushWalk = WatchUi.loadResource(Rez.Strings.SPORT_WHEELCHAIR_PUSH_WALK);
    sportWheelchairPushRun = WatchUi.loadResource(Rez.Strings.SPORT_WHEELCHAIR_PUSH_RUN);
    sportMeditation = WatchUi.loadResource(Rez.Strings.SPORT_MEDITATION);
    sportParaSport = WatchUi.loadResource(Rez.Strings.SPORT_PARA_SPORT);
    sportDiscGolf = WatchUi.loadResource(Rez.Strings.SPORT_DISC_GOLF);
    sportTeamSport = WatchUi.loadResource(Rez.Strings.SPORT_TEAM_SPORT);
    sportCricket = WatchUi.loadResource(Rez.Strings.SPORT_CRICKET);
    sportRugby = WatchUi.loadResource(Rez.Strings.SPORT_RUGBY);
    sportHockey = WatchUi.loadResource(Rez.Strings.SPORT_HOCKEY);
    sportLacrosse = WatchUi.loadResource(Rez.Strings.SPORT_LACROSSE);
    sportVolleyball = WatchUi.loadResource(Rez.Strings.SPORT_VOLLEYBALL);
    sportWaterTubing = WatchUi.loadResource(Rez.Strings.SPORT_WATER_TUBING);
    sportWakesurfing = WatchUi.loadResource(Rez.Strings.SPORT_WAKESURFING);
    sportInvalid = WatchUi.loadResource(Rez.Strings.SPORT_INVALID);
}

public function getTypesOfSport() as Void {
    var value = Storage.getValue("typesOfSport");
    if (value != null) {
        typesOfSport = value;
    }
}

public function setTypesOfSport(index as Number) {
    Storage.setValue("typesOfSport", index);
}