import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/check_browser/check_browser_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/connectivity_status/connectivity_status_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/img_gallery_zoom/img_gallery_zoom_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/previous_scale/previous_scale_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_carousel_scroll_controller/product_detail_carousel_scroll_controller_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/scroll_product_detail/scroll_product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/view_img_detail_page_switch/view_img_detail_page_switch_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_list/product_list_bloc.dart';

final List<BlocProvider> blocs = [
  BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
  BlocProvider<CheckBrowserBloc>(create: (_) => CheckBrowserBloc()),
  BlocProvider<ConnectivityStatusBloc>(create: (_) => ConnectivityStatusBloc()),
  BlocProvider<ScrollProductDetailBloc>(create: (_) => ScrollProductDetailBloc()),
  BlocProvider<ProductDetailCarouselScrollControllerBloc>(create: (_) => ProductDetailCarouselScrollControllerBloc()),
  BlocProvider<ImgGalleryZoomBloc>(create: (_) => ImgGalleryZoomBloc()),
  BlocProvider<PreviousScaleBloc>(create: (_) => PreviousScaleBloc()),
  BlocProvider<ViewImgDetailPageSwitchBloc>(create: (_) => ViewImgDetailPageSwitchBloc()),
  BlocProvider<ProductListBloc>(create: (_) => ProductListBloc()),
];
