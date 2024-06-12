import 'package:allnimall_web/src/core/loggers/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetJsonPage extends StatefulWidget {
  const GetJsonPage({Key? key, required this.tableName}) : super(key: key);

  final String tableName;

  @override
  State<GetJsonPage> createState() => _GetJsonPageState();
}

class _GetJsonPageState extends State<GetJsonPage> {
  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;
    db.collection(widget.tableName).get().then((event) {
      for (var doc in event.docs) {
        logger.d("${doc.id} => ${doc.data()}");
      }
    });
    return Container();
  }
}
