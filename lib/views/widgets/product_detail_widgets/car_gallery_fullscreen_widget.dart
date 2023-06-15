// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:marketplace_frontend/src/blocs/carList/car_list_bloc.dart';
// import 'package:marketplace_frontend/src/widgets/car_detail_widgets/car_gallery_indicator_widget.dart';
// import 'package:marketplace_frontend/src/widgets/car_detail_widgets/car_zoom_gallery_list_widget.dart';
// import 'package:photo_view/photo_view.dart';
//
// class CarGalleryFullScreenWidget extends StatefulWidget {
//   final int pageInitial;
//   const CarGalleryFullScreenWidget({Key? key, required this.pageInitial}) : super(key: key);
//
//   @override
//   State<CarGalleryFullScreenWidget> createState() => _CarGalleryFullScreenWidgetState();
// }
//
// class _CarGalleryFullScreenWidgetState extends State<CarGalleryFullScreenWidget> with SingleTickerProviderStateMixin {
//   late PageController pageViewController = PageController(
//     initialPage: widget.pageInitial,
//     viewportFraction: 1,
//     keepPage: true,
//   );
//
//   late PhotoViewController photoviewController;
//
//   @override
//   void dispose() {
//     pageViewController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     photoviewController = PhotoViewController();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CarListBloc, CarListState>(builder: (context, state) {
//       return Scaffold(
//         backgroundColor: Colors.black,
//         body: WillPopScope(
//           onWillPop: _backPressed,
//           child: SafeArea(
//               child: Stack(
//             children: [
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CarZoomGalleryListsWidget(
//                       pageViewController: pageViewController,
//                       photoviewController: photoviewController,
//                       state: state,
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 48, left: 16, right: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     state.selectedCarDetail.carImage!.length > 1
//                         ? Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16),
//                               color: const Color(0xFF2C2626),
//                             ),
//                             width: 56,
//                             height: 32,
//                             child: Center(
//                               child: Text(
//                                 "${state.currentNumberActiveImage}/${state.selectedCarDetail.carImage!.length}",
//                                 style: const TextStyle(color: Colors.white, fontSize: 14),
//                               ),
//                             ))
//                         : const SizedBox(
//                             width: 56,
//                             height: 32,
//                           ),
//                     InkWell(
//                       onTap: () {
//                         context.read<CarListBloc>().add(
//                               const SetOnFullscreenGallery(false),
//                             );
//                         Navigator.of(context).pop();
//                       },
//                       child: const Icon(
//                         Icons.close,
//                         size: 24,
//                         color: Color(0xFFA4A8AD),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Center(
//                 child: state.selectedCarDetail.carImage!.length > 1
//                     ? Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           CarGalleryIndicatorWidget(
//                             state: state,
//                             pageViewController: pageViewController,
//                           ),
//                         ],
//                       )
//                     : Container(),
//               ),
//             ],
//           )),
//         ),
//       );
//     });
//   }
//
//   Future<bool> _backPressed() async {
//     context.read<CarListBloc>().add(
//           const SetOnFullscreenGallery(false),
//         );
//     Navigator.of(context).pop();
//
//     return true;
//   }
// }
