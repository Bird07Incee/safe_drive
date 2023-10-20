import 'package:flutter_bloc/flutter_bloc.dart';

class ShowSummaryDetailCubit extends Cubit<bool> {
  ShowSummaryDetailCubit() : super(false);
  static ShowSummaryDetailCubit get(context) => BlocProvider.of(context);

  void toggle() {
    emit(!state);
  }
}
