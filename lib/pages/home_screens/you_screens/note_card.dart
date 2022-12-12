import 'package:flutter/material.dart';
import '../../../consts/conts.dart';

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    Key? key,
    required this.index,
    required this.note,
  }) : super(key: key);

  final int index;
  final Map<String, Object?> note;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = note['noteColor'];
    final minHeight = getMinHeight(index);

    return Card(
      color: Conts.lightColors[int.parse(color.toString())],
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              note['createdOn'].toString().split('T')[0],
              style: TextStyle(color: Colors.grey.shade700),
            ),
            Center(
              child: Text(
                note['title'].toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 150;
      case 1:
        return 200;
      case 2:
        return 200;
      case 3:
        return 150;
      default:
        return 150;
    }
  }
}
