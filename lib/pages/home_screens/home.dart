import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:students_productive_room/pages/home_screens/main_home.dart';
import 'package:students_productive_room/pages/home_screens/rooms.dart';
import 'package:students_productive_room/pages/home_screens/you.dart';
import 'drawer_menu.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  void _selected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  var pages = [
    const GoingOns(),
    const Rooms(),
    //const Chats(),
    const You(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.group), label: 'Rooms'),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.message_outlined), label: 'DMs'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.faceSmile), label: 'You'),
        ],
        onTap: _selected,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        currentIndex: _currentIndex,
      ),
      body: pages[_currentIndex],
      floatingActionButton: floatingButton(_currentIndex),
      drawer: const Drawer(child: DrawerMenu(),),
    );
  }

  Widget?  floatingButton(int index){
    if(index == 0){
      return FloatingActionButton(onPressed: (){}, child: const Icon(FontAwesomeIcons.pen),);
    }
    else if(index == 1){
      return FloatingActionButton(onPressed: (){}, child: const Icon(FontAwesomeIcons.add),);
    }
    // else if(index == 2){
    //   return FloatingActionButton(onPressed: (){}, child: const Icon(FontAwesomeIcons.message),);
    // }
    return null;
  }

}
