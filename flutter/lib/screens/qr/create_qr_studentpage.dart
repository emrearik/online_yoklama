import 'package:flutter/material.dart';
import 'package:online_yoklama/screens/list/show_list_page.dart';
import 'package:online_yoklama/screens/qr/qr_model.dart';
import 'package:online_yoklama/screens/qr/show_qr_page.dart';
import 'package:online_yoklama/services/auth.dart';
import 'package:online_yoklama/services/database.dart';
import 'package:provider/provider.dart';

class CreateQRStudentPage extends StatefulWidget {
  final QRModel model;
  CreateQRStudentPage({
    Key? key,
    required this.model,
  }) : super(key: key);

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<QRModel>(
      create: (_) => QRModel(auth: auth),
      child: Consumer<QRModel>(
        builder: (_, model, __) => CreateQRStudentPage(model: model),
      ),
    );
  }

  @override
  State<CreateQRStudentPage> createState() => _CreateQRStudentPageState();
}

class _CreateQRStudentPageState extends State<CreateQRStudentPage> {
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Yoklama Sistemi"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Icon(Icons.logout),
              onTap: () => widget.model.auth.signOut(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 150,
                  child: Image.asset("assets/logorgb.png"),
                ),
                Form(
                  key: _globalKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.play_lesson),
                          labelText: 'Ders Kodu *',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ders Kodu giriniz.";
                          }
                          return null;
                        },
                        onChanged: widget.model.updateLessonCode,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'İsim Soyisim *',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "İsim Soyisim giriniz.";
                          }
                          return null;
                        },
                        onChanged: widget.model.updateFullName,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Okul Numaranız *',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Okul numarası giriniz.";
                          }
                          return null;
                        },
                        onChanged: widget.model.updateSchoolNumber,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Hes Kodunuz *',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Hes Kodu giriniz.";
                          }
                          return null;
                        },
                        onChanged: widget.model.updateHesCode,
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (_globalKey.currentState!.validate()) {
                            widget.model.updateQRData();
                            _showQRPage();
                          }
                        },
                        child: Text("Gönder"),
                        color: Colors.green,
                      ),
                      SizedBox(height: 10),
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Provider<Database>(
                                create: (_) => OnlineYoklamaDatabase(),
                                child: ShowListPage(),
                              ),
                            ),
                          );
                        },
                        child: Text("Liste"),
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showQRPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ShowQRPage(
          model: widget.model,
        ),
      ),
    );
  }
}
