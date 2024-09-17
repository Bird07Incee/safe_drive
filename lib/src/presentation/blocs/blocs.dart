import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/check_browser/check_browser_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/home/home_cubit.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/order_success/order_success_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/order_summary/order_summary_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/order_summary/show_summary_detail_cubit.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/produc_detail_tagline_toggle/product_detail_description_cubit.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/img_gallery_zoom/img_gallery_zoom_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/previous_scale/previous_scale_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_carousel_scroll_controller/product_detail_carousel_scroll_controller_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/scroll_product_detail/scroll_product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/view_img_detail_page_switch/view_img_detail_page_switch_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_list/active_images_index.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_list/home_scroll_controller_cubit.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_options/product_options_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund_request/refund_request_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund_success/refund_success_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/shipping_address/shipping_address_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/tracking_detail/tracking_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/tracking_order/tracking_order_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/webview/webview_bloc.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';

final List<BlocProvider> blocs = [
  BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
  BlocProvider<CheckBrowserBloc>(create: (_) => CheckBrowserBloc()),
  BlocProvider<ScrollProductDetailBloc>(create: (_) => ScrollProductDetailBloc()),
  BlocProvider<ProductDetailCarouselScrollControllerBloc>(create: (_) => ProductDetailCarouselScrollControllerBloc()),
  BlocProvider<ImgGalleryZoomBloc>(create: (_) => ImgGalleryZoomBloc()),
  BlocProvider<PreviousScaleBloc>(create: (_) => PreviousScaleBloc()),
  BlocProvider<ViewImgDetailPageSwitchBloc>(create: (_) => ViewImgDetailPageSwitchBloc()),
  BlocProvider<ProductListBloc>(create: (_) => ProductListBloc(utilityRepository: _.read<DioUtilityRepository>())),
  BlocProvider<HomeScrollControllerCubit>(create: (_) => HomeScrollControllerCubit()),
  BlocProvider<ProductOptionBloc>(create: (_) => ProductOptionBloc()),
  BlocProvider<ProductDetailBloc>(create: (_) => ProductDetailBloc(utilityRepository: _.read<DioUtilityRepository>())),
  BlocProvider<ActiveImagesIndexCubit>(create: (_) => ActiveImagesIndexCubit()),
  BlocProvider<OrderSuccessBloc>(create: (_) => OrderSuccessBloc(utilityRepository: _.read<DioUtilityRepository>())),
  BlocProvider<OrderSummaryBloc>(create: (_) => OrderSummaryBloc(utilityRepository: _.read<DioUtilityRepository>())),
  BlocProvider<ShowSummaryDetailCubit>(create: (_) => ShowSummaryDetailCubit()),
  BlocProvider<ShippingAddressBloc>(create: (_) => ShippingAddressBloc(utilityRepository: _.read<DioUtilityRepository>())),
  //BlocProvider<ShowSaleCodeCubit>(create: (_) => ShowSaleCodeCubit()),
  BlocProvider<TrackingOrderBloc>(create: (_) => TrackingOrderBloc(utilityRepository: _.read<DioUtilityRepository>())),
  BlocProvider<TrackingDetailBloc>(create: (_) => TrackingDetailBloc(utilityRepository: _.read<DioUtilityRepository>())),
  BlocProvider<ProductDetailDescriptionCubit>(create: (_) => ProductDetailDescriptionCubit()),
  BlocProvider<RefundRequestBloc>(create: (_) => RefundRequestBloc(utilityRepository: _.read<DioUtilityRepository>())),
  BlocProvider<RefundSuccessBloc>(create: (_) => RefundSuccessBloc(utilityRepository: _.read<DioUtilityRepository>())),
  BlocProvider<WebViewBloc>(create: (_) => WebViewBloc()),
  BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
];
