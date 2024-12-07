import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Communications;
import Toybox.Application.Storage;

class MainMenuDelegate extends WatchUi.MenuInputDelegate {
    private var _view as SoccerView;
    private var _recordsString as String;
    private var _resetString as String;
    private var _exitString as String;
    private var _startString as String;
    private var _stopString as String;
    private var _giveUpString as String;
    private var _homeString as String;
    private var _awayString as String;
    private var _noRecordsString as String;
    private var _teamName as String;
    private var _syncString as String;

    function initialize(view as SoccerView) {
        MenuInputDelegate.initialize();
        _view = view;
        _recordsString = WatchUi.loadResource($.Rez.Strings.Records) as String;
        _resetString = WatchUi.loadResource($.Rez.Strings.Reset) as String;
        _exitString = WatchUi.loadResource($.Rez.Strings.Exit) as String;
        _startString = WatchUi.loadResource($.Rez.Strings.Start) as String;
        _stopString = WatchUi.loadResource($.Rez.Strings.Stop) as String;
        _giveUpString = WatchUi.loadResource($.Rez.Strings.GiveUp) as String;
        _homeString = $.homeString;
        _awayString = $.awayString;
        _noRecordsString = WatchUi.loadResource($.Rez.Strings.NoRecords) as String;
        _teamName = WatchUi.loadResource($.Rez.Strings.TeamName) as String;
        _syncString = WatchUi.loadResource($.Rez.Strings.Sync) as String;
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :item_records) {
            System.println("Records");
            var recordsMenu = new WatchUi.Menu2({:title=>_recordsString});
            if ($.match_datas.size() > 0) {
                for (var i = 0; i < $.match_datas.size(); i++) {
                    var match_date = $.match_datas[i] as String;
                    recordsMenu.addItem(new WatchUi.MenuItem(match_date, null, null, null));
                }
                WatchUi.pushView(recordsMenu, new $.RecordsMenu2Delegate(), WatchUi.SLIDE_UP);
            } else {
                WatchUi.showToast(_noRecordsString, { :icon => null });
            }
        } else if (item == :item_team_name) {
            var title = $.getTeamNameString($.teamIndex);
            var teamNameMenu = new WatchUi.Menu2({:title=>title});
            teamNameMenu.addItem(new WatchUi.MenuItem($.homeAway, null, 0, null));
            teamNameMenu.addItem(new WatchUi.MenuItem($.team1Team2, null, 1, null));
            teamNameMenu.addItem(new WatchUi.MenuItem($.schoolStand, null, 2, null));
            WatchUi.pushView(teamNameMenu, new $.TeamNameMenu2Delegate(), WatchUi.SLIDE_UP);
        } else if (item == :item_types_of_sport) {
            var title = $.getTypesOfSportString($.typesOfSport);
            var typesOfSportMenu = new WatchUi.Menu2({:title=>title});
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportGeneric, null, Toybox.Activity.SPORT_GENERIC, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportRunning, null, Toybox.Activity.SPORT_RUNNING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportCycling, null, Toybox.Activity.SPORT_CYCLING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportTransition, null, Toybox.Activity.SPORT_TRANSITION, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportFitnessEquipment, null, Toybox.Activity.SPORT_FITNESS_EQUIPMENT, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportSwimming, null, Toybox.Activity.SPORT_SWIMMING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportBasketball, null, Toybox.Activity.SPORT_BASKETBALL, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportSoccer, null, Toybox.Activity.SPORT_SOCCER, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportTennis, null, Toybox.Activity.SPORT_TENNIS, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportAmericanFootball, null, Toybox.Activity.SPORT_AMERICAN_FOOTBALL, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportTraining, null, Toybox.Activity.SPORT_TRAINING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportWalking, null, Toybox.Activity.SPORT_WALKING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportCrossCountrySkiing, null, Toybox.Activity.SPORT_CROSS_COUNTRY_SKIING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportAlpineSkiing, null, Toybox.Activity.SPORT_ALPINE_SKIING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportSnowboarding, null, Toybox.Activity.SPORT_SNOWBOARDING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportRowing, null, Toybox.Activity.SPORT_ROWING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportMountaineering, null, Toybox.Activity.SPORT_MOUNTAINEERING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportHiking, null, Toybox.Activity.SPORT_HIKING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportMultisport, null, Toybox.Activity.SPORT_MULTISPORT, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportPaddling, null, Toybox.Activity.SPORT_PADDLING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportFlying, null, Toybox.Activity.SPORT_FLYING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportEBiking, null, Toybox.Activity.SPORT_E_BIKING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportMotorcycling, null, Toybox.Activity.SPORT_MOTORCYCLING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportBoating, null, Toybox.Activity.SPORT_BOATING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportDriving, null, Toybox.Activity.SPORT_DRIVING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportGolf, null, Toybox.Activity.SPORT_GOLF, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportHangGliding, null, Toybox.Activity.SPORT_HANG_GLIDING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportHorsebackRiding, null, Toybox.Activity.SPORT_HORSEBACK_RIDING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportHunting, null, Toybox.Activity.SPORT_HUNTING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportFishing, null, Toybox.Activity.SPORT_FISHING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportInlineSkating, null, Toybox.Activity.SPORT_INLINE_SKATING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportRockClimbing, null, Toybox.Activity.SPORT_ROCK_CLIMBING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportSailing, null, Toybox.Activity.SPORT_SAILING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportIceSkating, null, Toybox.Activity.SPORT_ICE_SKATING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportSkyDiving, null, Toybox.Activity.SPORT_SKY_DIVING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportSnowshoeing, null, Toybox.Activity.SPORT_SNOWSHOEING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportSnowmobiling, null, Toybox.Activity.SPORT_SNOWMOBILING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportStandUpPaddleboarding, null, Toybox.Activity.SPORT_STAND_UP_PADDLEBOARDING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportSurfing, null, Toybox.Activity.SPORT_SURFING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportWakeboarding, null, Toybox.Activity.SPORT_WAKEBOARDING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportWaterSkiing, null, Toybox.Activity.SPORT_WATER_SKIING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportKayaking, null, Toybox.Activity.SPORT_KAYAKING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportRafting, null, Toybox.Activity.SPORT_RAFTING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportWindsurfing, null, Toybox.Activity.SPORT_WINDSURFING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportKitesurfing, null, Toybox.Activity.SPORT_KITESURFING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportTactical, null, Toybox.Activity.SPORT_TACTICAL, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportJumpmaster, null, Toybox.Activity.SPORT_JUMPMASTER, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportBoxing, null, Toybox.Activity.SPORT_BOXING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportFloorClimbing, null, Toybox.Activity.SPORT_FLOOR_CLIMBING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportBaseball, null, Toybox.Activity.SPORT_BASEBALL, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportSoftballFastPitch, null, Toybox.Activity.SPORT_SOFTBALL_FAST_PITCH, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportSoftballSlowPitch, null, Toybox.Activity.SPORT_SOFTBALL_SLOW_PITCH, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportShooting, null, Toybox.Activity.SPORT_SHOOTING, null));
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportAutoRacing, null, Toybox.Activity.SPORT_AUTO_RACING, null));

            if (Toybox.Activity has :SPORT_WINTER_SPORT) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportWinterSport, null, Toybox.Activity.SPORT_WINTER_SPORT, null));
            }

            if (Toybox.Activity has :SPORT_GRINDING) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportGrinding, null, Toybox.Activity.SPORT_GRINDING, null));
            }

            if (Toybox.Activity has :SPORT_HEALTH_MONITORING) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportHealthMonitoring, null, Toybox.Activity.SPORT_HEALTH_MONITORING, null));
            }

            if (Toybox.Activity has :SPORT_MARINE) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportMarine, null, Toybox.Activity.SPORT_MARINE, null));
            }

            if (Toybox.Activity has :SPORT_HIIT) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportHIIT, null, Toybox.Activity.SPORT_HIIT, null));
            }

            if (Toybox.Activity has :SPORT_VIDEO_GAMING) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportVideoGaming, null, Toybox.Activity.SPORT_VIDEO_GAMING, null));
            }

            if (Toybox.Activity has :SPORT_RACKET) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportRacket, null, Toybox.Activity.SPORT_RACKET, null));
            }

            if (Toybox.Activity has :SPORT_WHEELCHAIR_PUSH_WALK) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportWheelchairPushWalk, null, Toybox.Activity.SPORT_WHEELCHAIR_PUSH_WALK, null));
            }

            if (Toybox.Activity has :SPORT_WHEELCHAIR_PUSH_RUN) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportWheelchairPushRun, null, Toybox.Activity.SPORT_WHEELCHAIR_PUSH_RUN, null));
            }

            if (Toybox.Activity has :SPORT_MEDITATION) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportMeditation, null, Toybox.Activity.SPORT_MEDITATION, null));
            }

            if (Toybox.Activity has :SPORT_PARA_SPORT) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportParaSport, null, Toybox.Activity.SPORT_PARA_SPORT, null));
            }

            if (Toybox.Activity has :SPORT_DISC_GOLF) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportDiscGolf, null, Toybox.Activity.SPORT_DISC_GOLF, null));
            }

            if (Toybox.Activity has :SPORT_TEAM_SPORT) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportTeamSport, null, Toybox.Activity.SPORT_TEAM_SPORT, null));
            }

            if (Toybox.Activity has :SPORT_CRICKET) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportCricket, null, Toybox.Activity.SPORT_CRICKET, null));
            }

            if (Toybox.Activity has :SPORT_RUGBY) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportRugby, null, Toybox.Activity.SPORT_RUGBY, null));
            }

            if (Toybox.Activity has :SPORT_HOCKEY) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportHockey, null, Toybox.Activity.SPORT_HOCKEY, null));
            }

            if (Toybox.Activity has :SPORT_LACROSSE) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportLacrosse, null, Toybox.Activity.SPORT_LACROSSE, null));
            }

            if (Toybox.Activity has :SPORT_VOLLEYBALL) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportVolleyball, null, Toybox.Activity.SPORT_VOLLEYBALL, null));
            }

            if (Toybox.Activity has :SPORT_WATER_TUBING) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportWaterTubing, null, Toybox.Activity.SPORT_WATER_TUBING, null));
            }

            if (Toybox.Activity has :SPORT_WAKESURFING) {
                typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportWakesurfing, null, Toybox.Activity.SPORT_WAKESURFING, null));
            }
            typesOfSportMenu.addItem(new WatchUi.MenuItem($.sportInvalid, null, Toybox.Activity.SPORT_INVALID, null));
            WatchUi.pushView(typesOfSportMenu, new $.TypesOfSportMenu2Delegate(), WatchUi.SLIDE_UP);
        } else if (item == :item_reset) {
            $.pushComfirmDialog(_resetString, true);
        } else if (item == :item_exit) {
            $.pushComfirmDialog(_exitString, false);
        } else if (item == :item_sync) {
            if (Toybox.Communications has :transmit) {
                var data = {
                    "match_datas" => $.match_datas,
                    "records" => {}
                };
                
                for (var i = 0; i < $.match_datas.size(); i++) {
                    var matchDate = $.match_datas[i];
                    var matchRecord = Storage.getValue(matchDate);
                    if (matchRecord != null) {
                        data.get("records").put(matchDate, matchRecord);
                    }
                }

                Communications.transmit(data, null, new CommListener());
                WatchUi.showToast(_syncString, { :icon => null });
            }
        }
    }

    private function showReport() as Void {
        var records = $.match_records;
        var start_time = "";
        var stop_time = "";
        var home_goal = "";
        var away_goal = "";
        var title = "";
        var home_goals = 0;
        var away_goals = 0;
        var mainMenu = new WatchUi.Menu2({:title=>""});

        for (var i = 0; i < records.size(); i++) {
            var record = records[i] as Dictionary<String, String>;
            if (record.hasKey("start_time")) {
                var value = record.get("start_time");
                var index = value.find(" ");
                start_time = value.substring(index+1, null);
                mainMenu.addItem(new WatchUi.MenuItem(start_time, _startString, null, null));
            } else if (record.hasKey("stop_time")) {
                var value = record.get("stop_time");
                var index = value.find(" ");
                stop_time = value.substring(index+1, null);
                mainMenu.addItem(new WatchUi.MenuItem(stop_time, _stopString, null, null));
            } else if (record.hasKey("home_goal")) {
                var value = record.get("home_goal");
                var index = value.find(" ");
                home_goal = value.substring(index+1, null);
                mainMenu.addItem(new WatchUi.MenuItem(home_goal, _homeString, null, null));
                home_goals += 1;
            } else if (record.hasKey("away_goal")) {
                var value = record.get("away_goal");
                var index = value.find(" ");
                away_goal = value.substring(index+1, null);
                mainMenu.addItem(new WatchUi.MenuItem(away_goal, _awayString, null, null));
                away_goals += 1;
            }
        }
        title = home_goals + " - " + away_goals;
        mainMenu.setTitle(title);
        WatchUi.pushView(mainMenu, new $.RecordsMenu2DetailDelegate(records), WatchUi.SLIDE_UP);
    }
}

class CommListener extends Communications.ConnectionListener {
    function initialize() {
        ConnectionListener.initialize();
    }

    function onComplete() {
        WatchUi.showToast("同步完成", { :icon => null });
    }

    function onError() {
        WatchUi.showToast("同步失败", { :icon => null });
    }
}