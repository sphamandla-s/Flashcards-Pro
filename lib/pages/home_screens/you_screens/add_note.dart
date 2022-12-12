import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../consts/conts.dart';
import '../../../models/notes_view_model.dart';
import 'notes_screen.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  int index = 0;
  Color noteColor = Conts.lightColors[0];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  final uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: noteColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNote();
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => const NotesHome(),
              fullscreenDialog: true));
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
                        Navigator.pushReplacement(context, MaterialPageRoute(
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
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 10,
        controller: _noteController,
        style: const TextStyle(color: Colors.white, fontSize: 25),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type note...',
          hintStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
      );

  setNoteColor() {
    if (index != Conts.lightColors.length - 1) {
      setState(() {
        index++;
        noteColor = Conts.lightColors[index];
      });
    } else {
      setState(() {
        index = 0;
        noteColor = Conts.lightColors[index];
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
        index.toString());
  }
}
