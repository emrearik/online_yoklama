import 'package:flutter/material.dart';
import 'package:online_yoklama/services/auth.dart';

class QRModel extends ChangeNotifier {
  AuthBase auth;
  String? fullName;
  String? schoolNumber;
  String? lessonCode;
  String? hesCode;
  String? qrData;

  QRModel(
      {required this.auth,
      this.fullName,
      this.schoolNumber,
      this.lessonCode,
      this.hesCode});

  void updateWith(
      {String? fullName,
      String? schoolNumber,
      String? lessonCode,
      String? hesCode,
      String? qrData}) {
    this.fullName = fullName ?? this.fullName;
    this.schoolNumber = schoolNumber ?? this.schoolNumber;
    this.lessonCode = lessonCode ?? this.lessonCode;
    this.hesCode = hesCode ?? this.hesCode;
    this.qrData = qrData ?? this.qrData;
    notifyListeners();
  }

  void updateFullName(String fullName) => updateWith(fullName: fullName);
  void updateSchoolNumber(String schoolNumber) =>
      updateWith(schoolNumber: schoolNumber);
  void updateLessonCode(String lessonCode) =>
      updateWith(lessonCode: lessonCode);
  void updateHesCode(String hesCode) => updateWith(hesCode: hesCode);

  void updateQRData() {
    String data =
        fullName! + "_" + schoolNumber! + "_" + hesCode! + "_" + lessonCode!;
    updateWith(qrData: data);
  }
}
