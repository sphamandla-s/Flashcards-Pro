import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:students_productive_room/models/notes_model/notes_view_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:students_productive_room/pages/home_screens/you_screens/notes/note_detail.dart';
import 'add_note.dart';
import 'note_card.dart';
import 'note_search.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Notes'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchNotes(noteList: _noteList));
              }, icon: const Icon(FontAwesomeIcons.search))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNote(),
                  fullscreenDialog: true));
        },
        child: const Icon(FontAwesomeIcons.pencil),
      ),
      body: _noteList.isNotEmpty
          ? isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MasonryGridView.builder(
                    gridDelegate:
                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: setGridLayout(_noteList.length)),
                    itemCount: _noteList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NoteDetail(note: _noteList[index]),
                                fullscreenDialog: true),
                          );
                        },
                        child: NoteCardWidget(
                          index: index,
                          note: _noteList[index],
                        ),
                      );
                    },
                  ),
                )
          : const Center(
              child: Text(
                  'You have no notes click on the pen button to add a note'),
            ),
    );
  }

  int setGridLayout(int num) {
    switch (num) {
      case 1:
        return 1;
      case 2:
        return 2;
      case 3:
        return 3;
      default:
        return 3;
    }
  }
}
