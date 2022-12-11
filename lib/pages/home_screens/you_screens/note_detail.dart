import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../consts/conts.dart';

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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back,
                          color: Conts.primaryIconColor)),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            FontAwesomeIcons.pencil,
                            color: Conts.primaryIconColor,
                          )),
                      IconButton(
                          onPressed: () {},
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

              Column(
                children: [
                  Text(
                    widget.note['title'].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
