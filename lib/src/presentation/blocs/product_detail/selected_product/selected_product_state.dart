part of 'selected_product_bloc.dart';
class SelectedProductState {
  const SelectedProductState({this.selectedProduct = Product.empty});

  final Product selectedProduct;

  SelectedProductState copyWith({Product? selectedProduct}) {
    return SelectedProductState(selectedProduct: selectedProduct ?? this.selectedProduct);
  }
}
