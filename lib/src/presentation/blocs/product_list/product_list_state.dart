part of 'product_list_bloc.dart';

class ProductListState extends Equatable {
  const ProductListState({productList})
      : productList = productList ??
            const ProductList(
                productAllItems: 0, productPage: 0, productCountItems: 0, banner: [], category: [], products: []);

  final ProductList productList;

  @override
  List<Object> get props => [productList];

  ProductListState copyWith({ProductList? productList}) {
    return ProductListState(productList: productList ?? this.productList);
  }
}
