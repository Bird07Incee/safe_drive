// import 'package:flutter/material.dart';
// import 'package:marketplace_frontend/src/blocs/carList/car_list_bloc.dart';
// import 'package:marketplace_frontend/src/extensions/string_extension.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
//
// // ignore: must_be_immutable
// class CarZoomGalleryListsWidget extends StatelessWidget {
//   final CarListState state;
//   final PageController pageViewController;
//   final PhotoViewController photoviewController;
//
//   const CarZoomGalleryListsWidget({
//     Key? key,
//     required this.state,
//     required this.pageViewController,
//     required this.photoviewController,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     double maxWidth = MediaQuery.of(context).size.width;
//     return Expanded(
//         child: AspectRatio(
//       aspectRatio: 16 / 9,
//       child: PhotoViewGallery.builder(
//         customSize: Size(maxWidth, 285),
//         scrollPhysics: const BouncingScrollPhysics(),
//         builder: (BuildContext ctx, int i) {
//           return PhotoViewGalleryPageOptions.customChild(
//             controller: photoviewController,
//             child: GestureDetector(
//               onDoubleTap: () {
//                 photoviewController.scale = photoviewController.value.scale == 1.0 ? 2.0 : 1.0;
//               },
//               child: Image.network(
//                 i == state.selectedCarDetail.carImage!.length
//                     ? state.selectedCarDetail.carImage![0]
//                     : state.selectedCarDetail.carImage![i],
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) => Image.asset(
//                   "assets/homepage/placeholder_image.png".toAssetPath(),
//                   height: 900,
//                   fit: BoxFit.cover,
//                 ),
//                 loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//                   if (loadingProgress != null) {
//                     return Image.asset(
//                       "assets/homepage/placeholder_image.png".toAssetPath(),
//                       height: 900,
//                       fit: BoxFit.cover,
//                     );
//                   }
//                   return child;
//                 },
//               ),
//             ),
//             maxScale: PhotoViewComputedScale.covered * 4,
//             minScale: PhotoViewComputedScale.covered,
//             initialScale: PhotoViewComputedScale.covered,
//           );
//         },
//         itemCount: state.selectedCarDetail.carImage!.length == 1
//             ? state.selectedCarDetail.carImage!.length
//             : state.selectedCarDetail.carImage!.length + 1,
//         pageController: pageViewController,
//         allowImplicitScrolling: true,
//         onPageChanged: (val) {
//           if (val == state.selectedCarDetail.carImage!.length) {
//             pageViewController.jumpToPage(0);
//             context.read<CarListBloc>().add(const SetFixibleCurrentNumberActiveImage(1));
//           } else {
//             context.read<CarListBloc>().add(SetCurrentNumberActiveImage(val));
//           }
//           photoviewController.scale = 2.0;
//           photoviewController.scale = 1.0;
//         },
//       ),
//     ));
//   }
// }
