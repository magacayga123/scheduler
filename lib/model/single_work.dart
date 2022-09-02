class Single_work {
  final String name;
  final String description;
  double? evaluation;
  Single_work({required this.name, required this.description, this.evaluation});
  Map<String, dynamic> tojson() {
    return {
      "name": name,
      "description": description,
      "evaluation": evaluation ?? "no evaluation",
    };
  }

  factory Single_work.fromjson(Map<String, dynamic> map) {
    return Single_work(
        name: map['name'],
        description: map['description'],
        evaluation: map['evaluation']);
  }
}
