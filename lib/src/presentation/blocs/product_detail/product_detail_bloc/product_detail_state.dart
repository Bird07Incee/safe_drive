part of 'product_detail_bloc.dart';

enum ProductDetailStatus { initial, loading, success, error }

extension ProductStatusX on ProductDetailStatus {
  bool get isInitial => this == ProductDetailStatus.initial;
  bool get isLoading => this == ProductDetailStatus.loading;
  bool get isSuccess => this == ProductDetailStatus.success;
  bool get isError => this == ProductDetailStatus.error;
}

class ProductDetailState extends Equatable {
  const ProductDetailState({this.status = ProductDetailStatus.initial, this.product = Product.empty});
  final ProductDetailStatus status;
  final Product product;

  @override
  List<Object> get props => [status];

  ProductDetailState copyWith({ProductDetailStatus? status, Product? product}) {
    return ProductDetailState(status: status ?? this.status, product: product ?? this.product);
  }
}
