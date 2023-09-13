part of 'scroll_product_detail_bloc.dart';

abstract class ScrollProductDetailEvent {}

class ProductDetailScrollAction extends ScrollProductDetailEvent {
  double pixels;
  BuildContext context;
  String isPopNavigator;
  ProductDetailScrollAction(this.pixels, this.context, this.isPopNavigator);
}

class AppbarNormal extends ScrollProductDetailEvent {}
