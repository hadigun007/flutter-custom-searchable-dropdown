import 'package:dropdown_custom_hadi/data.dart';
import 'package:flutter/material.dart';

class SearcahbleDropdown extends StatefulWidget {
  const SearcahbleDropdown({
    super.key,
    required this.data,
    required this.hint,
    required this.ontap,
    this.isDisable,
    this.height,
    this.width,
    this.margin,
  });

  final List<DropdownData> data;
  final String hint;
  final double? height;
  final double? width;
  final bool? isDisable;
  final EdgeInsets? margin;
  final Function(DropdownData data) ontap;

  @override
  State<SearcahbleDropdown> createState() => _SearcahbleDropdownState();
}

class _SearcahbleDropdownState extends State<SearcahbleDropdown> {
  bool isOpen = false;
  DropdownData? selected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.isDisable == true) {
          return;
        }
        if (isOpen == true) {
          isOpen = false;
        } else {
          isOpen = true;
        }
        if (widget.height != null) {
          selected = await openDialog(widget.data, widget.height!);
        } else if (widget.height != null && widget.width != null) {
          selected = await openDialog(widget.data, widget.height!, widget.width!);
        } else {
          selected = await openDialog(widget.data);
        }
        widget.ontap(selected!);
        setState(() {});
      },
      child: Container(
        margin: widget.margin,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(width: 1, color: Colors.black)),
        constraints: const BoxConstraints(minWidth: 200, maxWidth: 300),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selected == null ? widget.hint : selected!.title,
              style: TextStyle(color: widget.isDisable == true ? Colors.grey : Colors.black),
            ),
            Icon(isOpen == true ? Icons.expand_less : Icons.expand_more, color: widget.isDisable == true ? Colors.grey : Colors.black)
          ],
        ),
      ),
    );
  }

  Future<DropdownData?> openDialog(List<DropdownData> data, [double h = 300, double w = 200]) async {
    TextEditingController s = TextEditingController();
    List<DropdownData> filtered = List.from(data);
    DropdownData? selected;

    selected = await showDialog(
      anchorPoint: const Offset(400, 200),
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            width: w,
            height: h,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextField(
                    controller: s,
                    enabled: data.isNotEmpty,
                    style: const TextStyle(fontSize: 13),
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filtered = data.where((element) => element.title.toLowerCase().contains(value.toLowerCase())).toList();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) => Material(
                      type: MaterialType.transparency,
                      animationDuration: const Duration(milliseconds: 500),
                      child: ListTile(
                        hoverColor: const Color.fromARGB(255, 197, 197, 197),
                        onTap: () {
                          selected = filtered[index];
                          Navigator.pop(context, selected);
                        },
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                        leading: filtered[index].icon ?? const Icon(Icons.wallet),
                        title: Text(filtered[index].title),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    return selected;
  }
}
