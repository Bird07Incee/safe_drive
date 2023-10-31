part of 'scroll_product_detail_bloc.dart';

abstract class ScrollProductDetailEvent extends Equatable {}

class ProductDetailScrollAction extends ScrollProductDetailEvent {
  final double pixels;
  final double maxWidth;
  final String isPopNavigator;
  ProductDetailScrollAction(this.pixels, this.maxWidth, this.isPopNavigator);

  @override
  List<Object?> get props => [pixels, maxWidth, isPopNavigator];
}

// class AppbarNormal extends ScrollProductDetailEvent {}
