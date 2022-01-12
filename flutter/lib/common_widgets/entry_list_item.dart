import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_yoklama/models/student.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EntryListItem extends StatelessWidget {
  const EntryListItem({
    required this.student,
    required this.onTap,
  });

  final Student student;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: _buildContents(context),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: <Widget>[
              _buildStudentInformationRow(context),
            ],
          ),
          QrImage(data: student.qrData, size: 75),
        ],
      ),
    );
  }

  Widget _buildStudentInformationRow(BuildContext context) {
    List<Map<String, String>> informationList = [
      {"title": "İsim Soyisim:", "text": student.fullName},
      {
        "title": "Okul Numarası:",
        "text": student.schoolNumber.toStringAsFixed(0)
      },
      {"title": "HES Kodu:", "text": student.hesCode},
      {"title": "Ders Kodu:", "text": student.lessonCode},
      {"title": "Tarih:", "text": getTimeStamp(student.lessonTime)},
    ];
    return Container(
      height: MediaQuery.of(context).size.height / 6.5,
      width: MediaQuery.of(context).size.width / 1.5,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: informationList.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Row(
              children: [
                Text(
                  informationList[i]["title"]!,
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5),
                Text(
                  informationList[i]["text"]!,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DismissibleEntryListItem extends StatelessWidget {
  const DismissibleEntryListItem({
    this.key,
    this.student,
    this.onDismissed,
    this.onTap,
  });

  final Key? key;
  final Student? student;
  final VoidCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: key!,
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDismissed!(),
      child: EntryListItem(
        student: student!,
        onTap: onTap!,
      ),
    );
  }
}

String getTimeStamp(double timestamp) {
  String s = timestamp.toStringAsFixed(0);
  int p = int.parse(s) * 1000;

  final DateTime timeStamp = DateTime.fromMillisecondsSinceEpoch(p);

  var format = DateFormat("dd/MM/yyyy H:m:s");
  var dateString = format.format(timeStamp);
  return dateString;
}
