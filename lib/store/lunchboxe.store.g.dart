// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lunchboxe.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LunchboxeStore on _LunchboxeStore, Store {
  late final _$imageAtom = Atom(
    name: '_LunchboxeStore.image',
    context: context,
  );

  @override
  String? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(String? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  late final _$isEditingAtom = Atom(
    name: '_LunchboxeStore.isEditing',
    context: context,
  );

  @override
  bool get isEditing {
    _$isEditingAtom.reportRead();
    return super.isEditing;
  }

  @override
  set isEditing(bool value) {
    _$isEditingAtom.reportWrite(value, super.isEditing, () {
      super.isEditing = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_LunchboxeStore.isLoading',
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

  late final _$optionsAtom = Atom(
    name: '_LunchboxeStore.options',
    context: context,
  );

  @override
  List<dynamic> get options {
    _$optionsAtom.reportRead();
    return super.options;
  }

  @override
  set options(List<dynamic> value) {
    _$optionsAtom.reportWrite(value, super.options, () {
      super.options = value;
    });
  }

  late final _$storedImageAtom = Atom(
    name: '_LunchboxeStore.storedImage',
    context: context,
  );

  @override
  File? get storedImage {
    _$storedImageAtom.reportRead();
    return super.storedImage;
  }

  @override
  set storedImage(File? value) {
    _$storedImageAtom.reportWrite(value, super.storedImage, () {
      super.storedImage = value;
    });
  }

  late final _$lunchboxesAtom = Atom(
    name: '_LunchboxeStore.lunchboxes',
    context: context,
  );

  @override
  List<Lunchboxe> get lunchboxes {
    _$lunchboxesAtom.reportRead();
    return super.lunchboxes;
  }

  @override
  set lunchboxes(List<Lunchboxe> value) {
    _$lunchboxesAtom.reportWrite(value, super.lunchboxes, () {
      super.lunchboxes = value;
    });
  }

  late final _$currentPageAtom = Atom(
    name: '_LunchboxeStore.currentPage',
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
    name: '_LunchboxeStore.totalPages',
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
    name: '_LunchboxeStore.totalElements',
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

  late final _$getLunchboxesAsyncAction = AsyncAction(
    '_LunchboxeStore.getLunchboxes',
    context: context,
  );

  @override
  Future getLunchboxes(BuildContext context, {int? page, String? query}) {
    return _$getLunchboxesAsyncAction.run(
      () => super.getLunchboxes(context, page: page, query: query),
    );
  }

  late final _$setProductActiveAsyncAction = AsyncAction(
    '_LunchboxeStore.setProductActive',
    context: context,
  );

  @override
  Future<void> setProductActive(Lunchboxe lunchboxe, BuildContext context) {
    return _$setProductActiveAsyncAction.run(
      () => super.setProductActive(lunchboxe, context),
    );
  }

  late final _$addLunchboxeAsyncAction = AsyncAction(
    '_LunchboxeStore.addLunchboxe',
    context: context,
  );

  @override
  Future<bool> addLunchboxe(BuildContext context) {
    return _$addLunchboxeAsyncAction.run(() => super.addLunchboxe(context));
  }

  late final _$takePictureAsyncAction = AsyncAction(
    '_LunchboxeStore.takePicture',
    context: context,
  );

  @override
  Future takePicture(String source) {
    return _$takePictureAsyncAction.run(() => super.takePicture(source));
  }

  late final _$loadOptionsAsyncAction = AsyncAction(
    '_LunchboxeStore.loadOptions',
    context: context,
  );

  @override
  Future<void> loadOptions() {
    return _$loadOptionsAsyncAction.run(() => super.loadOptions());
  }

  late final _$_LunchboxeStoreActionController = ActionController(
    name: '_LunchboxeStore',
    context: context,
  );

  @override
  dynamic clear() {
    final _$actionInfo = _$_LunchboxeStoreActionController.startAction(
      name: '_LunchboxeStore.clear',
    );
    try {
      return super.clear();
    } finally {
      _$_LunchboxeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsLoading(bool value) {
    final _$actionInfo = _$_LunchboxeStoreActionController.startAction(
      name: '_LunchboxeStore.setIsLoading',
    );
    try {
      return super.setIsLoading(value);
    } finally {
      _$_LunchboxeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLunchboxes(List<Lunchboxe> value) {
    final _$actionInfo = _$_LunchboxeStoreActionController.startAction(
      name: '_LunchboxeStore.setLunchboxes',
    );
    try {
      return super.setLunchboxes(value);
    } finally {
      _$_LunchboxeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setStoredImage(dynamic value) {
    final _$actionInfo = _$_LunchboxeStoreActionController.startAction(
      name: '_LunchboxeStore.setStoredImage',
    );
    try {
      return super.setStoredImage(value);
    } finally {
      _$_LunchboxeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setImage(String value) {
    final _$actionInfo = _$_LunchboxeStoreActionController.startAction(
      name: '_LunchboxeStore.setImage',
    );
    try {
      return super.setImage(value);
    } finally {
      _$_LunchboxeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsEditing(bool value) {
    final _$actionInfo = _$_LunchboxeStoreActionController.startAction(
      name: '_LunchboxeStore.setIsEditing',
    );
    try {
      return super.setIsEditing(value);
    } finally {
      _$_LunchboxeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getLunchboxe(Lunchboxe lunchboxe) {
    final _$actionInfo = _$_LunchboxeStoreActionController.startAction(
      name: '_LunchboxeStore.getLunchboxe',
    );
    try {
      return super.getLunchboxe(lunchboxe);
    } finally {
      _$_LunchboxeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
image: ${image},
isEditing: ${isEditing},
isLoading: ${isLoading},
options: ${options},
storedImage: ${storedImage},
lunchboxes: ${lunchboxes},
currentPage: ${currentPage},
totalPages: ${totalPages},
totalElements: ${totalElements}
    ''';
  }
}
