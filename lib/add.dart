import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tubes_mobile/identitas/repository.dart';
import 'package:tubes_mobile/model/model.dart';

class addBlog extends StatefulWidget {
  const addBlog([Key? key]) : super(key: key);

  @override
  _addBlogState createState() => _addBlogState();
}

class _addBlogState extends State<addBlog> {
  Repository repository = Repository();
  final _colorController = TextEditingController();
  final _idController = TextEditingController();
  final _yearController = TextEditingController();
  final _pantone_valueController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add data'),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: _colorController,
              decoration: InputDecoration(hintText: 'color'),
            ),
            TextField(
              controller: _idController,
              decoration: InputDecoration(hintText: 'id'),
            ),
            TextField(
              controller: _yearController,
              decoration: InputDecoration(hintText: 'year'),
            ),
            TextField(
              controller: _pantone_valueController,
              decoration: InputDecoration(hintText: 'pantone_value'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'name'),
            ),
            ElevatedButton(
                onPressed: () async {
                  bool response = await repository.postData(
                    _colorController.text,
                    int.parse(_idController.text),
                    int.parse(_yearController.text),
                    _pantone_valueController.text,
                    _nameController.text,
                  );
                  if (response) {
                    Navigator.of(context).popAndPushNamed('/home');
                  } else {
                    print('post data gagal');
                  }
                },
                child: Text('submit'))
          ],
        ),
      ),
    );
  }
}
