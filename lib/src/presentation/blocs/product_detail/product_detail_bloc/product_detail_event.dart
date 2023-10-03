part of 'product_detail_bloc.dart';

class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class GetProductByID extends ProductDetailEvent {
  const GetProductByID({this.pid = ''});
  final String pid;

  @override
  List<Object> get props => [pid];
}

class SetProduct extends ProductDetailEvent {
  const SetProduct({required this.product});
  final Product product;

  @override
  List<Object> get props => [product];
}
