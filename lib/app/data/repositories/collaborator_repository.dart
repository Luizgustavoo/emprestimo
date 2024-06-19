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

  insertCollaborators(String token, Collaborator collaborator) async {
    try {
      var response = await apiClient.insertCollaborators(token, collaborator);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  updateCollaborators(String token, Collaborator collaborator) async {
    try {
      var response = await apiClient.updateCollaborators(token, collaborator);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  deleteCollaborators(String token, Collaborator collaborator) async {
    try {
      var response = await apiClient.deleteCollaborators(token, collaborator);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
