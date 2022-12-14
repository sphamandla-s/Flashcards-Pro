import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../../consts/conts.dart';
import '../../../../models/notes_model/notes_view_model.dart';
import 'notes_screen.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  int colorIndex = 0;
  int fontIndex = 0;
  Color noteColor = Conts.lightColors[0];
  String noteFont = Conts.textFonts[0];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  final uuid = const Uuid();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _noteController.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: noteColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          noteCreated();
        },
        child: const Icon(Icons.send),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NotesHome(),
                                fullscreenDialog: true));
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {setNoteFont();},
                          icon: const Icon(FontAwesomeIcons.font),
                          color: Conts.primaryIconColor,
                        ),
                        IconButton(
                          onPressed: () {
                            setNoteColor();
                          },
                          icon: const Icon(
                            Icons.color_lens,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                buildTitle(),
                const SizedBox(height: 8),
                buildDescription(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        controller: _titleController,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.white, fontSize: 30),
        ),
      );

  Widget buildDescription() => TextFormField(
        maxLines: 10,
        controller: _noteController,
        style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: noteFont),
        decoration:  InputDecoration(
          border: InputBorder.none,
          hintText: 'Type note...',
          hintStyle: TextStyle(color: Colors.white, fontSize: 20, fontFamily: noteFont),
        ),
      );

  setNoteColor() {
    if (colorIndex != Conts.lightColors.length - 1) {
      setState(() {
        colorIndex++;
        noteColor = Conts.lightColors[colorIndex];
      });
    } else {
      setState(() {
        colorIndex = 0;
        noteColor = Conts.lightColors[colorIndex];
      });
    }
  }


  setNoteFont() {
    if (fontIndex != Conts.textFonts.length - 1) {
      setState(() {
        fontIndex++;
        noteFont = Conts.textFonts[fontIndex];
      });
    } else {
      setState(() {
        fontIndex = 0;
        noteFont = Conts.textFonts[fontIndex];
      });
    }
  }


  createNote() {
    DateTime date = DateTime.now();
    var createDate = dateFormat.parse(
        '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:00');
    Provider.of<NotesViewModel>(context, listen: false).addNote(
        uuid.v4(),
        _titleController.text,
        _noteController.text,
        createDate,
        colorIndex.toString(),
      fontIndex.toString(),
    );
  }

  noteCreated() {
    String title = _titleController.text;
    String note = _noteController.text;
    if (title.isNotEmpty && note.isNotEmpty) {
      createNote();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const NotesHome(), fullscreenDialog: true));
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: dialogContent(title),
            );
          });
    }
  }

  Widget dialogContent(String title) {
    String label = '';
    if (title.isEmpty) {
      label = 'The title cannot be empty';
    } else {
      label = 'The note cannot be empty';
    }
    return SizedBox(
      height: 75.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Okay'))
        ],
      ),
    );
  }
}
