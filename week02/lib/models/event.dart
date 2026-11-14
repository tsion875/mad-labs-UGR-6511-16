import 'package:flutter/foundation.dart';

/// Where an event takes place. An enhanced enum: it has fields and a
/// constructor like a class, but a fixed set of instances.
enum Venue {
  mainCampus('Main campus', 'Sidist Kilo'),
  scienceFaculty('Science faculty', 'Arat Kilo'),
  technology('Technology faculty', 'Amist Kilo'),
  online('Online', 'Zoom / Teams');

  const Venue(this.label, this.location);

  final String label;
  final String location;
}

/// A campus event. Immutable: every field is `final`, and changes are made
/// with [copyWith], which returns a new instance.
// TODO(lab): Task 1 — implement isUpcoming, copyWith, ==, hashCode and
// toString. The tests in test/models/event_test.dart describe the exact
// behaviour.
@immutable
class Event {
  const Event({
    required this.id,
    required this.title,
    required this.start,
    required this.venue,
    this.description = '',
    this.isFree = true,
  });

  final String id;
  final String title;
  final DateTime start;
  final Venue venue;
  final String description;
  final bool isFree;

  bool isUpcoming({DateTime? now}) =>
      start.isAfter(now ?? DateTime.now());

  Event copyWith({
    String? id,
    String? title,
    DateTime? start,
    Venue? venue,
    String? description,
    bool? isFree,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      start: start ?? this.start,
      venue: venue ?? this.venue,
      description: description ?? this.description,
      isFree: isFree ?? this.isFree,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is Event &&
      other.id == id &&
      other.title == title &&
      other.start == start &&
      other.venue == venue &&
      other.description == description &&
      other.isFree == isFree;

  @override
  int get hashCode =>
      Object.hash(id, title, start, venue, description, isFree);

  @override
  String toString() => 'Event($id, $title, ${venue.label}, $start)';
}

  // TODO(lab): override == and hashCode so two events with the same field
  // values are equal (use Object.hash), and toString →
  // 'Event($id, $title, ${venue.label}, $start)'.

