import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveImagesIndexCubit extends Cubit<List<int>> {
  ActiveImagesIndexCubit() : super([]);
  static ActiveImagesIndexCubit get(context) => BlocProvider.of(context);

  void initialItems(List<int> l) {
    emit(l);
  }

  void update(int itemIndex, int activeIndex) {
    state[itemIndex] = activeIndex;
    List<int> newItems = List.of(state);
    emit(newItems);
  }
}
