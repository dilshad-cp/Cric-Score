import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:score_calculator_app/utils/button_calculator.dart';
import 'package:score_calculator_app/values/color_assets.dart';
import 'package:score_calculator_app/values/dimens.dart';
import 'splash.dart';
void main() =>
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: ColorAssets.primarySwatchColor),
        home: new SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/HomeScreen': (BuildContext context) => MainApp()
        },
      ));
    });

class MainApp extends StatefulWidget {
  @override
  MainAppState createState() => MainAppState();
}


class PopupMenuItems{
  static const String FirstItem = 'Reset';

  static const List<String> choices = <String>[
    FirstItem
  ];
}

class MainAppState extends State<MainApp> {
  final double _buttonFontSizeConverter = 16.0;
  final double _buttonOpacityConverter = 0.5;
  final double _imageSizeConverter = 36.0;
  final double _borderWidthConverter = 0.5;
  final String _titleAppBar = "Score Calculator";

  final Color _buttonColorWhite = Colors.white;
  final Color _textColorGrey = Colors.grey;
  final Color _borderColorConverter = Colors.grey[200];

  double valueA;
  double valueB;
  var sbValue = new StringBuffer();
  var overValue = new StringBuffer();
  var runrateValue = new StringBuffer();
  int balls = 0;
  int lbRuns = 0;
  int lbRunsLock = 0;
  String operator;
  List<String> ballByBall = [];
  String lastBallStat = '';
  String currentBallStat = '';
  bool hasWicket = false;
  

  VoidNavigate _appendSbValue(int number) {
    setState(() {
      bool isDoCalculate = true;
      String strValue = sbValue.toString();
      int intValue = int.parse(strValue);
      int total = intValue;
      // debugPrint(number.toString());
      lbRuns += number;
      total = total + number;
      sbValue.clear();
      sbValue.write(total);
      _calculateRunrate();
      currentBallStat = currentBallStat + number.toString()+' ';
    });
  }

  VoidNavigate _addWicket() {
    _appendSbValue(-5);
    setState(() {
      hasWicket = true;
    });
  }
  
   VoidCallback _countOverValue(){
    setState(() {
      operator = "";
      balls += 1 ;
      int iBalls = ( balls ~/ 6 );
      String oversStr = iBalls.toString() + '.' + ( balls - ( 6 * iBalls )).toString();
      overValue.clear();
      overValue.write(oversStr);
      _calculateRunrate();
      lbRunsLock = lbRuns;
      lastBallStat = lbRunsLock.toString();
      if(hasWicket){
        lastBallStat += ' (W)';
      }
      
      ballByBall.add(lastBallStat);
      if(balls % 6 == 0){
        ballByBall.add('End of Over - ' + oversStr);
      }
      lbRuns = 0;
      currentBallStat = '';
      hasWicket = false;
    });
  }

  VoidCallback _undoToLastBall(){
    setState(() {
        balls -= 1 ;
        int iBalls = ( balls ~/ 6 );
        String oversStr = iBalls.toString() + '.' + ( balls - ( 6 * iBalls )).toString();
        overValue.clear();
        overValue.write(oversStr);

        String strValue = sbValue.toString();
        int intValue = int.parse(strValue);
        int total = intValue;
        // debugPrint(number.toString());
        total = total - lbRunsLock;
        sbValue.clear();
        sbValue.write(total);

        _calculateRunrate();
        lbRunsLock = 0;
        lbRuns = 0;
        int overMod = balls % 6;
        if(iBalls == 0){
          iBalls = 1;
        }
        if(overMod  == 5){
          ballByBall.remove(ballByBall.remove('End of Over - ' + iBalls.toDouble().toStringAsFixed(1)));
        }
        ballByBall.remove(lastBallStat);
    });
  }

  void menuChoiceAction(String choice){
    if (choice == PopupMenuItems.FirstItem) {
       _clearSbValue();
    }
  }

  VoidCallback _calculateRunrate(){

    String strValueOvers = overValue.toString();
    double currentOvers = double.parse(strValueOvers);
    double currentRuns = double.parse(sbValue.toString());
    double rrCurrent = 0.00;
    if(currentOvers > 0){
        rrCurrent = ( currentRuns * 6 ) / balls;
    }
    String strCurrent = rrCurrent.toStringAsFixed(2);
    runrateValue.clear();
    runrateValue.write(strCurrent);
  }

  VoidCallback _deleteSbValue() {
    setState(() {
      String strValue = sbValue.toString();
      if (strValue.length > 0) {
        String lastCharacter = strValue.substring(strValue.length - 1);
        if (lastCharacter == "/" ||
            lastCharacter == "x" ||
            lastCharacter == "-" ||
            lastCharacter == "+") {
          operator = "";
        }
        strValue = strValue.substring(0, strValue.length - 1);
        sbValue.clear();
        sbValue.write(strValue.length == 0 ? "0" : strValue);
      }
    });
  }

  VoidCallback _clearSbValue() {
    setState(() {
      operator = "";
      sbValue.clear();
      sbValue.write("0");

      overValue.clear();
      overValue.write("0.0");

      balls = 0;

      runrateValue.clear();
      runrateValue.write("0.0");

      ballByBall = [];

    });
  }

  @override
  void initState() {
    super.initState();
    sbValue.write("0");
    overValue.write("0.0");
    runrateValue.write("0.0");
    balls = 0;
    operator = "";
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: buildAppBar(),
        body: buildTabBar(),
        // drawer: Drawer()
      ),
    );
  }

  buildAppBar() {
    return AppBar(
      title: Text(
        _titleAppBar,
        style: TextStyle(
          color: ColorAssets.titleAppBarColor,
        ),
      ),
      bottom: TabBar(
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        tabs: <Widget>[
          Tab(text: "Score"),
          Tab(text: "Stats"),
        ],
      ),
      actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: menuChoiceAction,
            itemBuilder: (BuildContext context) {
              return PopupMenuItems.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
      ]
    );
  }

  buildTabBar() {
    return TabBarView(
      children: <Widget>[
        buildCalculatorLayout(),
        buildConverterLayout(),
      ],
    );
  }

  buildConverterLayout() {
    var mediaQueryData = MediaQuery.of(context);

    final double statusBarHeight = mediaQueryData.padding.top;
    final double bottomBarHeight = mediaQueryData.padding.bottom;
    final double barHeight = statusBarHeight + bottomBarHeight;
    final double appBarHeight = kToolbarHeight + kTextTabBarHeight;
    final double itemWidth = mediaQueryData.size.width / 3;
    final double itemHeight =
        (mediaQueryData.size.height - appBarHeight - barHeight) / 3;

    return SafeArea(
      bottom: false,
      child: GridView.count(
        childAspectRatio: (itemWidth / itemHeight),
        crossAxisCount: 3,
        controller: ScrollController(keepScrollOffset: false),
        shrinkWrap: true
      ),
    );
  }

  buildCalculatorLayout() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.all(Dimens.padding16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    sbValue.toString(),
                    style: Theme.of(context).textTheme.display4,
                    maxLines: 1,
                  ),
                  AutoSizeText(
                    'RR : ' + runrateValue.toString(),
                    style: Theme.of(context).textTheme.subhead,
                    maxLines: 1,
                  ),
                  AutoSizeText(
                    'Overs : ( ' + overValue.toString() + ' )',
                    style: Theme.of(context).textTheme.subhead,
                    maxLines: 1,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex : 1,
            child : new ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: ballByBall.length, itemBuilder: (context, index) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0, top: 1.0, right: 2.0, bottom: 1.0),
                    child:Card(
                    child: Container(
                      padding: const EdgeInsets.only(left: 5.0, top: 1.0, right: 5.0, bottom: 1.0),
                      child: Center(child: Text(ballByBall[index].toString(), style: TextStyle(color: Colors.black, fontSize: 16.0),)),
                    ),
                  ),
                  )
                );
            })
          ),
          Expanded(
            flex: 9,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: ButtonCalculator(
                          "general",
                          actionOnPressedWithParameter: (int value) {
                            _appendSbValue(value);
                          },
                          valueActionOnPressedWithParameter: 0,
                          label: "0",
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ButtonCalculator(
                          "general",
                          actionOnPressedWithParameter: (int value) {
                            _appendSbValue(value);
                          },
                          valueActionOnPressedWithParameter: 1,
                          label: "1",
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ButtonCalculator(
                          "general",
                          actionOnPressedWithParameter: (int value) {
                            _appendSbValue(value);
                          },
                          valueActionOnPressedWithParameter:  2,
                          label: "2",
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ButtonCalculator(
                          "reset",
                          actionOnPressed: _undoToLastBall
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: ButtonCalculator(
                          "general",
                          actionOnPressedWithParameter: (int value) {
                            _appendSbValue(value);
                          },
                          valueActionOnPressedWithParameter: 3,
                          label: "3",
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ButtonCalculator(
                          "general",
                          actionOnPressedWithParameter: (int value) {
                            _appendSbValue(value);
                          },
                          valueActionOnPressedWithParameter: 5,
                          label: "5",
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ButtonCalculator(
                          "general",
                          actionOnPressedWithParameter: (int value) {
                            _appendSbValue(value);
                          },
                          valueActionOnPressedWithParameter: 7,
                          label: "7",
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ButtonCalculator(
                          "out",
                          actionOnPressed: _addWicket
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                        Expanded(
                        flex: 1,
                        child: ButtonCalculator(
                            "countball",
                            actionOnPressed: _countOverValue
                        ),
                        ),
                    ],
                    ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: ButtonCalculator(
                          "warning",
                          actionOnPressedWithParameter: (int value) {
                            _appendSbValue(value);
                          },
                          valueActionOnPressedWithParameter: 2,
                          label: "WD",
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ButtonCalculator(
                          "warning",
                          actionOnPressedWithParameter: (int value) {
                            _appendSbValue(value);
                          },
                          valueActionOnPressedWithParameter: 2,
                          label: "NB",
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ButtonCalculator(
                          "warning",
                          actionOnPressedWithParameter: (int value) {
                            _appendSbValue(value);
                          },
                          valueActionOnPressedWithParameter: 1,
                          label: "RB",
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildContainerMenuConverter(
      Key key, String pathImage, String labelMenu) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        color: _buttonColorWhite,
        border: Border.all(
          color: _borderColorConverter,
          width: _borderWidthConverter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(Dimens.padding16),
            child: Opacity(
              opacity: _buttonOpacityConverter,
              child: Image.asset(
                pathImage,
                width: _imageSizeConverter,
                height: _imageSizeConverter,
              ),
            ),
          ),
          Text(
            labelMenu,
            style: TextStyle(
              color: _textColorGrey,
              fontSize: _buttonFontSizeConverter,
            ),
          )
        ],
      ),
    );
  }
}
