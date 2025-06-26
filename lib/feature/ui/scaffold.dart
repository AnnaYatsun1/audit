import 'package:flutter/material.dart';
import 'package:sound_level_meter/feature/home/view.dart';

// class CustomScaffold extends StatefulWidget {
//   const CustomScaffold({
//     super.key,
//     required this.child,
//     required this.appBarMode,
//     required this.appBarIsVisible,
//     this.showBackButton,
//     this.onBack,
//     this.title,
//     this.aBarImage, this.onMenuTap, this.onScanTap, this.onSearchTap,
//   });
//   final Widget child;
//   final bool appBarIsVisible;
//   final String? title;
//   final Image? aBarImage;
//   final bool? showBackButton;
//     final VoidCallback? onMenuTap;
//   final VoidCallback? onScanTap;
//   final VoidCallback? onSearchTap;
//     final VoidCallback? onBack;
//     final AppBarMode appBarMode;
//   @override
//   State<CustomScaffold> createState() => _CustomScaffoldState();
// }

// class _CustomScaffoldState extends State<CustomScaffold> {
//   // List<Color> colors1 = [Color(0xFF1E3C72), Color(0xFF2A5298)];
//   Color colors2 = Colors.black;
//   // , Color.fromARGB(255, 28, 26, 26)];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: CustomSideBar(),
//       // endDrawer: CustomSideBar(),
//       // appBar: CustomAppBar(title: 'title'),
//       resizeToAvoidBottomInset: false,
//       appBar: widget.appBarIsVisible
//           ? CustomAppBar(

//              mode: widget.appBarMode,
//             title: widget.title,
//             onBack: widget.onBack,
//             onMenuTap: widget.onMenuTap,
//             onScanTap: widget.onScanTap,
//             onSearchCancel: widget.onSearchTap,
//             searchController: widget.searchController,
//             )
//           : null,
//       extendBodyBehindAppBar: true,
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: colors2,
//                 // gradient: LinearGradient(
//                 //     colors: colors2,
//                 //     begin: Alignment.topCenter,
//                 //     end: Alignment.bottomCenter)
//                     ),
//           ),
//           SafeArea(child: widget.child)
//         ],
//       ),
//     );
//   }
// }
class CustomScaffold extends StatefulWidget {
  final Widget child;
  final bool appBarIsVisible;
  final AppBarMode appBarMode;
  final String? title;
  final TextEditingController? searchController;
  final VoidCallback? onBack;
  final VoidCallback? onMenuTap;
  final VoidCallback? onScanTap;
  final VoidCallback? onSearchTap;

  const CustomScaffold({
    super.key,
    required this.child,
    required this.appBarIsVisible,
    this.appBarMode = AppBarMode.titleOnly,
    this.title,
    this.searchController,
    this.onBack,
    this.onMenuTap,
    this.onScanTap,
    this.onSearchTap,
  });

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        drawer: const Drawer(),
        resizeToAvoidBottomInset: false,
        appBar: widget.appBarIsVisible
            ? CustomAppBar(
                mode: widget.appBarMode,
                title: widget.title,
                onBack: widget.onBack,
                onMenuTap: widget.onMenuTap,
                onScanTap: widget.onScanTap,
                onSearchTap: widget.onSearchTap,
                // searchController: widget.searchController,
              )
            : null,
        body: Stack(
          children: [
            widget.child,
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                // gradient: LinearGradient(
                //     colors: colors2,
                //     begin: Alignment.topCenter,
                //     end: Alignment.bottomCenter)
              ),
            ),
            SafeArea(child: widget.child)
          ],
//       ),
          // widget.child,
        ));
  }
}

enum AppBarMode {
  main,
  search,
  titleOnly,
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarMode mode;
  final String? title;
  final VoidCallback? onBack;
  final VoidCallback? onMenuTap;
  final VoidCallback? onScanTap;
  final VoidCallback? onSearchTap;
  // final TextEditingController? searchController;

  const CustomAppBar({
    super.key,
    required this.mode,
    this.title,
    this.onBack,
    this.onMenuTap,
    this.onScanTap,
    this.onSearchTap,
    // this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case AppBarMode.search:
        return AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onSearchTap,
          ),
          title: CustomSearchBar(),
          // controller: searchController!),
        );

      case AppBarMode.titleOnly:
        return AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onBack,
          ),
          title: Text(title ?? '', style: const TextStyle(color: Colors.white)),
          centerTitle: true,
        );

      case AppBarMode.main:
      default:
        return AppBar(
          backgroundColor: Colors.black,
          title: CustomSearchBar(),
          // controller: searchController!),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: onMenuTap,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
              onPressed: onScanTap,
            ),
          ],
        );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
//   final String? title;
//   final List<Widget>? actions;
//   final bool showBackButton;
//   final Widget? leading;
//   final Image? image;
//   final bool showImage;

//   const CustomAppBar({
//     super.key,
//     required this.title,
//     this.actions,
//     this.showBackButton = false,
//     this.leading,
//     this.image,
//     this.showImage = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(
//         title ?? '',
//         style: TextStyle(color: Colors.white),
//       ),
//       backgroundColor: Colors.black,
//       elevation: 4,
//       centerTitle: true,
//       iconTheme: IconThemeData(),
//       leading: showBackButton
//           ? IconButton(
//               icon: Icon(Icons.arrow_back, color: Colors.white),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             )
//           : null,
//       actions: [
//         ...?actions,
//         if (showImage && image != null)
//           Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: image!,
//           ),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

class CustomSideBar extends StatelessWidget {
  const CustomSideBar({super.key});
// [Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 28, 26, 26)];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black87,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.black
                // backgroundBlendMode: BlendMode.colorDodge
                ),
            onDetailsPressed: () {
              print('open detail Screen');
            },
            accountName: Text(''),
            accountEmail: Text(''),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Icon(Icons.supervised_user_circle),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.language,
              color: Colors.white,
            ),
            title: Text(
              'Languages',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              print('open settings screen');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: Text('Setting', style: TextStyle(color: Colors.white)),
            onTap: () {
              print('open settings screen');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: Text('Exit', style: TextStyle(color: Colors.white)),
            onTap: () {
              print('open settings screen');
            },
          ),
        ],
      ),
    );
  }
}
