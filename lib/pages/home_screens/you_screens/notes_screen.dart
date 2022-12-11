import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:students_productive_room/models/notes_view_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:students_productive_room/pages/home_screens/you_screens/note_detail.dart';
import 'add_note.dart';
import 'note_card.dart';

class NotesHome extends StatefulWidget {
  const NotesHome({Key? key}) : super(key: key);

  @override
  State<NotesHome> createState() => _NotesHomeState();
}

class _NotesHomeState extends State<NotesHome> {
  late List<Map<String, Object?>> _noteList = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allNotes();
  }

  allNotes() async {
    setState(() {
      isLoading = true;
    });

    _noteList = await Provider.of<NotesViewModel>(context, listen: false)
        .getAllAllNotes;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddNote(),
                    fullscreenDialog: true));
          },
          child: const Icon(FontAwesomeIcons.pencil),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              )
            : MasonryGridView.builder(
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                itemCount: _noteList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NoteDetail(note: _noteList[index]),
                            fullscreenDialog: true));},
                    child: NoteCardWidget(
                      index: index,note: _noteList[index],
                    ),
                  );
                },
              ));
  }
}
