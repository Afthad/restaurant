import 'package:flutter/material.dart';
import 'package:restaurant_app/widgets/common_widgets.dart';

class CategoryListWidget extends StatefulWidget {
  final String categoryName;
  final String count;
final VoidCallback action;
  final Widget widget;
 final bool isOpen;
  const CategoryListWidget({
    super.key,
    required this.action,
    required this.categoryName,
    required this.count,
    required this.widget,
    required this.isOpen,
  });

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.action,
          child: ListTile(
            title: textWidget(
                text: widget.categoryName,
                fontSize: 16,
                fontWeight: FontWeight.w500),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                textWidget(text: widget.count, color: Colors.grey,fontSize: 15),
               const SizedBox(width: 4,),
              !widget.isOpen?  const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 12,
                  color: Colors.grey,
                ):const RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                   Icons.arrow_forward_ios_outlined,
                    size: 12,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
        widget.widget,
        const Divider()
      ],
    );
  }
}
