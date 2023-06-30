import 'package:dropdown_custom_hadi/data.dart';
import 'package:dropdown_custom_hadi/dropdown.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(backgroundColor: Color.fromARGB(255, 117, 109, 109), body: MyDropdown()),
    );
  }
}

class MyDropdown extends StatefulWidget {
  const MyDropdown({super.key});

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  GlobalKey key = GlobalKey();
  String dataa = "data";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Text("Searchable Dropdwon\n----------------------"),
          const SizedBox(height: 20),
          SearcahbleDropdown(
            data: dataval,
            hint: "Pilih",
            isDisable: false,
            ontap: (data) {
              print("hasil:${data.title}");
            },
          )
        ],
      ),
    );
  }
}
