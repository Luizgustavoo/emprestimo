import 'package:emprestimo/app/data/models/collaborator_model.dart';
import 'package:emprestimo/app/data/providers/collaborator_provider.dart';

class CollaboratorRepository {
  final CollaboratorApiClient apiClient = CollaboratorApiClient();
  getAll(String token) async {
    List<Collaborator> list = <Collaborator>[];

    var response = await apiClient.getAllCollaborators(token);

    if (response != null) {
      response['data'].forEach((e) {
        list.add(Collaborator.fromJson(e));
      });
    }

    return list;
  }
}
