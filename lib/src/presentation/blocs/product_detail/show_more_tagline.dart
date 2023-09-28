import 'package:flutter_bloc/flutter_bloc.dart';

class ShowMoreTagLineCubit extends Cubit<bool> {
  ShowMoreTagLineCubit() : super(true);
  static ShowMoreTagLineCubit get(context) => BlocProvider.of(context);

  void toggle() {
    emit(!state);
  }
}
