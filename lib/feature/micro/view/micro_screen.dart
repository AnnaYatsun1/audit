import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sound_level_meter/feature/bottom_bar/bottom_bar.dart';
import 'package:sound_level_meter/feature/settings/view.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';
import 'package:sound_level_meter/feature/ui/theme/theme.dart';
import 'package:sound_level_meter/router/router.dart';
import 'micro.dart';

@RoutePage()
class MicroScreen extends StatefulWidget {
  
  const MicroScreen({super.key});

  @override
  State<MicroScreen> createState() => _MicroScreenState();
}

class _MicroScreenState extends State<MicroScreen> {
  final Map<int, String?> selectedBrands = {};

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarIsVisible: true,
      child: GridView.builder(
          itemCount: 4 ,//(storege.leng + 1),
          
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 10,
              childAspectRatio: 3 / 4),
          itemBuilder: (context, index) {
            if (index < 2) { //storege.leng ) 
               return AddStoreCard(onTap: () {

               },);
              //  LocationCard(isSelected: false, onSelect: () {
                
              //  },);
            } else {
               return AddStoreCard(onTap: () {
      
             });
            }
           
          }),
    );
  }
}

// class LocationCard extends StatelessWidget {
//     final bool isSelected;
//   final VoidCallback onSelect;
//   const LocationCard({super.key, required this.isSelected, required this.onSelect});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // decoration: BoxDecoration(
//       //     color: Colors.cyanAccent, borderRadius: BorderRadius.circular(12)),
//       // backgroundColor: Colors.blueGrey,
//       child: Card(
//         color:  const Color(0xFF1E1E1E),
        
//         child: Padding(
//           padding: const EdgeInsets.only(top: 1.0),
//           child: Column(
//             children: [
//             Stack(
//               children: [
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: Padding(
//                     padding: const EdgeInsets.all(1.0),
//                     child: IconButton(
//                      icon: Icon(Icons.more_vert),
//                             onPressed: () => _showPlatformMenu(context),
//                     ),
//                   ),
//                 ),
//               ]
//             ),
//               Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Test 111',
//                         style: themeDark.textTheme.labelLarge,
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(
//                         height: 16,
//                       ),
//                       Text(
//                         'Test 2222',
//                         style: themeDark.textTheme.labelMedium,
//                              textAlign: TextAlign.center,
//                       ),

//               // ListView.builder(
//               //     itemCount: 1,
//               //     shrinkWrap: true,
//               //     itemBuilder: (context, index) {
//               //       return AdaptiveBrandSelector(
//               //           selectedBrand: "",
//               //           brands: [
//               //             'Comp',
//               //             'Monitor',
//               //             'Mouse',
//               //             'Keyboard',
//               //             'Micropphone'
//               //           ],
//               //           textOfBrand: 'Brend',
//               //           onBrandSelected: (brand) {
                          
//               //             // setState(() {
//               //             //   selectedBrands[1] = brand;
//               //             // }
//               //             // );
//               //           });
//               //        }),
//                     ],
//                   )),
//               Spacer(),
//               CustomCuertinoButtom(),
//               SizedBox(height: 16,),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//     void _showPlatformMenu(BuildContext context) {
//     if (Theme.of(context).platform == TargetPlatform.iOS) {
//       showCupertinoModalPopup(
//           context: context,
//           builder: (context) => CupertinoActionSheet(
//                 title: Text(''),
//                 actions: [
//                   CupertinoActionSheetAction(
//                       onPressed: () {
//                         print('Редагувати');
//                       },
//                       child: Text('Edit')),
//                   CupertinoActionSheetAction(
//                       onPressed: () {
//                         print('Видалити ');
//                       },
//                       child: Text('Delete'))
//                 ],
//                 cancelButton: CupertinoActionSheetAction(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text('Скасувати'),
//                 ),
//               ));
//     } else {
//       showMenu(
//         context: context,
//         position: RelativeRect.fromLTRB(100, 100, 0, 0),
//         items: [      
//            PopupMenuItem(value: 'Edit', child: Text('Редагувати')),
//           PopupMenuItem(value: 'Delete', child: Text('Видалити')),],
//       );
//     }
//   }
// }
