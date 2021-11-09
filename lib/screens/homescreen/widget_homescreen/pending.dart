import 'package:Dailoz/screens/process_taskscreen/process_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PendingWidget extends StatelessWidget {
  const PendingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProcessTask(processTitle: 'Pending'),
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
              const Color(0xff7D88E7),
              const Color(0xff7D88E7).withOpacity(0.74),
            ], // red to yellow
            // repeats the gradient over the canvas
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Positioned(
              top: 20.0,
              left: 20.0,
              child: SvgPicture.asset(
                'assets/image_svg/pending.svg',
                width: 40,
                height: 40,
              ),
            ),
            Positioned(
              top: 15.0,
              right: 15.0,
              child: SvgPicture.asset('assets/image_svg/arrow.svg',
                  width: 20, height: 20, color: Colors.white),
            ),
            const Positioned(
              bottom: 40.0,
              left: 20.0,
              child: Text(
                'Pending',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600),
              ),
            ),
            const Positioned(
                bottom: 20.0,
                left: 20.0,
                child: Text(
                  '15 Task',
                  style: TextStyle(
                      color: Colors.white,
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
