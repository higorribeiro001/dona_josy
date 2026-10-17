// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cosmetic.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CosmeticStore on _CosmeticStore, Store {
  late final _$imageAtom = Atom(name: '_CosmeticStore.image', context: context);

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
    name: '_CosmeticStore.isEditing',
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
    name: '_CosmeticStore.isLoading',
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
    name: '_CosmeticStore.options',
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

  late final _$cosmeticsAtom = Atom(
    name: '_CosmeticStore.cosmetics',
    context: context,
  );

  @override
  List<Cosmetic> get cosmetics {
    _$cosmeticsAtom.reportRead();
    return super.cosmetics;
  }

  @override
  set cosmetics(List<Cosmetic> value) {
    _$cosmeticsAtom.reportWrite(value, super.cosmetics, () {
      super.cosmetics = value;
    });
  }

  late final _$currentPageAtom = Atom(
    name: '_CosmeticStore.currentPage',
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
    name: '_CosmeticStore.totalPages',
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
    name: '_CosmeticStore.totalElements',
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

  late final _$storedImageAtom = Atom(
    name: '_CosmeticStore.storedImage',
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

  late final _$getCosmeticsAsyncAction = AsyncAction(
    '_CosmeticStore.getCosmetics',
    context: context,
  );

  @override
  Future getCosmetics(BuildContext context, {int? page, String? query}) {
    return _$getCosmeticsAsyncAction.run(
      () => super.getCosmetics(context, page: page, query: query),
    );
  }

  late final _$setProductActiveAsyncAction = AsyncAction(
    '_CosmeticStore.setProductActive',
    context: context,
  );

  @override
  Future<void> setProductActive(Cosmetic cosmetic, BuildContext context) {
    return _$setProductActiveAsyncAction.run(
      () => super.setProductActive(cosmetic, context),
    );
  }

  late final _$takePictureAsyncAction = AsyncAction(
    '_CosmeticStore.takePicture',
    context: context,
  );

  @override
  Future takePicture(String source) {
    return _$takePictureAsyncAction.run(() => super.takePicture(source));
  }

  late final _$loadOptionsAsyncAction = AsyncAction(
    '_CosmeticStore.loadOptions',
    context: context,
  );

  @override
  Future<void> loadOptions() {
    return _$loadOptionsAsyncAction.run(() => super.loadOptions());
  }

  late final _$addCosmeticAsyncAction = AsyncAction(
    '_CosmeticStore.addCosmetic',
    context: context,
  );

  @override
  Future<bool> addCosmetic(BuildContext context) {
    return _$addCosmeticAsyncAction.run(() => super.addCosmetic(context));
  }

  late final _$_CosmeticStoreActionController = ActionController(
    name: '_CosmeticStore',
    context: context,
  );

  @override
  dynamic clear() {
    final _$actionInfo = _$_CosmeticStoreActionController.startAction(
      name: '_CosmeticStore.clear',
    );
    try {
      return super.clear();
    } finally {
      _$_CosmeticStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsLoading(bool value) {
    final _$actionInfo = _$_CosmeticStoreActionController.startAction(
      name: '_CosmeticStore.setIsLoading',
    );
    try {
      return super.setIsLoading(value);
    } finally {
      _$_CosmeticStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCosmetics(List<Cosmetic> value) {
    final _$actionInfo = _$_CosmeticStoreActionController.startAction(
      name: '_CosmeticStore.setCosmetics',
    );
    try {
      return super.setCosmetics(value);
    } finally {
      _$_CosmeticStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setStoredImage(dynamic value) {
    final _$actionInfo = _$_CosmeticStoreActionController.startAction(
      name: '_CosmeticStore.setStoredImage',
    );
    try {
      return super.setStoredImage(value);
    } finally {
      _$_CosmeticStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setImage(String value) {
    final _$actionInfo = _$_CosmeticStoreActionController.startAction(
      name: '_CosmeticStore.setImage',
    );
    try {
      return super.setImage(value);
    } finally {
      _$_CosmeticStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsEditing(bool value) {
    final _$actionInfo = _$_CosmeticStoreActionController.startAction(
      name: '_CosmeticStore.setIsEditing',
    );
    try {
      return super.setIsEditing(value);
    } finally {
      _$_CosmeticStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getCosmetic(Cosmetic cosmetic) {
    final _$actionInfo = _$_CosmeticStoreActionController.startAction(
      name: '_CosmeticStore.getCosmetic',
    );
    try {
      return super.getCosmetic(cosmetic);
    } finally {
      _$_CosmeticStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
image: ${image},
isEditing: ${isEditing},
isLoading: ${isLoading},
options: ${options},
cosmetics: ${cosmetics},
currentPage: ${currentPage},
totalPages: ${totalPages},
totalElements: ${totalElements},
storedImage: ${storedImage}
    ''';
  }
}
