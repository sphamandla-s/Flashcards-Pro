import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:students_productive_room/models/notes_view_model.dart';
import 'package:students_productive_room/pages/home_screens/you_screens/update_notes.dart';
import '../../../consts/conts.dart';
import 'notes_screen.dart';

class NoteDetail extends StatefulWidget {
  const NoteDetail({Key? key, required this.note}) : super(key: key);
  final Map<String, Object?> note;

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
        Conts.lightColors[int.parse(widget.note['noteColor'].toString())],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 5.0, right: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => const NotesHome(),
                              fullscreenDialog: true));
                        },
                        icon: const Icon(Icons.arrow_back,
                            color: Conts.primaryIconColor)),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => UpdateNote(note: widget.note,),
                                  fullscreenDialog: true));
                            },
                            icon: const Icon(
                              FontAwesomeIcons.pencil,
                              color: Conts.primaryIconColor,
                            )),
                        IconButton(
                            onPressed: () {
                              Provider.of<NotesViewModel>(context,
                                      listen: false)
                                  .deleteNote(widget.note['_id'].toString());
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) => const NotesHome(),
                                  fullscreenDialog: true));
                            },
                            icon: const Icon(Icons.delete_forever,
                                color: Conts.primaryIconColor)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(FontAwesomeIcons.share,
                                color: Conts.primaryIconColor)),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.note['title'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.note['createdOn'].toString().split('T')[0],
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.note['createdOn']
                                .toString()
                                .split('T')[1]
                                .split(':00.')[0],
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.note['note'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
