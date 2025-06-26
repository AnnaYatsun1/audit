import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sound_level_meter/feature/ui/theme/theme.dart';
import 'package:sound_level_meter/router/router.dart';

class BottomBar extends StatefulWidget {
  final TabsRouter tabsRouter;
  const BottomBar({super.key, required this.tabsRouter});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  Color getButtonColor(int index) {
    return widget.tabsRouter.activeIndex == index
        ? Colors.black.withOpacity(0.9)// Активная вкладка
        :Colors.black.withOpacity(0.9);
  }

// Color(0xFFF1C40F),  Color(0xFFFFD700)
  Color getIconColor(int index) {
    return widget.tabsRouter.activeIndex == index
        ? Colors.red
        : const Color(0xFF4D4D4D); //
  }


  Color getIconColor2(int index) {
    return widget.tabsRouter.activeIndex == index
        ?    Color(0xFFFFA600)
        : themeDark.canvasColor; 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: Border(
        //   top: BorderSide(
        //   color:  themeDark.canvasColor,
        //   width: 2,
        //   )
        // ),
      ),
      child: Row(
        children: [
          _buildNavItem(0, 'assets/images/recognition.png'),
          _buildNavItem(1, 'assets/images/pin.png'),
          _buildNavItem(2, 'assets/images/reports.png'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String assetPath) {
    return Expanded(
  
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: 
              InkWell(
                onTap: () async {
                  if (index == 1) {
                    await Permission.microphone.request();
                  }
                  return widget.tabsRouter.setActiveIndex(index);
                },
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  height: 60,
        
                  decoration: BoxDecoration(
                    color: getButtonColor(index),
                    
                    // border: Border(
                    //     bottom: BorderSide(
                    //       color: getIconColor(index), 
                    //       width: 3)),
                
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child:  Image.asset(
                        assetPath, 
                        color: getIconColor2(index),),
                          
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
