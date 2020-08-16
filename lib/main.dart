import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'constants.dart';
import 'models/covid19_model.dart';
import 'utils/assets_utils.dart';
import 'widgets/animated_entrance_widget.dart';
import 'widgets/summary_item.dart';

final random = math.Random();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

List<String> typeCase = ['active', 'recovered', 'death'];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AfterLayoutMixin<MyHomePage> {
  bool animationFinish = false;
  Covid19Model covid19Data = Covid19Model().loading();
  GlobalKey hilightActive = GlobalKey();
  GlobalKey hilightDeath = GlobalKey();
  GlobalKey hilightRecovered = GlobalKey();
  bool isError = false;
  bool isLoading = true;
  GlobalKey summaryActive = GlobalKey();
  GlobalKey summaryDeath = GlobalKey();
  GlobalKey summaryRecovered = GlobalKey();

  double _active = 100, _recovered = 0, _lost = 0;
  final AssetsUtils _assetsUtils = AssetsUtils.getInstance();
  final TextStyle _titleStyle = new TextStyle(
    fontSize: 22,
    color: Colors.white,
  );

  @override
  void afterFirstLayout(BuildContext context) async {
    await fetchData();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<Covid19Model> fetchData() async {
    setState(() {
      isLoading = true;
      isError = false;
      covid19Data = Covid19Model().loading();
    });
    try {
      var res = await http.get('https://covid19.mathdro.id/api/');
      var data = Covid19Model.fromRawJson(res.body);
      setState(() {
        covid19Data = data;
        isLoading = false;
        isError = false;
      });
      initData();
      return data;
    } catch (e) {
      log('Fetch Data Error', error: e.toString());
      setState(() {
        covid19Data = Covid19Model().loading();
        isLoading = false;
        isError = true;
      });

      return null;
    }
  }

  void initData() async {
    if (covid19Data.confirmed.value == null ||
        covid19Data.recovered.value == null ||
        covid19Data.deaths.value == null) return;

    setState(() {
      num total = covid19Data.confirmed.value;
      num lost = covid19Data.deaths.value;
      num recovered = covid19Data.recovered.value;

      _active = 100 * ((total - lost - recovered) / total);
      _lost = 100 * (lost / total);
      _recovered = 100 * (recovered / total);

      double sum = _active + _lost + _recovered;
      if (sum < 100) _active = 100 - sum;
    });
  }

  Widget _buildSummaryText() {
    TextStyle style = TextStyle(
        fontSize: 32, color: Color(0xff36405e), fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 20, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: isLoading
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  'COVID-19 🌍',
                  style: style,
                  textAlign: isLoading ? TextAlign.center : TextAlign.start,
                ),
                if (!isLoading)
                  FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      ' Last Update: ' +
                          DateFormat.yMMMd().add_jm().format(
                                covid19Data.lastUpdate.toLocal(),
                              ),
                      maxLines: 1,
                    ),
                  ),
              ],
            ),
          ),
          if (!isLoading) Spacer(),
          if (!isLoading)
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Color(0xff36405e),
              ),
              onPressed: () {
                fetchData();
              },
            ),
        ],
      ),
    );
  }

  Widget _buildTotalCases() {
    return SummaryItem(
      startColor: Color(0xff676ef6),
      endColor: Color(0xff8ba4f8),
      title:
          '${(covid19Data.confirmed.value / 1000000).toStringAsFixed(1)} Million',
      subtitle: 'Confirmed',
      icon: 'people',
    );
  }

  Widget _buildRecoveredCases() {
    return SummaryItem(
      startColor: Color(0xff62a340),
      endColor: Color(0xff9fde78),
      // title: covid19Data.recovered.value.toString(),
      title:
          '${(covid19Data.recovered.value / 1000000).toStringAsFixed(1)} Million',
      subtitle: 'Recovered ${_recoveredPercent()}%',
      icon: 'plus',
    );
  }

  Widget _buildLostPeople() {
    return SummaryItem(
      startColor: Color(0xff36405e),
      endColor: Color(0xff5a668a),
      // title: covid19Data.deaths.value.toString(),
      title:
          '${(covid19Data.deaths.value / 100000).toStringAsFixed(1)} Million',
      subtitle: 'Deaths',
      icon: 'death',
    );
  }

  int _recoveredPercent() {
    // return (18).floor();
    return (100 *
            covid19Data.recovered.value /
            (covid19Data.confirmed.value - covid19Data.deaths.value))
        .floor();
  }

  Gradient _getCardGradient({
    startColor = const Color(0xff676ef6),
    endColor = const Color(0xff8ba4f8),
  }) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
      colors: [startColor, endColor],
    );
  }

  Widget _buildGWidget(top, activeString, Color startColor, Color endColor,
      GlobalKey type, int index) {
    return Positioned.fill(
      top: top ?? 0.0,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: _getCardGradient(
                startColor: startColor ?? Color(0xff78ebff),
                endColor: endColor ?? Color(0xff8fefff),
              ),
            ),
          ),
          Positioned(
            // alignment: Alignment.topRight,
            top: index == 2 ? 0 : 20,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 8, vertical: index == 2 ? 0 : 4),
              child: Text(
                '$activeString%',
                style: _titleStyle,
              ),
            ),
          ),
          Positioned(
            // alignment: Alignment.topRight,
            // right: 20,
            child: LayoutBuilder(builder: (context, constraints) {
              final double rndleft = random.nextInt(4) * 0.1;
              final double rndTop = random.nextInt(3) * 0.1;
              return Padding(
                padding: new EdgeInsets.only(
                  top: constraints.biggest.height * .2,
                  left: constraints.biggest.width * (1 - .4),
                ),
                child: Container(
                  key: type,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  width: 18,
                  height: 18,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var isTablet = AnimatedRoutes.isTablet(MediaQuery.of(context));
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildSummaryText(),
                if (isLoading) CupertinoActivityIndicator(radius: 16),
                if (!isLoading)
                  Expanded(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Expanded(
                                flex: isTablet ? 2 : 3,
                                child: AnimatedEntranceWidget(
                                  offsetStart: 0.2,
                                  offsetEnd: 1,
                                  child: LayoutBuilder(
                                    builder: (BuildContext context,
                                        BoxConstraints constraints) {
                                      var topDeath = constraints.maxHeight -
                                          ((covid19Data.deaths.value *
                                                  constraints.maxHeight) /
                                              covid19Data.confirmed.value);
                                      var topRecovered = constraints.maxHeight -
                                          ((covid19Data.recovered.value *
                                                  constraints.maxHeight) /
                                              covid19Data.confirmed.value);
                                      String activeString =
                                          _active.floor().toString();
                                      String recoveredString =
                                          _recovered.floor().toString();
                                      String lostString =
                                          _lost.floor().toString();

                                      return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: Stack(
                                          children: [
                                            _buildGWidget(
                                                0.0,
                                                activeString,
                                                Color(0xff7a78ff),
                                                Color(0xff7a78f0),
                                                hilightActive,
                                                0),
                                            _buildGWidget(
                                                topRecovered,
                                                recoveredString,
                                                Color(0xff62a340),
                                                Color(0xff9bde78),
                                                hilightRecovered,
                                                1),
                                            _buildGWidget(
                                                topDeath,
                                                lostString,
                                                Color(0xff36405e),
                                                Color(0xff5a668a),
                                                hilightDeath,
                                                2),
                                            Positioned.fill(
                                              child: Image.network(
                                                'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f4/Human_body_silhouette.svg/970px-Human_body_silhouette.svg.png',
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 100,
                                      key: summaryActive,
                                      child: AnimatedEntranceWidget(
                                        child: _buildTotalCases(),
                                        offsetStart: -0.5,
                                        offsetEnd: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      key: summaryRecovered,
                                      height: 100,
                                      child: AnimatedEntranceWidget(
                                        child: _buildRecoveredCases(),
                                        offsetStart: -0.5,
                                        offsetEnd: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      key: summaryDeath,
                                      height: 100,
                                      child: AnimatedEntranceWidget(
                                        child: _buildLostPeople(),
                                        offsetStart: -0.5,
                                        offsetEnd: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Spacer(),
                                    Image.asset(
                                      _assetsUtils.getPNGImagePath('thanks'),
                                      fit: BoxFit.contain,
                                    ),

                                    FittedBox(
                                      fit: BoxFit.cover,
                                      child: Text(
                                        'Api: https://covid19.mathdro.id',
                                        style: TextStyle(
                                          color: Color(0xff36405e),
                                        ),
                                      ),
                                    ),

                                    FittedBox(
                                      fit: BoxFit.cover,
                                      child: Text(
                                        'Docs: https://flutter.dev/docs',
                                        style: TextStyle(
                                          color: Color(0xff36405e),
                                        ),
                                      ),
                                    ),

                                    FittedBox(
                                      fit: BoxFit.cover,
                                      child: Text(
                                        'Model: https://app.quicktype.io',
                                        style: TextStyle(
                                          color: Color(0xff36405e),
                                        ),
                                      ),
                                    ),

                                    FittedBox(
                                      fit: BoxFit.cover,
                                      child: Text(
                                        'https://github.com/duythien0912',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),

                                    // SummaryChart(
                                    //   totalCases:
                                    //       covid19Data.confirmed.value.toString(),
                                    //   totalDeath:
                                    //       covid19Data.recovered.value.toString(),
                                    //   totalRecovery:
                                    //       covid19Data.deaths.value.toString(),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // if (animationFinish)
                        Positioned.fill(
                          child: CustomPaint(
                            painter: MyPainter(
                              hilightActive: hilightActive,
                              hilightRecovered: hilightRecovered,
                              hilightDeath: hilightDeath,
                              summaryActive: summaryActive,
                              summaryRecovered: summaryRecovered,
                              summaryDeath: summaryDeath,
                            ),
                            child: Container(),
                          ),
                        ),
                        // Lottie.asset('lib/imgs/home_swipe_up.json'),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter({
    Key key,
    this.hilightActive,
    this.hilightRecovered,
    this.hilightDeath,
    this.summaryActive,
    this.summaryRecovered,
    this.summaryDeath,
  });

  final GlobalKey hilightActive;
  final GlobalKey hilightDeath;
  final GlobalKey hilightRecovered;
  final GlobalKey summaryActive;
  final GlobalKey summaryDeath;
  final GlobalKey summaryRecovered;

  // : super(this.key: key);

  //         <-- CustomPainter class
  @override
  void paint(Canvas canvas, Size size) async {
    //                                             <-- Insert your painting code here.
    // await Future.delayed(Duration(milliseconds: 300));

    RenderBox box1 = hilightActive.currentContext.findRenderObject();
    Offset position1 =
        box1.localToGlobal(Offset.zero); //this is global position
    double y1 = position1.dy; //this is y - I think it's what you want
    double x1 = position1.dx; //this is y - I think it's what you want
    print(
      'x1: $x1',
    );
    print(
      'y1: $y1',
    );
    RenderBox box2 = hilightRecovered.currentContext.findRenderObject();
    Offset position2 =
        box2.localToGlobal(Offset.zero); //this is global position
    double y2 = position2.dy; //this is y - I think it's what you want
    double x2 = position2.dx; //this is y - I think it's what you want
    print(
      'x1: $x2',
    );
    print(
      'y1: $y2',
    );
    RenderBox box3 = hilightDeath.currentContext.findRenderObject();
    Offset position3 =
        box3.localToGlobal(Offset.zero); //this is global position
    double y3 = position3.dy; //this is y - I think it's what you want
    double x3 = position3.dx; //this is y - I think it's what you want
    print(
      'x1: $x3',
    );
    print(
      'y1: $y3',
    );

    RenderBox boxS1 = summaryActive.currentContext.findRenderObject();
    Offset positionS1 =
        boxS1.localToGlobal(Offset.zero); //this is global position
    double ys1 = positionS1.dy; //this is y - I think it's what you want
    double xs1 = positionS1.dx; //this is y - I think it's what you want
    print(
      'xs1: $xs1',
    );
    print(
      'ys1: $ys1',
    );

    RenderBox boxS2 = summaryRecovered.currentContext.findRenderObject();
    Offset positionS2 =
        boxS2.localToGlobal(Offset.zero); //this is global position
    double ys2 = positionS2.dy; //this is y - I think it's what you want
    double xs2 = positionS2.dx; //this is y - I think it's what you want
    print(
      'xs2: $xs2',
    );
    print(
      'ys2: $ys2',
    );

    RenderBox boxS3 = summaryDeath.currentContext.findRenderObject();
    Offset positionS3 =
        boxS3.localToGlobal(Offset.zero); //this is global position
    double ys3 = positionS3.dy; //this is y - I think it's what you want
    double xs3 = positionS3.dx; //this is y - I think it's what you want
    print(
      'xs3: $xs3',
    );
    print(
      'ys3: $ys3',
    );

    final pointMode = ui.PointMode.polygon;
    final points1 = [
      Offset(x1, y1 - 70),
      Offset(x1 + x1 / 5, ys1 - 16),

      // Offset(x2, y2),
      // Offset(x3, y3),
      Offset(xs1, ys1 - 20),
      // Offset(xs2, ys2),
      // Offset(xs3, ys3),
    ];
    final points2 = [
      // Offset(x1, y1),
      Offset(x2, y2 - 70),
      Offset(x2 + x2 / 5, ys2 - 16),
      // Offset(x3, y3),
      // Offset(xs1, ys1),
      Offset(xs2, ys2 - 20),
      // Offset(xs3, ys3),
    ];

    final points3 = [
      // Offset(x1, y1),
      // Offset(x2, y2),
      Offset(x3, y3 - 70),
      Offset(x3 + x3 / 5, ys3 - 16),
      // Offset(xs1, ys1),
      // Offset(xs2, ys2),
      Offset(xs3, ys3 - 20),
    ];

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points1, paint);
    canvas.drawPoints(pointMode, points2, paint);
    canvas.drawPoints(pointMode, points3, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
