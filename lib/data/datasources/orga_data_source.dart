import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/constants.dart';
import '../../../core/exceptions.dart';
import '../models/orga_model.dart';
import '../models/orgauser_model.dart';
import '../models/role_model.dart';
import 'local_data_source.dart';

//Interfaz del DataSource de organizaciones (remoto) hacia el backend
abstract class OrgaRemoteDataSource {
  Future<List<OrgaModel>> getOrgas(
      String filter, String fieldOrder, double pageNumber, int pageSize);
  Future<OrgaModel> getOrga(String orgaId);

  Future<List<OrgaUserModel>> getOrgaUsers(String orgaId);

  Future<List<OrgaUserModel>> getOrgaUser(String orgaId, String userId);

  Future<OrgaModel> addOrga(OrgaModel orga);

  Future<OrgaUserModel> addOrgaUser(OrgaUserModel orgaUser);

  Future<bool> deleteOrga(String orgaId);

  Future<bool> deleteOrgaUser(String orgaId, String userId);

  Future<bool> enableOrga(String orgaId, bool enableOrDisable);

  Future<bool> enableOrgaUser(
      String orgaId, String userId, bool enableOrDisable);

  Future<OrgaModel> updateOrga(String orgaId, OrgaModel orga);

  Future<OrgaModel?> existsOrga(String orgaId, String code);

  Future<OrgaUserModel> updateOrgaUser(
      String orgaId, String userId, OrgaUserModel orgaUser);

  Future<List<OrgaModel>> getOrgasByUser(String orgaId);
}

///Implementación de [OrgaRemoteDataSource] con todos sus métodos.
class OrgaRemoteDataSourceImpl implements OrgaRemoteDataSource {
  final http.Client client;
  final LocalDataSource localDataSource;
  OrgaRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  ///Entrega una lista de organizaciones según los filtros
  ///
  ///[filter] es de tipo texto y si no hay filtro debe venir vacío.
  ///[fieldOrder] es el nombre del campo por el cual filtrar ascendentemente
  ///[pageNumber] es el número de página de la lista de organizaciones
  ///[pageSize] es el tamaño de cada página. Sólo se traerá una página.
  @override
  Future<List<OrgaModel>> getOrgas(
      String filter, String fieldOrder, double pageNumber, int pageSize) async {
    //parsea URL
    final url = Uri.parse('${UrlBackend.base}/api/v1/orga/');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: TimeOutConnection.timeOut), onTimeout: () {
      throw ConnectionException();
    });

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      List<OrgaModel> orgas = [];

      for (var item in resObj['data']['items']) {
        orgas.add(OrgaModel(
            id: item["id"].toString(),
            name: item["name"].toString(),
            code: item["code"].toString(),
            enabled: item["enabled"].toString().toLowerCase() == 'true',
            builtIn: item["builtIn"].toString().toLowerCase() == 'true'));
      }

      return Future.value(orgas);
    } else {
      throw ServerException(statusCode: resp.statusCode);
    }
  }

  ///Entrega una organización a partir del Id de la organización
  @override
  Future<OrgaModel> getOrga(String orgaId) async {
    final url = Uri.parse('${UrlBackend.base}/api/v1/orga/$orgaId');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: TimeOutConnection.timeOut), onTimeout: () {
      throw ConnectionException();
    });

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      final item = resObj['data']['items'][0];
      return Future.value(OrgaModel(
          id: item["id"].toString(),
          name: item["name"].toString(),
          code: item["code"].toString(),
          enabled: item["enabled"].toString().toLowerCase() == 'true',
          builtIn: item["builtIn"].toString().toLowerCase() == 'true'));
    } else {
      throw ServerException(statusCode: resp.statusCode);
    }
  }

  @override
  Future<OrgaModel?> existsOrga(String orgaId, String code) async {
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/orga/if/exists/?orgaId=${orgaId.toString()}&code=${code.toString()}');
    final session = await localDataSource.getSavedSession();
    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: TimeOutConnection.timeOut), onTimeout: () {
      throw ConnectionException();
    });
    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);
      if (resObj['data']['currentItemCount'] > 0) {
        final item = resObj['data']['items'][0];
        return Future.value(OrgaModel(
            id: item["id"].toString(),
            name: item["name"].toString(),
            code: item["code"].toString(),
            enabled: item["enabled"].toString().toLowerCase() == 'true',
            builtIn: item["builtIn"].toString().toLowerCase() == 'true'));
      }
      return Future.value(null);
    } else {
      throw ServerException(statusCode: resp.statusCode);
    }
  }

  ///Entrega una lista de OrgaUsers a partir del Id de la organización
  @override
  Future<List<OrgaUserModel>> getOrgaUsers(String orgaId) async {
    //parsea URL
    final url = Uri.parse('${UrlBackend.base}/api/v1/orgauser/byorga/$orgaId');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: TimeOutConnection.timeOut), onTimeout: () {
      throw ConnectionException();
    });

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      List<OrgaUserModel> orgaUsers = [];

      for (var item in resObj['data']['items']) {
        List<String> roleslist = [];
        for (var r in item['roles']) {
          roleslist.add(r['name']);
        }
        orgaUsers.add(OrgaUserModel(
            userId: item["userId"].toString(),
            orgaId: item["orgaId"].toString(),
            roles: roleslist,
            enabled: item["enabled"].toString().toLowerCase() == 'true',
            builtIn: item["builtIn"].toString().toLowerCase() == 'true'));
      }

      return Future.value(orgaUsers);
    } else {
      throw ServerException(statusCode: resp.statusCode);
    }
  }

  ///Entrega una organización a partir del Id de la organización
  @override
  Future<List<OrgaUserModel>> getOrgaUser(String orgaId, String userId) async {
    final url = Uri.parse('${UrlBackend.base}/api/v1/orgauser/$orgaId/$userId');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: TimeOutConnection.timeOut), onTimeout: () {
      throw ConnectionException();
    });

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      //final item = resObj['data']['items'][0];

      List<OrgaUserModel> orgaUsers = [];

      for (var item in resObj['data']['items']) {
        List<String> roleslist = [];
        for (var r in item['roles']) {
          roleslist.add(r['name']);
        }
        orgaUsers.add(OrgaUserModel(
            userId: item["userId"].toString(),
            orgaId: item["orgaId"].toString(),
            roles: roleslist,
            enabled: item["enabled"].toString().toLowerCase() == 'true',
            builtIn: item["builtIn"].toString().toLowerCase() == 'true'));
      }

      return Future.value(orgaUsers);
    } else {
      throw ServerException(statusCode: resp.statusCode);
    }
  }

  ///Agrega un Orga recibiendo un OrgaModel

  ///Agrega una relación OrgaUser a partir de un OrgaUserModel
  @override
  Future<OrgaUserModel> addOrgaUser(OrgaUserModel orgaUser) async {
    final url = Uri.parse('${UrlBackend.base}/api/v1/orgauser');

    final session = await localDataSource.getSavedSession();

    List<RoleModel> listInRoles = [];
    for (var element in orgaUser.roles) {
      listInRoles.add(RoleModel(name: element, enabled: true));
    }
    final Map<String, dynamic> orgaUserBackend = {
      'orgaId': orgaUser.orgaId,
      'userId': orgaUser.userId,
      'roles': listInRoles,
      'enabled': orgaUser.enabled,
      'builtIn': orgaUser.builtIn,
    };

    http.Response resp =
        await client.post(url, body: json.encode(orgaUserBackend), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}"
    }).timeout(const Duration(seconds: TimeOutConnection.timeOut), onTimeout: () {
      throw ConnectionException();
    });

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      final item = resObj['data']['items'][0];

      List<String> roleslist = [];
      for (var r in item['roles']) {
        roleslist.add(r['name']);
      }

      return Future.value(OrgaUserModel(
          userId: item["userId"].toString(),
          orgaId: item["orgaId"].toString(),
          roles: roleslist,
          enabled: item["enabled"].toString().toLowerCase() == 'true',
          builtIn: item["builtIn"].toString().toLowerCase() == 'true'));
    } else {
      throw ServerException(statusCode: resp.statusCode);
    }
  }

  ///Elimina una organización a partir del Id de organización
  @override
  Future<bool> deleteOrga(String orgaId) async {
    final url = Uri.parse('${UrlBackend.base}/api/v1/orga/$orgaId');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.delete(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: TimeOutConnection.timeOut), onTimeout: () {
      throw ConnectionException();
    });

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      return Future.value(
          resObj['data']['items'][0].toString().toLowerCase() == 'true');
    } else {
      throw ServerException(statusCode: resp.statusCode);
    }
  }

  ///Elimina una relación OrgaUser a partir de los Id [orgaId] y [userId]
  @override
  Future<bool> deleteOrgaUser(String orgaId, String userId) async {
    final url = Uri.parse('${UrlBackend.base}/api/v1/orgauser/$orgaId/$userId');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.delete(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: TimeOutConnection.timeOut), onTimeout: () {
      throw ConnectionException();
    });

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      return Future.value(
          resObj['data']['items'][0].toString().toLowerCase() == 'true');
    } else {
      throw ServerException(statusCode: resp.statusCode);
    }
  }

  ///Habilita o deshabilita una organización a partir del Id de organización
  ///
  ///En el parámetro [enableOrDisable] se especifica el nuevo valor de
  ///habilitación
  @override
  Future<bool> enableOrga(String orgaId, bool enableOrDisable) async {
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/orga/enable/$orgaId?enable=${enableOrDisable.toString()}');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.put(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: TimeOutConnection.timeOut), onTimeout: () {
      throw ConnectionException();
    });

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      return Future.value(
          resObj['data']['items'][0].toString().toLowerCase() == 'true');
    } else {
      throw ServerException(statusCode: resp.statusCode);
    }
  }

  ///Habilita o deshabilita un OrgaUser a partir del Id de organización y userId
  ///
  ///En el parámetro [enableOrDisable] se especifica el nuevo valor de
  ///habilitación
  @override
  Future<bool> enableOrgaUser(
      String orgaId, String userId, bool enableOrDisable) async {
    final url = Uri.parse(
        '${UrlBackend.base}/api/v1/orgauser/enable/$orgaId/$userId?enable=${enableOrDisable.toString()}');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.put(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: TimeOutConnection.timeOut), onTimeout: () {
      throw ConnectionException();
    });

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      return Future.value(
          resObj['data']['items'][0].toString().toLowerCase() == 'true');
    } else {
      throw ServerException(statusCode: resp.statusCode);
    }
  }

  ///Actualiza una organización con el Id de organización y un OrgaModel
  @override
  Future<OrgaModel> updateOrga(String orgaId, OrgaModel orga) async {
    final session = await localDataSource.getSavedSession();
    final url = Uri.parse('${UrlBackend.base}/api/v1/orga/$orgaId');

    //busca respuesta desde el servidor para la autenticación
    http.Response resp =
        await client.put(url, body: json.encode(orga), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: TimeOutConnection.timeOut), onTimeout: () {
      throw ConnectionException();
    });

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);
      final item = resObj['data']['items'][0];
      return Future.value(OrgaModel(
          id: item["id"].toString(),
          name: item["name"].toString(),
          code: item["code"].toString(),
          enabled: item["enabled"].toString().toLowerCase() == 'true',
          builtIn: item["builtIn"].toString().toLowerCase() == 'true'));
    } else {
      throw ServerException(statusCode: resp.statusCode);
    }
  }

  ///Actualiza un OrgaUser con Id organización, userio y un OrgaUserModel
  @override
  Future<OrgaUserModel> updateOrgaUser(
      String orgaId, String userId, OrgaUserModel orgaUser) async {
    final url = Uri.parse('${UrlBackend.base}/api/v1/orgauser/$orgaId/$userId');

    final session = await localDataSource.getSavedSession();

    List<RoleModel> listInRoles = [];
    for (var element in orgaUser.roles) {
      listInRoles.add(RoleModel(name: element, enabled: true));
    }

    final Map<String, dynamic> orgaUserBackend = {
      'orgaId': orgaId,
      'userId': userId,
      'roles': listInRoles,
      'enabled': orgaUser.enabled,
    };

    http.Response resp =
        await client.put(url, body: json.encode(orgaUserBackend), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: TimeOutConnection.timeOut), onTimeout: () {
      throw ConnectionException();
    });

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      final item = resObj['data']['items'][0];

      List<String> roleslist = [];
      for (var r in item['roles']) {
        roleslist.add(r['name']);
      }

      return Future.value(OrgaUserModel(
          userId: item["userId"].toString(),
          orgaId: item["orgaId"].toString(),
          roles: roleslist,
          enabled: item["enabled"].toString().toLowerCase() == 'true',
          builtIn: item["builtIn"].toString().toLowerCase() == 'true'));
    } else {
      throw ServerException(statusCode: resp.statusCode);
    }
  }

  @override
  Future<List<OrgaModel>> getOrgasByUser(String userId) async {
    //parsea URL
    final url = Uri.parse('${UrlBackend.base}/api/v1/orga/byuser/$userId');
    final session = await localDataSource.getSavedSession();

    http.Response resp = await client.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: TimeOutConnection.timeOut), onTimeout: () {
      throw ConnectionException();
    });

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      List<OrgaModel> orgas = [];

      for (var item in resObj['data']['items']) {
        orgas.add(OrgaModel(
            id: item["id"].toString(),
            name: item["name"].toString(),
            code: item["code"].toString(),
            enabled: item["enabled"].toString().toLowerCase() == 'true',
            builtIn: item["builtIn"].toString().toLowerCase() == 'true'));
      }

      return Future.value(orgas);
    } else {
      throw ServerException(statusCode: resp.statusCode);
    }
  }

  @override
  Future<OrgaModel> addOrga(OrgaModel orga) async {
    final session = await localDataSource.getSavedSession();
    final url = Uri.parse('${UrlBackend.base}/api/v1/orga');

    //busca respuesta desde el servidor para la autenticación
    http.Response resp =
        await client.post(url, body: json.encode(orga), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${session.token}",
    }).timeout(const Duration(seconds: TimeOutConnection.timeOut), onTimeout: () {
      throw ConnectionException();
    });

    if (resp.statusCode == 200) {
      final Map<dynamic, dynamic> resObj = json.decode(resp.body);

      final item = resObj['data']['items'][0];
      return Future.value(OrgaModel(
          id: item["id"].toString(),
          name: item["name"].toString(),
          code: item["code"].toString(),
          enabled: item["enabled"].toString().toLowerCase() == 'true',
          builtIn: item["builtIn"].toString().toLowerCase() == 'true'));
    } else {
      throw ServerException(statusCode: resp.statusCode);
    }
  }
}
