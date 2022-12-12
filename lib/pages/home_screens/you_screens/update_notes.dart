import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../consts/conts.dart';
import '../../../models/notes_view_model.dart';
import 'notes_screen.dart';

class UpdateNote extends StatefulWidget {
  const UpdateNote({Key? key, required this.note}) : super(key: key);
  final Map<String, Object?> note;

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  late final TextEditingController _noteController;
  late final TextEditingController _titleController;
  late int index;
  late Color noteColor;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _noteController =
        TextEditingController(text: widget.note['note'].toString());
    _titleController =
        TextEditingController(text: widget.note['title'].toString());
    noteColor =
        Conts.lightColors[int.parse(widget.note['noteColor'].toString())];
    index = int.parse(widget.note['noteColor'].toString());
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          updateNote();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const NotesHome(),
                  fullscreenDialog: true));;
        },
        child: const Text('SAVE'),
      ),
      backgroundColor: noteColor,
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
                        Navigator.of(context).pop();
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
        controller: _titleController,
        maxLines: 1,
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

  updateNote() {
    // var createDate = dateFormat.parse(
    //     '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:00');
    Provider.of<NotesViewModel>(context, listen: false).updateNote(
        widget.note['_id'].toString(),
        _titleController.text,
        _noteController.text,
        dateFormat.parse(
            '${widget.note['createdOn'].toString().split('T')[0]} ${widget.note['createdOn'].toString().split('T')[1].split(':00.')[0]}:00'),
        index.toString());
  }
}
