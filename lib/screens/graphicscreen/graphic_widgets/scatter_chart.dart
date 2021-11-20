/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-20 03:25:47
 ///  Description:
 */

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ScatChartWidget extends StatelessWidget {
  const ScatChartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: const Color(0xffE1E2E3),
      ),
      margin: const EdgeInsets.only(
          top: 15.0, left: 30.0, bottom: 15.0, right: 30.0),
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0, top: 15.0),
      height: MediaQuery.of(context).size.width - 60,
      child: Column(
        children: [
          Flexible(
            flex: 2,
            child: Row(
              children: [
                const Text(
                  'Priority',
                  style: TextStyle(
                    color: Color(0xff10275A),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                const SizedBox(width: 40),
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: const BoxDecoration(
                    color: Color(0xffE88B8C),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  'Personal',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12.0,
                    color: Color(0xff10275A),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: const BoxDecoration(
                    color: Color(0xff8F99EB),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  'Private',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12.0,
                    color: Color(0xff10275A),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: const BoxDecoration(
                    color: Color(0xff7EC8E7),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  'Secret',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12.0,
                    color: Color(0xff10275A),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          const Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Task Perday',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    color: Color(0xff8586A9)),
              ),
            ),
          ),
          Flexible(
            flex: 10,
            child: Container(
              margin: const EdgeInsets.only(top: 25.0, bottom: 0),
              height: 250,
              child: ScatterChart(
                ScatterChartData(
                  scatterSpots: [
                    ScatterSpot(
                      1,
                      2,
                      color: Colors.green,
                    ),
                    ScatterSpot(
                      1,
                      6,
                      color: Colors.yellow,
                      radius: 12,
                    ),
                    ScatterSpot(
                      4,
                      5,
                      color: Colors.purpleAccent,
                      radius: 8,
                    ),
                    ScatterSpot(
                      7,
                      6,
                      color: Colors.orange,
                      radius: 5,
                    ),
                    ScatterSpot(
                      5,
                      7,
                      color: Colors.brown,
                      radius: 14,
                    ),
                    ScatterSpot(
                      6,
                      2,
                      color: Colors.lightGreenAccent,
                      radius: 8,
                    ),
                    ScatterSpot(
                      3,
                      1,
                      color: Colors.red,
                      radius: 5,
                    ),
                    ScatterSpot(
                      2,
                      6,
                      color: Colors.tealAccent,
                      radius: 10,
                    ),
                  ],
                  minX: 0,
                  maxX: 8,
                  minY: 1,
                  maxY: 10,
                  borderData: FlBorderData(
                    show: false,
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: false,
                    checkToShowHorizontalLine: (value) => true,
                    getDrawingHorizontalLine: (value) =>
                        FlLine(color: Colors.white.withOpacity(0.1)),
                    drawVerticalLine: true,
                    checkToShowVerticalLine: (value) => true,
                    getDrawingVerticalLine: (value) => FlLine(
                        color: Colors.grey.withOpacity(0.5),
                        dashArray: [3],
                        strokeWidth: 0.5),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: SideTitles(
                      margin: 0,
                      showTitles: true,
                      interval: 1,
                      getTitles: (value) {
                        switch (value.toInt()) {
                          case 2:
                            return '02';
                          case 4:
                            return '04';
                          case 6:
                            return '06';
                          case 8:
                            return '08';
                          case 10:
                            return '10';
                        }
                        return '';
                      },
                    ),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      margin: 15,
                      getTitles: (value) {
                        switch (value.toInt()) {
                          case 1:
                            return 'Mo';
                          case 2:
                            return 'Tu';
                          case 3:
                            return 'We';
                          case 4:
                            return 'Th';
                          case 5:
                            return 'Fr';
                          case 6:
                            return 'Sa';
                          case 7:
                            return 'Su';
                        }
                        return '';
                      },
                    ),
                    topTitles: SideTitles(
                      showTitles: false,
                    ),
                    rightTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  scatterTouchData: ScatterTouchData(
                    enabled: true,
                    handleBuiltInTouches: false,
                    mouseCursorResolver: (FlTouchEvent touchEvent,
                        ScatterTouchResponse? response) {
                      return response == null || response.touchedSpot == null
                          ? MouseCursor.defer
                          : SystemMouseCursors.click;
                    },
                    touchTooltipData: ScatterTouchTooltipData(
                      tooltipBgColor: Colors.black,
                      getTooltipItems: (ScatterSpot touchedBarSpot) {
                        return ScatterTooltipItem(
                          'X: ',
                          textStyle: TextStyle(
                            height: 1.2,
                            color: Colors.grey[100],
                            fontStyle: FontStyle.italic,
                          ),
                          bottomMargin: 10,
                          children: [
                            TextSpan(
                              text: '${touchedBarSpot.x.toInt()} \n',
                              style: const TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'Y: ',
                              style: TextStyle(
                                height: 1.2,
                                color: Colors.grey[100],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextSpan(
                              text: touchedBarSpot.y.toInt().toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
