part of 'product_list_bloc.dart';

enum GetProductListStatus { initial, loading, loadingTranparent, success, error }

class ProductListState extends Equatable {
  const ProductListState({
    this.productList = const ProductList(
        productAllItems: 0, productPage: 0, productCountItems: 0, banner: [], category: [], products: []),
    this.productListStatus = GetProductListStatus.initial,
    this.selectedTabIndex = 0,
    this.hideCategory = false,
  });

  final ProductList productList;
  final GetProductListStatus productListStatus;
  final int selectedTabIndex;
  final bool hideCategory;

  @override
  List<Object> get props => [productList, productListStatus, selectedTabIndex, hideCategory];

  ProductListState copyWith({
    ProductList? productList,
    GetProductListStatus? productListStatus,
    int? selectedTabIndex,
    bool? hideCategory,
  }) {
    return ProductListState(
      productList: productList ?? this.productList,
      productListStatus: productListStatus ?? this.productListStatus,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      hideCategory: hideCategory ?? this.hideCategory,
    );
  }
}
