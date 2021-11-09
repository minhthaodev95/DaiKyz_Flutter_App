import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:Dailoz/screens/graphicscreen/graphic_widgets/scatter_chart.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:Dailoz/widgets/dot_navigation_bar.dart';

class AnalyticScreen extends StatefulWidget {
  const AnalyticScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticScreen> createState() => _AnalyticScreenState();
}

class _AnalyticScreenState extends State<AnalyticScreen> {
  final Color dark = const Color(0xff3b8c75);
  final Color normal = const Color(0xff64caad);
  final Color light = const Color(0xff73e8c9);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text(
              'Graphic',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                color: Color(0xff10275A),
              ),
            ),
            const ScatChartWidget(),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Your Activity',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Color(0xff10275A),
                  ),
                ),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: const Color(0xffE1E2E3),
                ),
                margin: const EdgeInsets.all(30.0),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, bottom: 0, top: 15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 65,
                      child: TableCalendar(
                        shouldFillViewport: true,
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: DateTime.now(),
                        daysOfWeekVisible: false,
                        calendarFormat: CalendarFormat.week,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25.0, bottom: 0),
                      width: 300,
                      height: 200,
                      child: CustomPaint(
                        foregroundPainter: GraphPainter(),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppbar(currentIndex: 3),
    );
  }
}

class GraphPainter extends CustomPainter {
  //the one in the foreground
  Paint trackBarPaint = Paint()
    ..color = const Color(0xff818aab)
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 12;

  //the one in the background
  Paint trackPaint = Paint()
    ..color = const Color(0xffdee6f1)
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 12;

  @override
  void paint(Canvas canvas, Size size) {
    List val = [
      size.height * 0.2,
      size.height * 0.5,
      size.height * 0.9,
      size.height * 0.8,
      size.height * 0.5,
    ];
    double origin = 8;

    Path trackBarPath = Path();
    Path trackPath = Path();

    for (int i = 0; i < val.length; i++) {
      trackPath.moveTo(origin, size.height);
      trackPath.lineTo(origin, 0);

      trackBarPath.moveTo(origin, size.height);
      trackBarPath.lineTo(origin, val[i]);

      origin = origin + size.width * 0.22;
    }

    canvas.drawPath(trackPath, trackPaint);
    canvas.drawPath(trackBarPath, trackBarPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
