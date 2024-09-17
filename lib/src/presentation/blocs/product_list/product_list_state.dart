part of 'product_list_bloc.dart';

enum GetProductListStatus { initial, loading, loadingTranparent, success, maintenance, error }

class ProductListState extends Equatable {
  const ProductListState(
      {this.productList = const ProductList(productAllItems: 0, productPage: 0, productCountItems: 0, banner: [], category: [], products: []),
      this.productListStatus = GetProductListStatus.initial});

  final ProductList productList;
  final GetProductListStatus productListStatus;

  @override
  List<Object> get props => [productList, productListStatus];

  ProductListState copyWith({
    ProductList? productList,
    GetProductListStatus? productListStatus,
    int? selectedTabIndex,
    double? scrollPosition,
  }) {
    return ProductListState(productList: productList ?? this.productList, productListStatus: productListStatus ?? this.productListStatus);
  }
}
