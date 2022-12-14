class YouEvents {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final String eventColor;

  YouEvents({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.eventColor,
  });

  YouEvents.fromJson(Map<String, Object?> jsonMap)
      : this(
          id: jsonMap['_id'] as String,
          title: jsonMap['title'] as String,
          startTime: DateTime.parse(jsonMap['startTime'] as String),
          endTime: DateTime.parse(jsonMap['endTime'] as String),
          location: jsonMap['location'] as String,
          eventColor: jsonMap['eventColor'] as String,
        );

  Map<String, Object?> toJson() {
    return {
      '_id': id,
      'title': title,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'location': location,
      'eventColor': eventColor,
    };
  }

  @override
  String toString() {
    return 'Event{_id : $id, title : $title, startTime : $startTime, endTime : $endTime, location : $location, eventColor : $eventColor }';
  }
}


class EventsFields{
  final String _tableName = 'events';
  final String _id = '_id';
  final String _title = 'title';
  final String _startTime = 'startTime';
  final String _endTime = 'endTime';
  final String _location = 'location';
  final String _eventColor = 'eventColor';

  String get eventTableName => _tableName;
  String get eventId => _id;
  String get eventTitle => _title;
  String get eventStartTime => _startTime;
  String get eventEndTime => _endTime;
  String get eventLocation => _location;
  String get eventColor => _eventColor;
}