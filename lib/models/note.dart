import 'package:uuid/uuid.dart';

/// Model class representing a single note in the application.
/// This class defines the structure of a note with all its properties.
class Note {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> tags;
  final String notebookId;
  final bool isPinned;
  final bool isArchived;
  final List<String> attachments; // File paths or URLs
  final String color; // Hex color code
  final bool isFavorite;

  /// Constructor for creating a new Note instance.
  Note({
    String? id,
    required this.title,
    required this.content,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.tags = const [],
    this.notebookId = 'default',
    this.isPinned = false,
    this.isArchived = false,
    this.attachments = const [],
    this.color = '#FFFFFF',
    this.isFavorite = false,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  /// Create a copy of this Note with some fields replaced.
  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? tags,
    String? notebookId,
    bool? isPinned,
    bool? isArchived,
    List<String>? attachments,
    String? color,
    bool? isFavorite,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      notebookId: notebookId ?? this.notebookId,
      isPinned: isPinned ?? this.isPinned,
      isArchived: isArchived ?? this.isArchived,
      attachments: attachments ?? this.attachments,
      color: color ?? this.color,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  /// Convert Note to JSON for storage or API communication.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'tags': tags,
      'notebookId': notebookId,
      'isPinned': isPinned,
      'isArchived': isArchived,
      'attachments': attachments,
      'color': color,
      'isFavorite': isFavorite,
    };
  }

  /// Create a Note instance from JSON data.
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      tags: List<String>.from(json['tags'] as List? ?? []),
      notebookId: json['notebookId'] as String? ?? 'default',
      isPinned: json['isPinned'] as bool? ?? false,
      isArchived: json['isArchived'] as bool? ?? false,
      attachments: List<String>.from(json['attachments'] as List? ?? []),
      color: json['color'] as String? ?? '#FFFFFF',
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  @override
  String toString() => 'Note(id: $id, title: $title, createdAt: $createdAt)';
}

/// Model class representing a notebook/folder for organizing notes.
class Notebook {
  final String id;
  final String name;
  final String description;
  final String color;
  final DateTime createdAt;
  final int noteCount;

  Notebook({
    String? id,
    required this.name,
    this.description = '',
    this.color = '#4CAF50',
    DateTime? createdAt,
    this.noteCount = 0,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Notebook copyWith({
    String? id,
    String? name,
    String? description,
    String? color,
    DateTime? createdAt,
    int? noteCount,
  }) {
    return Notebook(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      noteCount: noteCount ?? this.noteCount,
    );
  }
}

/// Model class representing a tag for categorizing notes.
class Tag {
  final String id;
  final String name;
  final String color;
  final int noteCount;

  Tag({
    String? id,
    required this.name,
    this.color = '#2196F3',
    this.noteCount = 0,
  }) : id = id ?? const Uuid().v4();

  Tag copyWith({
    String? id,
    String? name,
    String? color,
    int? noteCount,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      noteCount: noteCount ?? this.noteCount,
    );
  }
}

/// Model class representing a reminder for a note.
class Reminder {
  final String id;
  final String noteId;
  final DateTime reminderTime;
  final String title;
  final bool isCompleted;

  Reminder({
    String? id,
    required this.noteId,
    required this.reminderTime,
    required this.title,
    this.isCompleted = false,
  }) : id = id ?? const Uuid().v4();

  Reminder copyWith({
    String? id,
    String? noteId,
    DateTime? reminderTime,
    String? title,
    bool? isCompleted,
  }) {
    return Reminder(
      id: id ?? this.id,
      noteId: noteId ?? this.noteId,
      reminderTime: reminderTime ?? this.reminderTime,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
