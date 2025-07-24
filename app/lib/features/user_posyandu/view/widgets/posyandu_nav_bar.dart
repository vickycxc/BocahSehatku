// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/core/model/nav_model.dart';
import 'package:app/core/theme/palette.dart';
import 'package:flutter/material.dart';

class PosyanduNavBar extends StatelessWidget {
  final int pageIndex;

  final List<NavModel> navItems;
  const PosyanduNavBar({
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
        children: [
          navItem(
            icon: navItems[0].icon,
            label: navItems[0].label,
            isSelected: pageIndex == 0,
            onTap: navItems[0].onTap,
          ),
          navItem(
            icon: navItems[1].icon,
            label: navItems[1].label,
            isSelected: pageIndex == 1,
            onTap: navItems[1].onTap,
          ),
          navItem(
            icon: navItems[2].icon,
            label: navItems[2].label,
            isSelected: pageIndex == 2,
            onTap: navItems[2].onTap,
          ),
          SizedBox(
            width: 56,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Tambah Entri',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: Palette.textPrimaryColor,
                ),
              ),
            ),
          ),
          navItem(
            icon: navItems[3].icon,
            label: navItems[3].label,
            isSelected: pageIndex == 3,
            onTap: navItems[3].onTap,
          ),
          navItem(
            icon: navItems[4].icon,
            label: navItems[4].label,
            isSelected: pageIndex == 4,
            onTap: navItems[4].onTap,
          ),
          navItem(
            icon: navItems[5].icon,
            label: navItems[5].label,
            isSelected: pageIndex == 5,
            onTap: navItems[5].onTap,
          ),
        ],
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            icon,
            color: isSelected ? Palette.accentColor : Palette.textPrimaryColor,
            size: 24,
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
