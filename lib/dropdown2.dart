import 'package:dropdown_custom_hadi/data.dart';
import 'package:flutter/material.dart';

class SearcahbleDropdown2 extends StatefulWidget {
  const SearcahbleDropdown2({
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
  State<SearcahbleDropdown2> createState() => _SearcahbleDropdown2State();
}

class _SearcahbleDropdown2State extends State<SearcahbleDropdown2> {
  bool isOpen = false;
  DropdownData? selected;
  final key = GlobalKey();
  RenderBox? renderBox;
  OverlayState? ovstate;

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

        late RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
        late Offset position = box.globalToLocal(Offset.zero);
        print(position.dx);
        print(position.dy);

        if (widget.height == null && widget.width == null) {
          openOverlay(300, 300, position.dx.abs(), position.dy.abs());
        } else if (widget.width == null) {
          openOverlay(300, widget.height!, position.dx.abs(), position.dy.abs());
        } else if (widget.height == null) {
          openOverlay(widget.width!, 300, position.dx.abs(), position.dy.abs());
        }

        // if (widget.height != null) {
        //   selected = await openOverlay(widget.data, widget.height!);
        // } else if (widget.height != null && widget.width != null) {
        //   selected = await openOverlay(widget.data, widget.height!, widget.width!);
        // } else {
        //   selected = await openOverlay(widget.data);
        // }
        // widget.ontap(selected!);
        // setState(() {});
      },
      child: Container(
        key: key,
        margin: widget.margin,
        padding: const EdgeInsets.all(8),
        width: 300,
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

  void openOverlay(double w, double h, double x, double y) {
    print("overlay open");
    TextEditingController s = TextEditingController();
    OverlayState ost = Overlay.of(context);

    OverlayEntry entry = OverlayEntry(
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => Stack(
            children: [
              Positioned(
                top: y + 40,
                left: x,
                width: w,
                height: h,
                child: Material(
                  child: Container(
                    width: w,
                    height: h,
                    color: Colors.amber,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: TextField(
                            controller: s,
                            onChanged: (value) => setState(() {}),
                          ),
                        ),
                        Text(s.text),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    ost.insert(entry);
  }
}
