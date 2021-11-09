import 'package:Dailoz/screens/taskscreen/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter_svg/svg.dart';

class BottomAppbar extends StatefulWidget {
  const BottomAppbar({
    Key? key,
    required int currentIndex,
  })  : _currentIndex = currentIndex,
        super(key: key);

  final int _currentIndex;

  @override
  State<BottomAppbar> createState() => _BottomAppbarState();
}

class _BottomAppbarState extends State<BottomAppbar> {
  void _onItemTapped(index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, "/home");
        break;
      case 1:
        // Navigator.pushNamed(context, "/taskScreen");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TaskScreens()),
        );
        break;
      case 2:
        Navigator.pushNamed(context, "/addtask");
        break;
      case 3:
        Navigator.pushNamed(context, "/analyticScreen");
        break;
      case 4:
        Navigator.pushNamed(context, "/folderScreen");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DotNavigationBar(
      currentIndex: widget._currentIndex,
      onTap: _onItemTapped,
      marginR: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      backgroundColor: Colors.white,
      paddingR: const EdgeInsets.all(0),
      // margin: const EdgeInsets.symmetric(horizontal: 15),
      dotIndicatorColor: const Color(0xff5B67CA),
      selectedItemColor: const Color(0xff5B67CA),
      unselectedItemColor: Colors.grey,
      borderRadius: 25,
      boxShadow: const [
        BoxShadow(
            color: Color(0xffC6C6C6),
            spreadRadius: 0,
            blurRadius: 5,
            offset: Offset(-3, 5)
            // changes position of shadow
            ),
      ],
      items: [
        DotNavigationBarItem(
          icon: widget._currentIndex == 0
              ? SvgPicture.asset('assets/icons/home_clicked.svg')
              : SvgPicture.asset('assets/icons/home.svg'),
        ),
        DotNavigationBarItem(
          icon: widget._currentIndex == 1
              ? SvgPicture.asset('assets/icons/task_clicked.svg')
              : SvgPicture.asset('assets/icons/task.svg'),
        ),
        DotNavigationBarItem(
          icon: const CircleAvatar(
            radius: 25.0,
            backgroundColor: Color(0xff5B67CA),
            child: Icon(Icons.add, size: 24.0),
          ),
        ),
        DotNavigationBarItem(
          icon: widget._currentIndex == 3
              ? SvgPicture.asset('assets/icons/analytic_clicked.svg')
              : SvgPicture.asset('assets/icons/analytic.svg'),
        ),
        DotNavigationBarItem(
          icon: widget._currentIndex == 4
              ? SvgPicture.asset('assets/icons/folder_clicked.svg')
              : SvgPicture.asset('assets/icons/folder.svg'),
        ),
      ],
    );
  }
}
