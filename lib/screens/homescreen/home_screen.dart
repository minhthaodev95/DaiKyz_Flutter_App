import 'package:Dailoz/dymmyData/task_data.dart';
import 'package:flutter/material.dart';
import 'package:Dailoz/screens/homescreen/widget_homescreen/custom_gridview_task.dart';
import 'package:Dailoz/widgets/dot_navigation_bar.dart';
import 'package:Dailoz/widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 10.0, left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Hi, Minh Thao',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        color: Color(0xFF12175E),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text('Let’s make this day productive',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                        ))
                  ],
                ),
                CircleAvatar(
                  backgroundColor: Colors.brown.shade800,
                  child: const Text('MT'),
                )
              ],
            ),
            const SizedBox(height: 50.0),
            const Text(
              'My Task',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF12175E),
              ),
            ),
            const SizedBox(height: 10.0),
            const CustomGridViewTask(), //Task view
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today Task',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF12175E),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text('View all',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          color: Color(0xff393F93))),
                ),
              ],
            ),

            ListView.builder(
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) => StackWidget(
                title: tasks[index].title,
                description: tasks[index].description,
                tags: tasks[index].tags,
                typeId: tasks[index].typeId,
                process: tasks[index].process,
                start: tasks[index].dateStart,
                end: tasks[index].dateEnd,
                cTitleWidth: 200,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppbar(currentIndex: 0),
      extendBody: true,
    );
  }
}
