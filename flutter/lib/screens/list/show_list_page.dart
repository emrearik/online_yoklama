import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_yoklama/common_widgets/entry_list_item.dart';
import 'package:online_yoklama/common_widgets/list_items_builder.dart';
import 'package:online_yoklama/models/student.dart';
import 'package:online_yoklama/services/database.dart';
import 'package:provider/provider.dart';

class ShowListPage extends StatefulWidget {
  const ShowListPage({Key? key}) : super(key: key);

  @override
  State<ShowListPage> createState() => _ShowListPageState();
}

class _ShowListPageState extends State<ShowListPage> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş Yapan Kullanıcı Listesi"),
      ),
      body: StreamBuilder<List<Student>>(
        stream: database.listenStudentListStream(),
        builder: (context, snapshot) {
          return ListItemsBuilder<Student>(
            snapshot: snapshot,
            itemBuilder: (context, student) {
              return DismissibleEntryListItem(
                  key: Key('student-${student.qrData}'),
                  student: student,
                  onDismissed: () {},
                  onTap: () {});
            },
          );
        },
      ),
    );
  }
}
