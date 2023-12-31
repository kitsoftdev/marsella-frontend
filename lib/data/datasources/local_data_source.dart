import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions.dart';
import '../models/session_model.dart';

///En estas clases de define la interfaz y se implementa la clase que se
///comunica con el Storage local del sistema, ya sea Android, iOS o Web.
///De este modo guardamos en el "local" la información de sesión, para saber
///quién es el usuario, contar con el token y los roles que tiene dentro de
///la aplicación.

///Clase de interfaz que define la estructura que tendrá el LocalDataSource
abstract class LocalDataSource {
  Future<SessionModel> getSavedSession();
  Future<bool> saveSession(SessionModel session);
  Future<bool> hasSession();
  Future<bool> cleanSession();
  Future<bool> saveStartRedirectLogin();
  Future<bool> getIfRedirectLogin();
  Future<bool> cleanRedirectLogin();
  Future<String> getLocalValue(String key);
  Future<bool> setLocalValue(String key, String value);
}

///Define el nombre que tiene la variable para almacenar la Sesión.
const cachedSessionKey = "SESSION_KEY";

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  ///Implementa el método que entrega el [SessionModel] desde el localStorage
  ///
  ///Lanza una [CacheException] si no fue posible leer el localStorage con
  ///esa clave [cachedSessionKey]
  @override
  Future<SessionModel> getSavedSession() {
    final jsonString = sharedPreferences.getString(cachedSessionKey);
    if (jsonString != null && jsonString != "") {
      return Future.value(SessionModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  ///Limpia el valor de la sesión guardada en la clave [cachedSessionKey] del
  ///localStorage
  @override
  Future<bool> cleanSession() {
    sharedPreferences.setString(
      cachedSessionKey,
      "",
    );

    return Future.value(true);
  }

  ///Persiste el valor de la sesión en [session] hacia el localStorage
  @override
  Future<bool> saveSession(SessionModel session) {
    sharedPreferences.setString(
      cachedSessionKey,
      json.encode(session.toJson()),
    );

    return Future.value(true);
  }

  ///Verdadero si existe un valor en la clave [cachedSessionKey] de localStorage
  @override
  Future<bool> hasSession() {
    return Future.value(sharedPreferences.containsKey(cachedSessionKey));
  }

  @override
  Future<bool> cleanRedirectLogin() {
    sharedPreferences.setString(
      "redirect",
      "",
    );

    return Future.value(true);
  }

  @override
  Future<bool> getIfRedirectLogin() {
    final value = sharedPreferences.getString("redirect");
    if (value != null && value != "" && value == "yes") {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<bool> saveStartRedirectLogin() {
    sharedPreferences.setString(
      "redirect",
      "yes",
    );
    return Future.value(true);
  }

  @override
  Future<String> getLocalValue(String key) {
    final value = sharedPreferences.getString(key);
    if (value != null && value != "") {
      return Future.value(value);
    } else {
      return Future.value("");
    }
  }

  @override
  Future<bool> setLocalValue(String key, String value) {
    sharedPreferences.setString(
      key,
      value,
    );

    return Future.value(true);
  }
}
