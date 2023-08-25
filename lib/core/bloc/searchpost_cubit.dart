import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPostLiveCubit extends Cubit<SearchPostLiveState> {
  SearchPostLiveCubit()
      : super(SearchPostLiveState(
            "", false, true, const {}, const {}, 10, 1, DateTime.now()));

  void changeSearchText(String valueSearchText) {
    emit(state.copyWithSearchText(searchTextNew: valueSearchText));
  }

  void changeSearchTextCloseMobile() {
    emit(state.copyWithSearchClosed());
  }

  void cleanSearchText() {
    emit(state.copyWithSearchClean());
  }

  void changeMobileSearchExpand(bool expand) {
    emit(state.copyWithMobileSearchChangeExpand(isExpanded: expand));
  }

  void changeMobileSearchExpandEndAnimated(bool animated) {
    emit(state.copyWithMobileSearchChangeExpandEndAnimated(
        endAnimated: animated));
  }

  void setOrderFields(Map<String, String> orderList) {
    emit(state.copyWithOrderFields(order: orderList));
  }

  void setConfigSearch(
      Map<String, String> orderListOptions, Map<String, dynamic> filterList) {
    emit(state.copyWithNewSearcher(
        order: orderListOptions, filtersList: filterList));
  }

  void changeFilterValue(String filtername, dynamic value) {
    emit(state.copyWithFilterChange(name: filtername, changeValue: value));
  }
}

class SearchPostLiveState extends Equatable {
  final String searchText;
  final bool mobileSearchIsExpanded;
  final bool mobileSearchIsClose;
  final Map<String, String> orderFields;
  final Map<String, dynamic> filters;
  final int pageSize;
  final int pageIndex;
  final DateTime dateNow;

  @override
  List<Object?> get props => [
        searchText,
        mobileSearchIsExpanded,
        mobileSearchIsClose,
        orderFields,
        filters,
        pageSize,
        pageIndex,
        dateNow
      ];

  const SearchPostLiveState(
    this.searchText,
    this.mobileSearchIsExpanded,
    this.mobileSearchIsClose,
    this.orderFields,
    this.filters,
    this.pageSize,
    this.pageIndex,
    this.dateNow,
  );

  SearchPostLiveState copyWithSearchText({required String searchTextNew}) {
    final ous = SearchPostLiveState(
      searchTextNew,
      mobileSearchIsExpanded,
      mobileSearchIsClose,
      orderFields,
      filters,
      pageSize,
      pageIndex,
      DateTime.now(),
    );
    return ous;
  }

  SearchPostLiveState copyWithMobileSearchChangeExpand(
      {required bool isExpanded}) {
    final ous = SearchPostLiveState(
      searchText,
      isExpanded,
      mobileSearchIsClose,
      orderFields,
      filters,
      pageSize,
      pageIndex,
      DateTime.now(),
    );
    return ous;
  }

  SearchPostLiveState copyWithMobileSearchChangeExpandEndAnimated(
      {required bool endAnimated}) {
    final ous = SearchPostLiveState(
      searchText,
      mobileSearchIsExpanded,
      endAnimated,
      orderFields,
      filters,
      pageSize,
      pageIndex,
      DateTime.now(),
    );
    return ous;
  }

  SearchPostLiveState copyWithSearchClosed() {
    final ous = SearchPostLiveState(
      "",
      false,
      false,
      {},
      {},
      10,
      1,
      DateTime.now(),
    );
    return ous;
  }

  SearchPostLiveState copyWithSearchClean() {
    final ous = SearchPostLiveState(
      "",
      mobileSearchIsExpanded,
      mobileSearchIsClose,
      {},
      {},
      10,
      1,
      DateTime.now(),
    );
    return ous;
  }

  SearchPostLiveState copyWithOrderFields(
      {required Map<String, String> order}) {
    final ous = SearchPostLiveState(
      searchText,
      mobileSearchIsExpanded,
      mobileSearchIsClose,
      order,
      filters,
      pageSize,
      pageIndex,
      DateTime.now(),
    );
    return ous;
  }

  SearchPostLiveState copyWithNewSearcher(
      {required Map<String, String> order,
      required Map<String, dynamic> filtersList}) {
    final ous = SearchPostLiveState(
      searchText,
      false,
      true,
      order,
      filtersList,
      10,
      1,
      DateTime.now(),
    );
    return ous;
  }

  SearchPostLiveState copyWithFilterChange(
      {required String name, required dynamic changeValue}) {
    Map<String, dynamic> nfilters = <String, dynamic>{};
    nfilters.addAll(filters);
    nfilters[name] = changeValue;
    if (name == "positive" && changeValue as bool)
      nfilters["negative"] = !(changeValue);
    if (name == "negative" && changeValue as bool)
      nfilters["positive"] = !(changeValue);
    final ous = SearchPostLiveState(
      searchText,
      mobileSearchIsExpanded,
      mobileSearchIsClose,
      orderFields,
      nfilters,
      pageSize,
      pageIndex,
      DateTime.now(),
    );
    return ous;
  }
}
