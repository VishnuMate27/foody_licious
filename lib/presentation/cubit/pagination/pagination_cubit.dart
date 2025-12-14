import 'package:flutter_bloc/flutter_bloc.dart';

class PaginationState {
  final int currentPage;
  final bool isLoadingMore;
  final bool hasMoreItems;

  PaginationState({
    this.currentPage = 1,
    this.isLoadingMore = false,
    this.hasMoreItems = true,
  });

  PaginationState copyWith({
    int? currentPage,
    bool? isLoadingMore,
    bool? hasMoreItems,
  }) {
    return PaginationState(
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMoreItems: hasMoreItems ?? this.hasMoreItems,
    );
  }
}

class PaginationCubit extends Cubit<PaginationState> {
  PaginationCubit() : super(PaginationState());

  void loadMoreItems() {
    if (state.isLoadingMore || !state.hasMoreItems) return;

    emit(
      state.copyWith(isLoadingMore: true, currentPage: state.currentPage + 1),
    );
  }

  void setHasMoreItems(bool hasMore) {
    emit(state.copyWith(hasMoreItems: hasMore, isLoadingMore: false));
  }

  void reset() {
    emit(PaginationState());
  }
}
