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
