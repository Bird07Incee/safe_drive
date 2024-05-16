part of 'product_list_bloc.dart';

class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class GetProductList extends ProductListEvent {
  const GetProductList();
}

class GetProductListByCategory extends ProductListEvent {
  const GetProductListByCategory(this.categoryId, this.context, {this.bypassContext = false});

  final String categoryId;
  final BuildContext context;
  final bool bypassContext;
}

class GetProductListByPage extends ProductListEvent {
  const GetProductListByPage(this.productList, this.page, this.categoryId, this.context, {this.bypassContext = false});

  final ProductList productList;
  final int page;
  final String categoryId;
  final BuildContext context;
  final bool bypassContext;
}

class SetSelectTabIndex extends ProductListEvent {
  const SetSelectTabIndex(this.selectedTabIndex);

  final int selectedTabIndex;
}

class SetScrollPosition extends ProductListEvent {
  const SetScrollPosition(this.scrollPosition);

  final double scrollPosition;
}
