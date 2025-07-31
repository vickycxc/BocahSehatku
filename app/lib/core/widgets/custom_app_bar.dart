import 'package:app/core/theme/palette.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget content;
  final double height;
  final Color backgroundColor;
  const CustomAppBar({
    super.key,
    required this.content,
    this.height = 40,
    this.backgroundColor = Palette.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        color: backgroundColor,
      ),
      child: content,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + height);
}
