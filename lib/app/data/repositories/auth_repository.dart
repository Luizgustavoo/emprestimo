import 'package:emprestimo/app/data/models/auth_model.dart';
import 'package:emprestimo/app/data/providers/auth_provider.dart';

class AuthRepository {
  final AuthApiClient apiClient = AuthApiClient();

  getLogin(String email, String password) async {
    Map<String, dynamic>? json = await apiClient.getLogin(email, password);

    if (json != null) {
      return Auth.fromJson(json);
    } else {
      return null;
    }
  }
}
