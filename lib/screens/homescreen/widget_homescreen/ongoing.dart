/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-20 03:26:07
 ///  Description:
 */

import 'package:Dailoz/screens/process_taskscreen/process_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnGoingWidget extends StatelessWidget {
  const OnGoingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProcessTask(processTitle: 'Ongoing'),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment
                .topRight, // 10% of the width, so there are ten blinds.
            colors: <Color>[
              const Color(0xff81E89E),
              const Color(0xff81E89E).withOpacity(0.35),
            ], // red to yellow
            // repeats the gradient over the canvas
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Positioned(
              top: 10.0,
              left: 10.0,
              child: Image.asset('assets/images/folder.png', scale: 1),
            ),
            Positioned(
              top: 15.0,
              right: 15.0,
              child: SvgPicture.asset('assets/image_svg/arrow.svg',
                  width: 20, height: 20, color: const Color(0xff12175E)),
            ),
            const Positioned(
              bottom: 40.0,
              left: 20.0,
              child: Text(
                'On Going',
                style: TextStyle(
                    color: Color(0xff12175E),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600),
              ),
            ),
            const Positioned(
                bottom: 20.0,
                left: 20.0,
                child: Text(
                  '66 Task',
                  style: TextStyle(
                      color: Color(0xff12175E),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal),
                )),
          ],
        ),
      ),
    );
  }
}
