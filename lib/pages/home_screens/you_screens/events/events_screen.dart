import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:students_productive_room/repository/events_repository/event_repository.dart';


class EventsHome extends StatefulWidget {
  const EventsHome({Key? key}) : super(key: key);

  @override
  State<EventsHome> createState() => _EventsHomeState();
}


class _EventsHomeState extends State<EventsHome> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text('Events'),
        actions: [
          IconButton(
              onPressed: () {
              }, icon: const Icon(FontAwesomeIcons.search))
        ],
      ),
    );
  }
}
