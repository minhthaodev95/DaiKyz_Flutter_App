import 'package:Dailoz/models/type_model.dart';
import 'package:flutter/material.dart';
import 'package:Dailoz/widgets/dot_navigation_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../dymmyData/data.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  List<TaskType> taskType = typeTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 52,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffF1F7FF),
                      offset: Offset(-3, 7.0), //(x,y)
                      blurRadius: 13.0,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                margin: const EdgeInsets.only(right: 24.0),
                child: SvgPicture.asset(
                  'assets/icons/more_horiz.svg',
                ),
              ),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffF1F7FF),
                    offset: Offset(-3, 7.0), //(x,y)
                    blurRadius: 13.0,
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 36,
                child: Image.asset('assets/images/avatar.png',
                    width: 78, height: 78),
                // backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12.0),
            const Text(
              'Minh Thao',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xff10275A),
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 12.0),
            const Text(
              'minhthao.dev95@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff10275A),
                fontWeight: FontWeight.normal,
                fontFamily: 'Roboto',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, left: 24.0, bottom: 15.0, right: 24.0),
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  shrinkWrap: true,
                  itemCount: (taskType.length + 1),
                  itemBuilder: (context, index) {
                    if (index == (taskType.length)) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffFFEFEB),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffF0A58E),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                height: 60,
                                width: 60,
                                child: const Icon(Icons.add_box_outlined),
                              ),
                              const SizedBox(height: 8.0),
                              const Text(
                                'Create Board',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff10275A),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ],
                          )),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: taskType[index].color,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: taskType[index].colorBackIcon,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                height: 60,
                                width: 60,
                                child: const Icon(Icons.work_outline_outlined),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                taskType[index].title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff10275A),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              RichText(
                                text: TextSpan(
                                  text: taskType[index].totalTask.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff393939),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                  ),
                                  children: const <TextSpan>[
                                    TextSpan(
                                        text: ' Task',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff393939),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto',
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ),
                      );
                    }
                  }),
            ),
          ],
        )),
      ),
      bottomNavigationBar: const BottomAppbar(currentIndex: 4),
      extendBody: true,
    );
  }
}
