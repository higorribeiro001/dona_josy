// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartStore on _CartStore, Store {
  late final _$cartsAtom = Atom(name: '_CartStore.carts', context: context);

  @override
  List<Cart> get carts {
    _$cartsAtom.reportRead();
    return super.carts;
  }

  @override
  set carts(List<Cart> value) {
    _$cartsAtom.reportWrite(value, super.carts, () {
      super.carts = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_CartStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isPixLoadingAtom = Atom(
    name: '_CartStore.isPixLoading',
    context: context,
  );

  @override
  bool get isPixLoading {
    _$isPixLoadingAtom.reportRead();
    return super.isPixLoading;
  }

  @override
  set isPixLoading(bool value) {
    _$isPixLoadingAtom.reportWrite(value, super.isPixLoading, () {
      super.isPixLoading = value;
    });
  }

  late final _$isMutatingAtom = Atom(
    name: '_CartStore.isMutating',
    context: context,
  );

  @override
  bool get isMutating {
    _$isMutatingAtom.reportRead();
    return super.isMutating;
  }

  @override
  set isMutating(bool value) {
    _$isMutatingAtom.reportWrite(value, super.isMutating, () {
      super.isMutating = value;
    });
  }

  late final _$currentPageAtom = Atom(
    name: '_CartStore.currentPage',
    context: context,
  );

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$totalPagesAtom = Atom(
    name: '_CartStore.totalPages',
    context: context,
  );

  @override
  int get totalPages {
    _$totalPagesAtom.reportRead();
    return super.totalPages;
  }

  @override
  set totalPages(int value) {
    _$totalPagesAtom.reportWrite(value, super.totalPages, () {
      super.totalPages = value;
    });
  }

  late final _$totalElementsAtom = Atom(
    name: '_CartStore.totalElements',
    context: context,
  );

  @override
  int get totalElements {
    _$totalElementsAtom.reportRead();
    return super.totalElements;
  }

  @override
  set totalElements(int value) {
    _$totalElementsAtom.reportWrite(value, super.totalElements, () {
      super.totalElements = value;
    });
  }

  late final _$statusFilterAtom = Atom(
    name: '_CartStore.statusFilter',
    context: context,
  );

  @override
  String get statusFilter {
    _$statusFilterAtom.reportRead();
    return super.statusFilter;
  }

  @override
  set statusFilter(String value) {
    _$statusFilterAtom.reportWrite(value, super.statusFilter, () {
      super.statusFilter = value;
    });
  }

  late final _$categoryFilterAtom = Atom(
    name: '_CartStore.categoryFilter',
    context: context,
  );

  @override
  String get categoryFilter {
    _$categoryFilterAtom.reportRead();
    return super.categoryFilter;
  }

  @override
  set categoryFilter(String value) {
    _$categoryFilterAtom.reportWrite(value, super.categoryFilter, () {
      super.categoryFilter = value;
    });
  }

  late final _$totalAtom = Atom(name: '_CartStore.total', context: context);

  @override
  double get total {
    _$totalAtom.reportRead();
    return super.total;
  }

  @override
  set total(double value) {
    _$totalAtom.reportWrite(value, super.total, () {
      super.total = value;
    });
  }

  late final _$pixCopyPasteAtom = Atom(
    name: '_CartStore.pixCopyPaste',
    context: context,
  );

  @override
  String? get pixCopyPaste {
    _$pixCopyPasteAtom.reportRead();
    return super.pixCopyPaste;
  }

  @override
  set pixCopyPaste(String? value) {
    _$pixCopyPasteAtom.reportWrite(value, super.pixCopyPaste, () {
      super.pixCopyPaste = value;
    });
  }

  late final _$unreadNotificationsAtom = Atom(
    name: '_CartStore.unreadNotifications',
    context: context,
  );

  @override
  List<Map<String, dynamic>> get unreadNotifications {
    _$unreadNotificationsAtom.reportRead();
    return super.unreadNotifications;
  }

  @override
  set unreadNotifications(List<Map<String, dynamic>> value) {
    _$unreadNotificationsAtom.reportWrite(value, super.unreadNotifications, () {
      super.unreadNotifications = value;
    });
  }

  late final _$loadAsyncAction = AsyncAction(
    '_CartStore.load',
    context: context,
  );

  @override
  Future<void> load(BuildContext context, {required bool isAdmin, int? page}) {
    return _$loadAsyncAction.run(
      () => super.load(context, isAdmin: isAdmin, page: page),
    );
  }

  late final _$refreshNotificationsAsyncAction = AsyncAction(
    '_CartStore.refreshNotifications',
    context: context,
  );

  @override
  Future<void> refreshNotifications() {
    return _$refreshNotificationsAsyncAction.run(
      () => super.refreshNotifications(),
    );
  }

  late final _$markNotificationReadAsyncAction = AsyncAction(
    '_CartStore.markNotificationRead',
    context: context,
  );

  @override
  Future<void> markNotificationRead(String id) {
    return _$markNotificationReadAsyncAction.run(
      () => super.markNotificationRead(id),
    );
  }

  late final _$updateCartStatusAsyncAction = AsyncAction(
    '_CartStore.updateCartStatus',
    context: context,
  );

  @override
  Future<bool> updateCartStatus(
    BuildContext context,
    Cart cart,
    String status, {
    required bool isAdmin,
  }) {
    return _$updateCartStatusAsyncAction.run(
      () => super.updateCartStatus(context, cart, status, isAdmin: isAdmin),
    );
  }

  late final _$generatePixAsyncAction = AsyncAction(
    '_CartStore.generatePix',
    context: context,
  );

  @override
  Future<void> generatePix(BuildContext context) {
    return _$generatePixAsyncAction.run(() => super.generatePix(context));
  }

  late final _$changeStatusFilterAsyncAction = AsyncAction(
    '_CartStore.changeStatusFilter',
    context: context,
  );

  @override
  Future<void> changeStatusFilter(String? value, BuildContext context) {
    return _$changeStatusFilterAsyncAction.run(
      () => super.changeStatusFilter(value, context),
    );
  }

  late final _$filterAdminAsyncAction = AsyncAction(
    '_CartStore.filterAdmin',
    context: context,
  );

  @override
  Future<void> filterAdmin(BuildContext context) {
    return _$filterAdminAsyncAction.run(() => super.filterAdmin(context));
  }

  late final _$setAdminCategoryAsyncAction = AsyncAction(
    '_CartStore.setAdminCategory',
    context: context,
  );

  @override
  Future<void> setAdminCategory(String? value, BuildContext context) {
    return _$setAdminCategoryAsyncAction.run(
      () => super.setAdminCategory(value, context),
    );
  }

  @override
  String toString() {
    return '''
carts: ${carts},
isLoading: ${isLoading},
isPixLoading: ${isPixLoading},
isMutating: ${isMutating},
currentPage: ${currentPage},
totalPages: ${totalPages},
totalElements: ${totalElements},
statusFilter: ${statusFilter},
categoryFilter: ${categoryFilter},
total: ${total},
pixCopyPaste: ${pixCopyPaste},
unreadNotifications: ${unreadNotifications}
    ''';
  }
}
