<<<<<<< HEAD
=======
//STUDENT NUMBERS:
//220013730 KL MOHLOLO
//224073145 T PHAGE
//222034858 N SHABALALA
//223000608 AL HADEBE
//221034407 NS MOLOI

>>>>>>> 9c3c10e (final)
class ApplicationModel {
  final String id;
  final String userId;
  final String year;
  final String module1;
  final String? module2;
  final String status;

  ApplicationModel({
    required this.id,
    required this.userId,
    required this.year,
    required this.module1,
    this.module2,
    required this.status,
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      year: json['year'] ?? '',
      module1: json['module_1'] ?? '',
      module2: json['module_2'],
      status: json['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'year': year,
      'module_1': module1,
      if (module2 != null) 'module_2': module2,
      'status': status,
    };
  }

  ApplicationModel copyWith({
    String? id,
    String? userId,
    String? year,
    String? module1,
    String? module2,
    String? status,
  }) {
    return ApplicationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      year: year ?? this.year,
      module1: module1 ?? this.module1,
      module2: module2 ?? this.module2,
      status: status ?? this.status,
    );
  }
}
