// import 'package:flutter/material.dart';
// import 'package:marketplace_line_oa/helpers/extensions.dart';
//
// // ignore: must_be_immutable
// class CarGalleryListsWidget extends StatelessWidget {
//   // ignore: prefer_typing_uninitialized_variables
//   late PageController pageViewController;
//   CarGalleryListsWidget({
//     Key? key,
//     required this.pageViewController,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     double maxWidth = MediaQuery.of(context).size.width;
//     return SizedBox(
//       width: maxWidth,
//       height: 260,
//       child: PageView.builder(
//           itemCount: state.selectedCarDetail.carImage!.length == 1
//               ? state.selectedCarDetail.carImage!.length
//               : state.selectedCarDetail.carImage!.length + 1,
//           pageSnapping: true,
//           controller: pageViewController,
//           allowImplicitScrolling: true,
//           onPageChanged: (val) {
//             if (!state.onFullscreenGallery) {
//               if (val == state.selectedCarDetail.carImage!.length) {
//                 context.read<CarListBloc>().add(const SetFixibleCurrentNumberActiveImage(1));
//                 pageViewController.jumpToPage(0);
//               } else {
//                 context.read<CarListBloc>().add(SetCurrentNumberActiveImage(val));
//               }
//             }
//           },
//           itemBuilder: (ctx, i) {
//             return AspectRatio(
//               aspectRatio: 16 / 9,
//               child: SizedBox(
//                 width: maxWidth,
//                 height: 576,
//                 child: Image.network(
//                   i == state.selectedCarDetail.carImage!.length
//                       ? state.selectedCarDetail.carImage![0]
//                       : state.selectedCarDetail.carImage![i],
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => Image.asset(
//                     "assets/homepage/placeholder_image.png",
//                     height: 900,
//                     fit: BoxFit.cover,
//                   ),
//                   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//                     if (loadingProgress != null) {
//                       return Image.asset(
//                         "assets/homepage/placeholder_image.png",
//                         height: 900,
//                         fit: BoxFit.cover,
//                       );
//                     }
//                     return child;
//                   },
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }
