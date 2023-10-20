import 'package:flutter_bloc/flutter_bloc.dart';

class ShowSaleCodeCubit extends Cubit<bool> {
  ShowSaleCodeCubit() : super(false);
  static ShowSaleCodeCubit get(context) => BlocProvider.of(context);

  void show(bool show) {
    emit(show);
  }
}
