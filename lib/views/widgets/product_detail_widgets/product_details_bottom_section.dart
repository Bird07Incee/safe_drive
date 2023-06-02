// import 'package:banana_ui/constants/styles/theme_data.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:marketplace_line_oa/agument_model/loan_screen_arguments.dart';
// import 'package:marketplace_line_oa/blocs/carList/product_list_bloc.dart';
// import 'package:marketplace_line_oa/blocs/contact/contact_bloc.dart';
// import 'package:marketplace_line_oa/constants/routes.dart';
// import 'package:marketplace_line_oa/helpers/extensions.dart';
// import 'package:marketplace_line_oa/helper/analytic_helper.dart';
// import 'package:marketplace_line_oa/models/product_list.dart';
// import 'package:marketplace_line_oa/pages/widgets/shared/general_dialog.dart';
// import 'package:marketplace_line_oa/pages/widgets/shared/static_maps.dart';
//
// class BottomSection extends StatelessWidget {
//   const BottomSection({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     double maxWidth = MediaQuery.of(context).size.width;
//     double maxHeight = MediaQuery.of(context).size.height;
//     return BlocBuilder<CarListBloc, CarListState>(
//       builder: (context, state) {
//         return Container(
//           margin: EdgeInsets.only(bottom: (maxHeight * 0.1) + 32.0),
//           width: maxWidth,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                 key: const Key("banner_select_loan_button"),
//                 onTap: () {
//                   ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                   Navigator.pushNamed(context, Routes.selectLoan.toStringPath(),
//                       arguments: LoanScreenArguments(
//                         salePrice: state.selectedCarDetail.discountPrice! > 0
//                             ? '${state.selectedCarDetail.discountPrice!}'
//                             : '${state.selectedCarDetail.price!}',
//                         carType: state.selectedCarDetail.carType!,
//                         brand: state.selectedCarDetail.brand!,
//                         model: state.selectedCarDetail.model!,
//                         subModel: state.selectedCarDetail.submodel!,
//                         manufactureYear: '${state.selectedCarDetail.manufactureYear!}',
//                         partnerName: state.selectedCarDetail.partnerName!,
//                       ));
//                 },
//                 child: SizedBox(
//                   width: maxWidth,
//                   child: Image.asset(
//                     "assets/images/banner_ps_dld.png",
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//               Visibility(
//                 visible: !(state.selectedCarDetail.dealerAddressLatLong != "" &&
//                             state.selectedCarDetail.dealerAddressLatLong != null) &&
//                         !(state.selectedCarDetail.dealerLineId != "") &&
//                         !(state.selectedCarDetail.dealerMobileNumberMap != null &&
//                             state.selectedCarDetail.dealerMobileNumberMap!.isNotEmpty)
//                     ? false
//                     : true,
//                 child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Text(
//                       "เกี่ยวกับผู้ขาย",
//                       key: const Key("dealer_detail_title"),
//                       style: const TextTheme().bodyLarge?.copyWith(fontSize: 16),
//                     )),
//               ),
//               state.selectedCarDetail.dealerAddressLatLong != null &&
//                       state.selectedCarDetail.dealerAddressLatLong!.isLatLong()
//                   ? Center(
//                       child: StaticMaps(
//                       key: const Key("static_maps"),
//                       width: maxWidth - 32.0,
//                       height: 80.0,
//                       zoom: 15,
//                       latLng: state.selectedCarDetail.dealerAddressLatLong!,
//                     ))
//                   : const SizedBox(),
//               state.selectedCarDetail.dealerName != null && state.selectedCarDetail.dealerName != ""
//                   ? Container(
//                       height: 24.0,
//                       margin: const EdgeInsets.only(top: 16.0),
//                       padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//                       child: Text(
//                         state.selectedCarDetail.dealerName!,
//                         style: const TextTheme().bodyLarge?.copyWith(fontSize: 14),
//                       ),
//                     )
//                   : SizedBox(
//                       height: state.selectedCarDetail.dealerAddressLatLong != "" &&
//                               state.selectedCarDetail.dealerAddressLatLong != null
//                           ? 16.0
//                           : 0,
//                     ),
//               state.selectedCarDetail.dealerAddress != null && state.selectedCarDetail.dealerAddress != ""
//                   ? Container(
//                       height: 32.0,
//                       padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//                       child: Text(
//                         state.selectedCarDetail.dealerAddress!,
//                         style: const TextTheme().bodyMedium?.copyWith(fontSize: 10),
//                       ),
//                     )
//                   : const SizedBox(),
//               state.selectedCarDetail.noContacts
//                   ? const SizedBox()
//                   : Container(
//                       margin: EdgeInsets.only(
//                           top: state.selectedCarDetail.dealerAddressLatLong != "" &&
//                                   state.selectedCarDetail.dealerAddressLatLong != null
//                               ? 16.0
//                               : 0),
//                       padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             state.selectedCarDetail.dealerLineId != "" ||
//                                     (state.selectedCarDetail.dealerMobileNumberMap != null &&
//                                         state.selectedCarDetail.dealerMobileNumberMap!.isNotEmpty)
//                                 ? SizedBox(
//                                     width: state.selectedCarDetail.dealerAddressLatLong != "" &&
//                                             state.selectedCarDetail.dealerAddressLatLong != null
//                                         ? 96
//                                         : maxWidth - 32.0,
//                                     child: Row(
//                                       children: [
//                                         (state.selectedCarDetail.dealerMobileNumberMap != null &&
//                                                 state.selectedCarDetail.dealerMobileNumberMap!.isNotEmpty)
//                                             ? Expanded(
//                                                 child: Padding(
//                                                 padding: const EdgeInsets.only(right: 8),
//                                                 child: GestureDetector(
//                                                   key: const Key("open_dealer_contact_button"),
//                                                   onTap: () async {
//                                                     GeneralDialog().showDealerContactDialog(context);
//                                                   },
//                                                   child: Container(
//                                                       height: 40.0,
//                                                       decoration: BoxDecoration(
//                                                         border: Border.all(color: const Color(0xffDEDEDE)),
//                                                         borderRadius: BorderRadius.circular(8),
//                                                       ),
//                                                       child: Center(
//                                                         child: SizedBox(
//                                                           width: 24.0,
//                                                           height: 24.0,
//                                                           child: Image.asset(
//                                                             "assets/icons/icon_call.png",
//                                                             fit: BoxFit.contain,
//                                                           ),
//                                                         ),
//                                                       )),
//                                                 ),
//                                               ))
//                                             : const SizedBox(),
//                                         state.selectedCarDetail.dealerLineId != ""
//                                             ? Expanded(
//                                                 child: Padding(
//                                                 padding: const EdgeInsets.only(right: 8),
//                                                 child: GestureDetector(
//                                                   key: const Key("open_dealer_line_button"),
//                                                   onTap: () {
//                                                     GeneralDialog().showDealerLineIdDialog(context);
//                                                   },
//                                                   child: Container(
//                                                       height: 40.0,
//                                                       decoration: BoxDecoration(
//                                                         border: Border.all(color: const Color(0xffDEDEDE)),
//                                                         borderRadius: BorderRadius.circular(8),
//                                                       ),
//                                                       child: Center(
//                                                         child: SizedBox(
//                                                             width: 24.0,
//                                                             height: 24.0,
//                                                             child: Image.asset(
//                                                               "assets/icons/icon_line.png",
//                                                               fit: BoxFit.contain,
//                                                             )),
//                                                       )),
//                                                 ),
//                                               ))
//                                             : const SizedBox(),
//                                       ],
//                                     ),
//                                   )
//                                 : const SizedBox(),
//                             state.selectedCarDetail.dealerAddressLatLong != "" &&
//                                     state.selectedCarDetail.dealerAddressLatLong != null
//                                 ? Expanded(
//                                     child: GestureDetector(
//                                     key: const Key("open_dealer_location_button"),
//                                     onTap: () async {
//                                       if (state.selectedCarDetail.dealerAddressLatLong!.isLatLong()) {
//                                         context.read<ContactBloc>().add(SetContactDetail(
//                                             type: ContactType.maps,
//                                             lat: state.selectedCarDetail.lat,
//                                             long: state.selectedCarDetail.long,
//                                             keyword: state.selectedCarDetail.dealerName ?? ""));
//                                         Navigator.pushNamed(context, Routes.termAndCondition.toStringPath());
//                                       }
//                                     },
//                                     child: Container(
//                                       height: 40,
//                                       width: maxWidth * 0.65,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(color: const Color(0xffDEDEDE)),
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       child: Center(
//                                           child: Text("ดูแผนที่",
//                                               style: const TextTheme().bodyLarge?.copyWith(fontSize: 16))),
//                                     ),
//                                   ))
//                                 : const SizedBox()
//                           ]),
//                     ),
//               Container(
//                   key: const Key("annotation_section"),
//                   width: maxWidth,
//                   margin: const EdgeInsets.only(top: 16.0),
//                   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.only(bottom: 8.0),
//                         height: 24.0,
//                         child: Text(
//                           "หมายเหตุ",
//                           style: const TextTheme().bodyLarge?.copyWith(fontSize: 14),
//                         ),
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("  •  ", style: const TextTheme().bodyMedium?.copyWith(fontSize: 12, height: 2)),
//                           Expanded(
//                             child: Text(
//                               "ลูกค้าที่สนใจกรุณาติดต่อผู้ขายรถ เพื่อตรวจสอบสถานะของรถ ก่อนที่จะทำการสมัครสินเชื่อ",
//                               style: const TextTheme().bodyMedium?.copyWith(fontSize: 12, height: 2),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("  •  ", style: const TextTheme().bodyMedium?.copyWith(fontSize: 12, height: 2)),
//                           Expanded(
//                             child: Text(
//                               "กรุงศรี ออโต้เป็นเพียงผู้ให้บริการสินเชื่อรถเท่านั้น",
//                               style: const TextTheme().bodyMedium?.copyWith(fontSize: 12, height: 2),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("  •  ", style: const TextTheme().bodyMedium?.copyWith(fontSize: 12, height: 2)),
//                           Expanded(
//                             child: Text(
//                               "ข้อมูลรถที่ประกาศขายเป็นความตกลงระหว่างผู้ขายรถ กับผู้ให้บริการซื้อขายรถออนไลน์ (แพลตฟอร์มซื้อขายรถออนไลน์)",
//                               style: const TextTheme().bodyMedium?.copyWith(fontSize: 12, height: 2),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   )),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
