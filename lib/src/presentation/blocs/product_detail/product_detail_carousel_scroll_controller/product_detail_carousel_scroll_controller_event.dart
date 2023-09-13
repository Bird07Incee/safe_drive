part of 'product_detail_carousel_scroll_controller_bloc.dart';

class ProductDetailCarouselScrollControllerEvent extends Equatable {
  const ProductDetailCarouselScrollControllerEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CarouselScrollAction extends ProductDetailCarouselScrollControllerEvent {
  final int index;
  const CarouselScrollAction({required this.index});
}
