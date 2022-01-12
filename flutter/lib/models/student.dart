class Student {
  final String fullName;
  final double schoolNumber;
  final String lessonCode;
  final String hesCode;
  final String qrData;
  final double lessonTime;

  Student({
    required this.fullName,
    required this.schoolNumber,
    required this.lessonCode,
    required this.hesCode,
    required this.qrData,
    required this.lessonTime,
  });

  Map<String, dynamic> toMap() {
    return {
      "fullName": fullName,
      "schoolNumber": schoolNumber,
      "lessonCode": lessonCode,
      "hesCode": hesCode,
      "qrData": qrData,
      "lessonTime": lessonTime,
    };
  }

  factory Student.fromMap(Map<String, dynamic> data) {
    final String fullName = data["fullName"];
    final double schoolNumber = data["schoolNumber"];
    final String lessonCode = data["lessonCode"];
    final String hesCode = data["hesCode"];
    final String qrData = data["qrData"];
    final double lessonTime = data["lessonTime"];

    return Student(
      fullName: fullName,
      schoolNumber: schoolNumber,
      lessonCode: lessonCode,
      hesCode: hesCode,
      qrData: qrData,
      lessonTime: lessonTime,
    );
  }
}
