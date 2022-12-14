import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:students_productive_room/pages/home_screens/you_screens/events/events_screen.dart';
import 'package:students_productive_room/pages/home_screens/you_screens/notes/notes_screen.dart';

class You extends StatelessWidget {
  const You({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              youCards(Colors.black, 'NOTES', FontAwesomeIcons.notesMedical,
                  () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotesHome(),
                        fullscreenDialog: true));
              }),
              youCards(
                  Colors.purple, 'DIARY', FontAwesomeIcons.faceSmile, () {}),
              youCards(Colors.green, 'EVENTS', FontAwesomeIcons.calendarCheck,
                  () { Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const  EventsHome(),
                          fullscreenDialog: true));}),
              youCards(Colors.red, 'NOTIFICATIONS', Icons.notifications, () {}),
              youCards(Colors.blue, 'MENTIONS', FontAwesomeIcons.at, () {}),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector youCards(
      Color color, String label, IconData iconData, VoidCallback onPress) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  label,
                  style: GoogleFonts.abel(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Icon(
                  iconData,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
