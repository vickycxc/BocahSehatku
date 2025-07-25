// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/core/model/nav_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:flutter/material.dart';

class OrtuNavBar extends StatelessWidget {
  final int pageIndex;

  final List<NavModel> navItems;
  const OrtuNavBar({
    super.key,
    required this.pageIndex,
    required this.navItems,
  });

  @override
  Widget build(BuildContext context) {
    // Data navigasi;
    return BottomAppBar(
      height: 60,
      color: Palette.backgroundPrimaryColor,
      elevation: 0,
      child: Row(
        children: navItems.map((item) {
          return navItem(
            icon: item.icon,
            label: item.label,
            isSelected: pageIndex == navItems.indexOf(item),
            onTap: item.onTap,
          );
        }).toList(),
      ),
    );
  }
}

Widget navItem({
  required IconData icon,
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: InkWell(
      borderRadius: BorderRadius.circular(16.0),
      splashColor: Palette.backgroundSecondaryColor,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected ? Palette.accentColor : Palette.textPrimaryColor,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? Palette.accentColor
                  : Palette.textPrimaryColor,
            ),
          ),
        ],
      ),
    ),
  );
}
