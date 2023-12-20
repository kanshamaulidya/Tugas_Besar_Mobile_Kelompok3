import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:tubes_mobile/identitas/repository.dart';
import 'package:tubes_mobile/model/model.dart';
import 'add.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Besar',
      theme: ThemeData(primaryColor: Colors.blue),
      routes: {
        '/home': (context) => MyHomePage(title: 'API Tugas Besar Kelompok 3'),
        '/add': (context) => addBlog(),
      },
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'API Tugas Besar Kelompok 3'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int blogCount;
  late List listBlog;
  Repository repository = Repository();

  Future getData() async {
    listBlog = [];
    listBlog = await repository.getData();
    setState(() {
      blogCount = listBlog.length;
      listBlog = listBlog;
    });
  }

  @override
  void initState() {
    //print('Mulai);
    getData();
    super.initState();
  }

  // Fungsi untuk menghapus item dari daftar
  void deleteItem(int index) {
    setState(() {
      listBlog.removeAt(index);
    });
  }

  Future<void> showCreateForm(BuildContext context) async {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String name = '';
    String year = '';
    String color = '';
    String pantoneValue = '';

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create Blog'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (newValue) => name = newValue!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Year'),
                onSaved: (newValue) => year = newValue!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Color'),
                onSaved: (newValue) => color = newValue!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Pantone Value'),
                onSaved: (newValue) => pantoneValue = newValue!,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Blog newBlog = Blog(
                      id: listBlog.length,
                      name: name,
                      year: int.parse(year),
                      color: color,
                      pantone_value: pantoneValue,
                    );
                    // repository.createBlog(newBlog);
                    listBlog.add(newBlog);

                    setState(() {
                      
                    });

                    // Navigator.of(context).pop();
                    Navigator.pop(context);
                  }
                },
                child: Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => showCreateForm(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: listBlog.map((data) {
          // Menggunakan widget Dismissible untuk menggeser item
          return Dismissible(
            // Menggunakan id sebagai kunci unik
            key: Key(data.id.toString()),
            // Menampilkan dialog konfirmasi sebelum menghapus
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Konfirmasi'),
                    content:
                        Text('Apakah Anda yakin ingin menghapus item ini?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Ya'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Tidak'),
                      ),
                    ],
                  );
                },
              );
            },
            // Menghapus item dari daftar saat digeser
            onDismissed: (direction) {
              deleteItem(listBlog.indexOf(data));
            },
            // Menampilkan background merah dengan ikon hapus saat digeser
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            // Menampilkan background merah dengan ikon hapus saat digeser ke arah yang berlawanan
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            // Menggunakan Container sebagai child dari Dismissible
            child: Container(
              // Menambahkan margin antara item
              margin: EdgeInsets.only(bottom: 10),
              // Menambahkan border berwarna biru
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                // Menambahkan shape berupa rounded rectangle
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [Text('Id : '), Text(data.id.toString())],
                  ),
                  Row(
                    children: [Text('Name : '), Text(data.name)],
                  ),
                  Row(
                    children: [Text('Color : '), Text(data.color)],
                  ),
                  Row(
                    children: [Text('Year : '), Text(data.year.toString())],
                  ),
                  Row(
                    children: [
                      Text('Pantone Value : '),
                      Text(data.pantone_value)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Menambahkan ikon hapus pada setiap item
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      // Menampilkan dialog konfirmasi sebelum menghapus
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Konfirmasi'),
                            content: Text(
                                'Apakah Anda yakin ingin menghapus item ini?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Menghapus item dari daftar
                                  deleteItem(listBlog.indexOf(data));
                                  // Menutup dialog
                                  Navigator.of(context).pop();
                                },
                                child: Text('Ya'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Tidak'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.edit),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
