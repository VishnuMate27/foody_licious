// navigation_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0); // Default to Home tab (index 0)

  void changeTab(int index) {
    emit(index);
  }
}
