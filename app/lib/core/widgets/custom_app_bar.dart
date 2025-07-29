import 'package:app/core/theme/palette.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget content;
  final double height;
  const CustomAppBar({super.key, required this.content, this.height = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        color: Palette.accentColor,
      ),
      child: content,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + height);
}
