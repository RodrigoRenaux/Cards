import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:target_cards/themes/colors.dart';

class CardComponent extends StatelessWidget {
  const CardComponent(
      {required this.text,
      required this.index,
      this.cardWidth = 60,
      this.canUpdate = true,
      this.onUpdate,
      this.onDelete,
      Key? key})
      : super(key: key);

  final String text;
  final int index;
  final double cardWidth;
  final bool canUpdate;
  final Function(int index)? onUpdate;
  final Function(int index)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
            width: cardWidth,
            decoration: BoxDecoration(color: AppColors.white),
            child: ResponsiveBuilder(builder: (context, sizingInformation) {
              var headerSize = sizingInformation.localWidgetSize.height * .16;
              var indent = sizingInformation.localWidgetSize.width * .06;
              return Column(children: [
                SizedBox(
                    height: headerSize,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Text(
                              canUpdate
                                  ? "Texto Digitado ${index + 1}"
                                  : "Novo Texto",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Row(children: [
                            if (onUpdate != null)
                              IconButton(
                                  onPressed: () => onUpdate!(index),
                                  padding: EdgeInsets.zero,
                                  icon:
                                      Icon(Icons.edit, size: headerSize * .8)),
                            if (onDelete != null)
                              IconButton(
                                  onPressed: () => onDelete!(index),
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.delete_forever_rounded,
                                      size: headerSize * .8))
                          ])
                        ])),
                Divider(indent: indent, endIndent: indent),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16))))
              ]);
            })));
  }
}
