import '../../database/you_database.dart';
import '../../models/events_model/events.dart';

class EventsRepository {
  createEvent(String id, String title, DateTime startTime, DateTime endTime,
      String location, String eventColor) async {
    final db = await YouDatabase.instance.database;
    await db.insert(
        'events',
        YouEvents(
          id: id,
          title: title,
          startTime: startTime,
          endTime: endTime,
          location: location,
          eventColor: eventColor,
        ).toJson());
  }

  Future<List<Map<String, Object?>>> retrieveAllEvents() async {
    final db = await YouDatabase.instance.database;
    final queryResult = await db.query('events', orderBy: 'startTime DESC');
    return queryResult;
  }

  Future<YouEvents> readSingleEvent(String id) async {
    final db = await YouDatabase.instance.database;
    final note = await db.query('events', where: '_id = ?', whereArgs: [id]);
    return YouEvents.fromJson(note[0]);
  }

  Future<void> deleteEvent(String id) async {
    final db = await YouDatabase.instance.database;
    await db.delete(
      'events',
      where: "_id = ?",
      whereArgs: [id],
    );
  }

  Future<void> updateEvent(String id, String title, DateTime startTime,
      DateTime endTime, String location, String eventColor) async {
    YouEvents youEvents = YouEvents(
        id: id,
        title: title,
        startTime: startTime,
        endTime: endTime,
        location: location,
        eventColor: eventColor);
    final db = await YouDatabase.instance.database;
    await db.update('notes', youEvents.toJson(),
        where: "_id = ?", whereArgs: [youEvents.id]);
  }

  closeDB() async {
    final db = await YouDatabase.instance.database;
    db.close();
  }
}
