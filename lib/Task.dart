class Task {
  int? id; // المعرف الفريد للمهمة [cite: 249, 376]
  String title;
  String description;
  String category;
  bool isCompleted;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    this.isCompleted = false,
  });

  factory Task.fromJson (Map<String, dynamic>json){
    return Task(id: json["id"],
        title: json['title'],
        description: json['description'],
        category: json['category'],
        isCompleted: json['is_done']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "title": title,
      "description": description,
      "category": category,
      "is_done": isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      isCompleted: map['isCompleted'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }
}


// التصنيفات المتاحة [cite: 48, 76]
List<String> categories = ["Personal", "Work", "Study", "Shopping"];