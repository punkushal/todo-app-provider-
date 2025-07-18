class TodoModel {
  final int id;
  final String title;
  final String desc;
  final bool isCompleted;

  TodoModel({
    required this.id,
    required this.title,
    required this.desc,
    this.isCompleted = false, //Default value
  });
}
