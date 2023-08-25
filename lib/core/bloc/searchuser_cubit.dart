import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchUserLiveCubit extends Cubit<SearchUserLiveState> {
  SearchUserLiveCubit()
      : super(const SearchUserLiveState(
          "",
          false,
          true,
          {},
          {},
          10,
          1,
        ));

  void changeSearchText(String valueSearchText) {
    emit(state.copyWithSearchText(searchTextNew: valueSearchText));
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

class SearchUserLiveState extends Equatable {
  final String searchText;
  final bool mobileSearchIsExpanded;
  final bool mobileSearchIsClose;
  final Map<String, String> orderFields;
  final Map<String, dynamic> filters;
  final int pageSize;
  final int pageIndex;

  @override
  List<Object?> get props => [
        searchText,
        mobileSearchIsExpanded,
        mobileSearchIsClose,
        orderFields,
        filters,
        pageSize,
        pageIndex,
      ];

  const SearchUserLiveState(
    this.searchText,
    this.mobileSearchIsExpanded,
    this.mobileSearchIsClose,
    this.orderFields,
    this.filters,
    this.pageSize,
    this.pageIndex,
  );

  SearchUserLiveState copyWithSearchText({required String searchTextNew}) {
    final ous = SearchUserLiveState(
      searchTextNew,
      mobileSearchIsExpanded,
      mobileSearchIsClose,
      orderFields,
      filters,
      pageSize,
      pageIndex,
    );
    return ous;
  }

  SearchUserLiveState copyWithSearchClosed() {
    const ous = SearchUserLiveState(
      "",
      false,
      false,
      {},
      {},
      10,
      1,
    );
    return ous;
  }

  SearchUserLiveState copyWithOrderFields(
      {required Map<String, String> order}) {
    final ous = SearchUserLiveState(
      searchText,
      mobileSearchIsExpanded,
      mobileSearchIsClose,
      order,
      filters,
      pageSize,
      pageIndex,
    );
    return ous;
  }

  SearchUserLiveState copyWithNewSearcher(
      {required Map<String, String> order,
      required Map<String, dynamic> filtersList}) {
    final ous = SearchUserLiveState("", false, true, order, filtersList, 10, 1);
    return ous;
  }

  SearchUserLiveState copyWithFilterChange(
      {required String name, required dynamic changeValue}) {
    Map<String, dynamic> nfilters = <String, dynamic>{};
    nfilters.addAll(filters);
    nfilters[name] = changeValue;
    if (name == "positive" && changeValue as bool)
      nfilters["negative"] = !(changeValue);
    if (name == "negative" && changeValue as bool)
      nfilters["positive"] = !(changeValue);
    final ous = SearchUserLiveState(searchText, mobileSearchIsExpanded,
        mobileSearchIsClose, orderFields, nfilters, pageSize, pageIndex);
    return ous;
  }
}