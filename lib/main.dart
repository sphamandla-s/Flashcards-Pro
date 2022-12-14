import 'package:flutter/material.dart';
import 'package:students_productive_room/models/notes_model/notes_view_model.dart';
import 'package:students_productive_room/pages/home_screens/home.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<NotesViewModel>(create: (_)=> NotesViewModel(),)
  ], child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}



