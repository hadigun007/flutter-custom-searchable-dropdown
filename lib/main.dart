import 'package:dropdown_custom_hadi/data.dart';
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
          GestureDetector(
            onTap: () async {
              dataa = await openDialog(200, 300, countries) ?? "";
              print("returned data $dataa");
              setState(() {});
            },
            child: Container(
              key: key,
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              decoration: BoxDecoration(color: const Color.fromARGB(255, 214, 214, 214), borderRadius: BorderRadius.circular(8)),
              width: 200,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(dataa), const Icon(Icons.expand_more)],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<String?> openDialog(double w, double h, List<String> data) async {
    TextEditingController s = TextEditingController();

    TextStyle style1 = const TextStyle(fontSize: 10, color: Colors.grey);

    List filtered = List.from(data);
    String? selected;

    print("open dialog called");
    selected = await showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 0),
              alignment: const AlignmentDirectional(0, 0),
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: w,
                  height: h,
                  child: Column(
                    children: [
                      TextField(
                          controller: s,
                          onChanged: (v) => setState(() {
                                filtered = data.where((element) => element.toLowerCase().contains(v.toLowerCase())).toList();
                              })),
                      Text("-----", style: style1),
                      Text(s.text, style: style1),
                      Text("Match: ${filtered.length}", style: style1),
                      Text("All Data: ${data.length}", style: style1),
                      Text("-----", style: style1),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                onTap: () {
                                  selected = filtered[index];
                                  print(selected);
                                  Navigator.pop(context, selected);
                                },
                                title: Text(filtered[index]));
                          },
                        ),
                      )
                    ],
                  )));
        },
      ),
    );
    return selected;
  }
}


// import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// @immutable
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'After Layout - Good Example',
//       home: HomeScreen(),
//     );
//   }
// }

// @immutable
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   HomeScreenState createState() => HomeScreenState();
// }

// class HomeScreenState extends State<HomeScreen> {
//   final key = GlobalKey();
//   RenderBox? renderBox;
//   OverlayState? overlay;

//   List<String> data = [
//     "Nama 1",
//     "Nama 2",
//     "Nama 3",
//     "Nama 4",
//     "Nama 5",
//     "Nama 6",
//     "Nama 7",
//     "Nama 8",
//     "Nama 9",
//     "Nama 10",
//     "Nama 11",
//     "Nama 12",
//     "Nama 13",
//     "Nama 14",
//     "Nama 15",
//     "Nama 16",
//     "Nama 17",
//     "Nama 18",
//     "Nama 19",
//     "Nama 20",
//   ];
//   TextEditingController search = TextEditingController();
//   TextEditingController test = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black45,
//       body: Column(
//         children: [
//           /////////
//           TextField(
//             controller: test,
//             style: const TextStyle(color: Colors.white),
//             onChanged: (value) => setState(() {}),
//           ),
//           Text(
//             test.text,
//             style: const TextStyle(color: Colors.white),
//           ),
//           /////////
//           const SizedBox(height: 20),
//           Center(
//             child: GestureDetector(
//               onTap: () {
//                 late RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
//                 late Offset position = box.globalToLocal(Offset.zero);
//                 late Size size = box.size; // or _widgetKey.currentContext?.size
//                 print('Size: width: ${size.width}, height: ${size.height}');
//                 print('position : dx ${position.dx}, dy ${position.dy.abs()}');

//                 print("show overlay start");
//                 _insertOverlay(context, position, size, data);

//                 print("show overlay end");
//               },
//               child: Container(
//                 width: 300,
//                 height: 50,
//                 color: Colors.purple,
//                 key: key,
//               ),
//             ),
//           ),

//           const SizedBox(height: 70),
//           Center(
//             child: TextButton(
//                 onPressed: () {
//                   showDialogOnButtonPress(context);
//                 },
//                 child: const Text("dialog")),
//           )
//         ],
//       ),
//     );
//   }

//   void _insertOverlay(BuildContext context, Offset offset, Size sizeC, List<String> data) {
//     List<String> filtered = List.from(data);
//     return Overlay.of(context).insert(
//       OverlayEntry(builder: (context) {
//         return Positioned(
//           top: offset.dy.abs() + 50,
//           left: offset.dx.abs() - 20,
//           child: Material(
//             color: Colors.amberAccent,
//             elevation: 3,
//             borderRadius: BorderRadius.circular(8),
//             child: Column(
//               children: [
//                 Container(
//                     height: 30,
//                     width: sizeC.width,
//                     margin: const EdgeInsets.symmetric(horizontal: 20),
//                     child: TextField(
//                       controller: search,
//                       onChanged: (value) => setState(() {}),
//                       // onChanged: (val) {
//                       //   if (search.text == "") {
//                       //     print("text kossong, reset");
//                       //     setState(() {
//                       //       filtered = data;
//                       //     });
//                       //     print("setelah reset: ${filtered.length}");
//                       //     return;
//                       //   }
//                       //   filtered = data.where((element) => element.toLowerCase().contains(search.text.toLowerCase())).toList();
//                       //   setState(() {});
//                       // },
//                     )),
//                 Text(search.text),
//                 Text("Match: ${filtered.length}"),
//                 Text("Origin: ${data.length}"),
//                 Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     margin: const EdgeInsets.only(top: 10),
//                     width: sizeC.width,
//                     constraints: const BoxConstraints(maxHeight: 150),
//                     child: ListView.builder(
//                       itemCount: filtered.length,
//                       itemBuilder: (context, index) => Text(filtered[index]),
//                     )),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   showDialogOnButtonPress(BuildContext context) {
//     TextEditingController s = TextEditingController();
//     showDialog(
//       context: context,
//       // barrierDismissible: false,
//       builder: (BuildContext context) {
//         return StatefulBuilder(builder: (context, setState) {
//           return Dialog(
//             insetPadding: const EdgeInsets.all(18),
//             elevation: 8,
//             shadowColor: Colors.white,
//             insetAnimationDuration: const Duration(seconds: 1),
//             insetAnimationCurve: Curves.easeInCirc,
//             surfaceTintColor: Colors.deepOrange,
//             backgroundColor: Colors.amber,
//             alignment: Alignment.bottomCenter,
//             child: SizedBox(
//               width: 200,
//               height: 100,
//               child: Column(
//                 children: [
//                   TextField(controller: s, onChanged: (v) => setState(() {})),
//                   const Text("-----"),
//                   Text(s.text),
//                   const Text("-----"),
//                 ],
//               ),
//             ),
//           );
//         });
//       },
//     );
//   }
// }

// //  print("Screen Width: ${size.width}");
// //         print("Screen Height: ${size.height}");

// //         print("==================");
// //         print("Position X: ${offset.dx}");
// //         print("Position Y: ${offset.dy}");
// //         print("==================");
