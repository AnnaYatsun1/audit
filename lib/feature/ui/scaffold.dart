  import 'dart:async';

  import 'package:flutter/material.dart';
import 'package:sound_level_meter/feature/home/view/home_screen.dart';
  import 'package:sound_level_meter/main.dart';

  class CustomScaffold extends StatefulWidget {
    const CustomScaffold({
      super.key,
      required this.child,
      required this.appBarIsVisible,
      this.showBackButton,
      this.title,
      this.aBarImage,
    });
    final Widget child;
    final bool appBarIsVisible;
    final String? title;
    final Image? aBarImage;
    final bool? showBackButton;
    @override
    State<CustomScaffold> createState() => _CustomScaffoldState();
  }

  class _CustomScaffoldState extends State<CustomScaffold> {
    List<Color> colors1 = [Color(0xFF1E3C72), Color(0xFF2A5298)];
    List<Color> colors2 = [Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 28, 26, 26)];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        endDrawer: CustomSideBar(),
        // appBar: CustomAppBar(title: 'title'),
        resizeToAvoidBottomInset: false,
        appBar: widget.appBarIsVisible ? CustomAppBar(
        showBackButton: widget.showBackButton ?? false, 
        title: widget.title ?? ''
          , image: null,
        ) : null,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: colors2,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
            SafeArea(child: widget.child)
          ],
        ),
      );
    }
  }

  class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
    final String? title;
    final List<Widget>? actions;
    final bool showBackButton;
    final Widget? leading;
    final Image? image;
    final bool showImage;

    const CustomAppBar({
      super.key,
      required this.title,
      this.actions,
      this.showBackButton = false,
      this.leading,
      this.image,
      this.showImage = true,
    });

    @override
    Widget build(BuildContext context) {
      return AppBar(
        title: Text(
          title ?? '',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:  Color.fromARGB(255, 0, 0, 0),
        
        elevation: 4,
        centerTitle: true,
        iconTheme: IconThemeData(),
        leading: showBackButton
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : null,
        actions: [
          ...?actions,
          if (showImage && image != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: image!,
            ),
        ],
      );
    }

    @override
    Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  }
