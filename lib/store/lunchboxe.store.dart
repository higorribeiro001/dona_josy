import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dona_josy/components/ScaffoldMessage.dart';
import 'package:dona_josy/models/lunchboxe.dart';
import 'package:dona_josy/models/page_result.dart';
import 'package:dona_josy/services/api/lunchboxe.dart';
import 'package:dona_josy/store/cart.store.dart';
import 'package:dona_josy/utils/currency_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'lunchboxe.store.g.dart';

class LunchboxeStore = _LunchboxeStore with _$LunchboxeStore;

abstract class _LunchboxeStore with Store {
  Timer? _searchDebounce;
  final TextEditingController name = TextEditingController();
  final TextEditingController searchName = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ScaffoldMessage scf = ScaffoldMessage();
  LunchboxeApi api = LunchboxeApi();
  String? editingProductId;
  bool editingProductIsActive = true;

  @observable
  String? image;

  @observable
  bool isEditing = false;

  @observable
  bool isLoading = false;

  @observable
  List<dynamic> options = [];

  @observable
  File? storedImage;

  @observable
  List<Lunchboxe> lunchboxes = [];

  @observable
  int currentPage = 0;

  @observable
  int totalPages = 0;

  @observable
  int totalElements = 0;

  @action
  clear() {
    name.text = '';
    description.text = '';
    price.text = '';
    setImage('');
    setStoredImage(null);
    editingProductId = null;
    editingProductIsActive = true;
    setIsEditing(false);
  }

  @action
  setIsLoading(bool value) {
    isLoading = value;
  }

  @action
  setLunchboxes(List<Lunchboxe> value) {
    lunchboxes = value;
  }

  void searchLunchboxes(
    BuildContext context,
    String query, {
    bool immediate = false,
  }) {
    _searchDebounce?.cancel();
    if (immediate) {
      getLunchboxes(context, page: 0, query: query.trim());
      return;
    }
    _searchDebounce = Timer(const Duration(seconds: 2), () {
      if (context.mounted) {
        getLunchboxes(context, page: 0, query: query.trim());
      }
    });
  }

  @action
  getLunchboxes(BuildContext context, {int? page, String? query}) async {
    setIsLoading(true);
    try {
      final requestedPage = page ?? currentPage;
      final value = await api.getLunchboxe(
        page: requestedPage,
        name: query ?? searchName.text,
      );
      if (value.statusCode == 200) {
        final decodedJson =
            json.decode(utf8.decode(value.bodyBytes)) as Map<String, dynamic>;
        final result = PageResult<Lunchboxe>.fromJson(
          decodedJson,
          Lunchboxe.fromJson,
        );
        setLunchboxes(result.content);
        currentPage = result.number;
        totalPages = result.totalPages;
        totalElements = result.totalElements;
        clear();
      } else {
        scf.showSnackBar(
          'Erro ao carregar marmitas (${value.statusCode}).',
          Colors.redAccent,
          context,
        );
      }
    } catch (e) {
      scf.showSnackBar('Erro ao carregar marmitas.', Colors.redAccent, context);
    }
    setIsLoading(false);
  }

  @action
  Future<void> setProductActive(
    Lunchboxe lunchboxe,
    BuildContext context,
  ) async {
    final response = await api.setActive(lunchboxe.id, !lunchboxe.isActive);
    if (response.statusCode == 200) {
      await getLunchboxes(context);
    } else {
      scf.showSnackBar(
        'Não foi possível alterar o status da marmita.',
        Colors.redAccent,
        context,
      );
    }
  }

  @action
  Future<bool> addLunchboxe(BuildContext context) async {
    if (!formKey.currentState!.validate()) return false;
    if (!isEditing && storedImage == null) {
      scf.showSnackBar('Selecione uma imagem.', Colors.redAccent, context);
      return false;
    }

    final response = isEditing && editingProductId != null
        ? await api.updateLunchboxe(
            editingProductId!,
            name.text,
            storedImage,
            description.text,
            price.text,
            editingProductIsActive,
          )
        : await api.setLunchboxe(
            name.text,
            storedImage!,
            description.text,
            price.text,
          );
    final success = isEditing
        ? response.statusCode >= 200 && response.statusCode < 300
        : response.statusCode == 201;
    if (!success) {
      scf.showSnackBar(
        'Não foi possível salvar a marmita (${response.statusCode}).',
        Colors.redAccent,
        context,
      );
      return false;
    }

    scf.showSnackBar(
      isEditing ? 'Marmita atualizada.' : 'Marmita cadastrada com sucesso.',
      Colors.green,
      context,
    );
    await getLunchboxes(context, page: 0);
    return true;
  }

  Future<void> addToCart(Lunchboxe lunchboxe, BuildContext context) async {
    await Provider.of<CartStore>(
      context,
      listen: false,
    ).addProductToCart(context, lunchboxe.id);
  }

  @action
  setStoredImage(value) {
    storedImage = value;
  }

  @action
  takePicture(String source) async {
    final ImagePicker picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: source == 'camera' ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 600,
    );

    if (imageFile == null) return;

    setStoredImage(File(imageFile.path));
  }

  @action
  setImage(String value) {
    image = value;
  }

  @action
  setIsEditing(bool value) {
    isEditing = value;
  }

  @action
  Future<void> loadOptions() async {
    String jsonString = await rootBundle.loadString('mocks/lunchboxes.json');
    List<dynamic> jsonList = json.decode(jsonString);
    options = jsonList.map((item) => {'value': item['id'], ...item}).toList();
  }

  @action
  getLunchboxe(Lunchboxe lunchboxe) {
    name.text = lunchboxe.name;
    description.text = lunchboxe.description;
    price.text = formatBrazilianCurrencyValue(lunchboxe.price);
    setImage(lunchboxe.image);
    editingProductId = lunchboxe.id;
    editingProductIsActive = lunchboxe.isActive;
    setIsEditing(true);
  }
}
