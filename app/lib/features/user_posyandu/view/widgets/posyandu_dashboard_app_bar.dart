import 'package:app/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PosyanduDashboardAppBar extends StatelessWidget {
  const PosyanduDashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // final List<String> subNama = nama.split(' ');
    // final String namaDuaKata = subNama.length > 1
    //     ? '${subNama[0]} ${subNama[1]}'
    //     : subNama[0];
    return SliverAppBar(
      actions: [
        InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              LucideIcons.refreshCwOff600,
              color: Palette.backgroundPrimaryColor,
              size: 24,
            ),
          ),
        ),
      ],

      actionsPadding: EdgeInsets.only(right: 32),
      title: Text(
        'Halo, Posyandu Melati',
        style: TextStyle(
          color: Palette.backgroundPrimaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Palette.accentColor,
      pinned: true,
      floating: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      expandedHeight: 170,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          decoration: BoxDecoration(
            color: Palette.accentColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Palette.backgroundPrimaryColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(height: 8),
                              SvgPicture.asset(
                                'assets/baby_no_bg.svg',
                                width: 42,
                                height: 42,
                              ),
                              SizedBox(height: 4),
                              Text.rich(
                                TextSpan(
                                  text: '4500',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.textPrimaryColor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' anak terlayani pada bulan ini',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Palette.textPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Palette.backgroundPrimaryColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(height: 8),
                              SvgPicture.asset(
                                'assets/baby_no_bg.svg',
                                width: 42,
                                height: 42,
                              ),
                              SizedBox(height: 4),
                              Text.rich(
                                TextSpan(
                                  text: '396',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.textPrimaryColor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' anak terlayani pada tahun ini',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Palette.textPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),

                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
