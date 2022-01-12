import 'package:flutter/material.dart';
import 'package:online_yoklama/screens/qr/qr_model.dart';
import 'package:online_yoklama/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowQRPage extends StatelessWidget {
  final QRModel model;
  const ShowQRPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Kodunuz"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              informationStudent(context),
              QrImage(
                data: model.qrData!,
                size: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget informationStudent(BuildContext context) {
    List<Map<String, String>> informationList = [
      {"title": "İsim Soyisim:", "text": model.fullName!},
      {"title": "Okul Numarası:", "text": model.schoolNumber!},
      {"title": "HES Kodu:", "text": model.hesCode!},
      {"title": "Ders Kodu:", "text": model.lessonCode!},
      {"title": "QR Data:", "text": model.qrData!}
    ];
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      child: ListView.builder(
        itemCount: informationList.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  informationList[i]["title"]!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 5),
                Text(informationList[i]["text"]!),
              ],
            ),
          );
        },
      ),
    );
  }
}
