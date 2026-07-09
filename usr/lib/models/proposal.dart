import 'package:uuid/uuid.dart';

class Proposal {
  final String id;
  final String title;
  final String clientName;
  final String overview;
  final String objectives;
  final String scope;
  final String timeline;
  final String budget;
  final DateTime createdAt;

  Proposal({
    String? id,
    required this.title,
    required this.clientName,
    required this.overview,
    required this.objectives,
    required this.scope,
    required this.timeline,
    required this.budget,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Proposal copyWith({
    String? title,
    String? clientName,
    String? overview,
    String? objectives,
    String? scope,
    String? timeline,
    String? budget,
  }) {
    return Proposal(
      id: id,
      title: title ?? this.title,
      clientName: clientName ?? this.clientName,
      overview: overview ?? this.overview,
      objectives: objectives ?? this.objectives,
      scope: scope ?? this.scope,
      timeline: timeline ?? this.timeline,
      budget: budget ?? this.budget,
      createdAt: createdAt,
    );
  }
}
