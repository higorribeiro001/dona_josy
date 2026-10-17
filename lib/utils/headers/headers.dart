import 'package:dona_josy/utils/shared/shared.dart';

class Header {
  Future getHeader() async {
    Shared shared = Shared();
    final token = await shared.get('access');

    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }
}
