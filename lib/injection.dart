import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:marsellafrontend/core/bloc/connectivity_cubit.dart';
import 'package:marsellafrontend/core/bloc/session_cubit.dart';
import 'package:marsellafrontend/domain/usecases/local/get_localvalue.dart';
import 'package:marsellafrontend/domain/usecases/login/change_orga.dart';
import 'package:marsellafrontend/domain/usecases/login/get_authenticate.dart';
import 'package:marsellafrontend/domain/usecases/login/get_authenticate_google.dart';
import 'package:marsellafrontend/domain/usecases/login/readif_redirect_login.dart';
import 'package:marsellafrontend/domain/usecases/login/register_user.dart';
import 'package:marsellafrontend/domain/usecases/login/start_redirect_login.dart';
import 'package:marsellafrontend/domain/usecases/orgas/add_orga.dart';
import 'package:marsellafrontend/domain/usecases/sidedrawer/do_logoff.dart';
import 'package:marsellafrontend/domain/usecases/storage/get_cloudfile.dart';
import 'package:marsellafrontend/domain/usecases/storage/register_cloudfile.dart';
import 'package:marsellafrontend/domain/usecases/storage/upload_cloudfile.dart';
import 'package:marsellafrontend/domain/usecases/users/get_users_notin_orga.dart';
import 'package:marsellafrontend/domain/usecases/users/update_user_password.dart';
import 'package:marsellafrontend/presentation/users/bloc/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/bloc/scroll_cubit.dart';
import 'core/bloc/searchpost_cubit.dart';
import 'core/bloc/theme_cubit.dart';
import 'core/bloc/visibility_cubit.dart';
import 'data/datasources/local_data_source.dart';
import 'data/datasources/login_data_source.dart';
import 'data/datasources/setting_data_source.dart';
import 'data/datasources/user_data_source.dart';
import 'data/repositories/local_repository_impl.dart';
import 'data/repositories/login_repository_impl.dart';
import 'data/repositories/setting_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/local_repository.dart';
import 'domain/repositories/login_repository.dart';
import 'domain/repositories/setting_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecases/local/get_has_login.dart';
import 'domain/usecases/local/get_session_role.dart';
import 'domain/usecases/local/get_session_status.dart';
import 'domain/usecases/local/set_localvalue.dart';
import 'domain/usecases/orgas/add_orgauser.dart';
import 'domain/usecases/orgas/delete_orga.dart';
import 'domain/usecases/orgas/delete_orgauser.dart';
import 'domain/usecases/orgas/enable_orga.dart';
import 'domain/usecases/orgas/enable_orgauser.dart';
import 'domain/usecases/orgas/exists_orga.dart';
import 'domain/usecases/orgas/get_orga.dart';
import 'domain/usecases/orgas/get_orgas.dart';
import 'domain/usecases/orgas/get_orgasbyuser.dart';
import 'domain/usecases/orgas/get_orgauser.dart';
import 'domain/usecases/orgas/get_orgausers.dart';
import 'domain/usecases/orgas/update_orga.dart';
import 'domain/usecases/orgas/update_orgauser.dart';
import 'domain/usecases/setting/get_setting_admin.dart';
import 'domain/usecases/setting/get_setting_super.dart';
import 'domain/usecases/setting/updated_setting_admin.dart';
import 'domain/usecases/setting/updated_setting_super.dart';
import 'domain/usecases/sidedrawer/get_side_options.dart';
import 'domain/usecases/storage/register_cloudfile_profile.dart';
import 'domain/usecases/storage/upload_cloudfile_externaluri.dart';
import 'domain/usecases/storage/upload_cloudfile_profile.dart';
import 'domain/usecases/users/add_user.dart';
import 'domain/usecases/users/delete_user.dart';
import 'domain/usecases/users/enable_user.dart';
import 'domain/usecases/users/exists_profile.dart';
import 'domain/usecases/users/exists_user.dart';
import 'domain/usecases/users/get_user.dart';
import 'domain/usecases/users/get_users.dart';
import 'domain/usecases/users/update_profile.dart';
import 'domain/usecases/users/update_profile_password.dart';
import 'domain/usecases/users/update_user.dart';
import 'presentation/nav/bloc/nav_bloc.dart';
import 'presentation/sidedrawer/bloc/sidedrawer_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // bloc
  locator.registerFactory(() => SideDrawerBloc(
      locator(), locator(), locator(), locator(), locator(), locator()));
  locator.registerFactory(() => NavBloc());
  locator.registerFactory(() => UserBloc(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ));
  locator.registerFactory(() => SearchPostLiveCubit());
  locator.registerFactory(() => VisibilityLiveCubit());
  locator.registerFactory(() => ThemeLiveCubit(locator(), locator()));
  locator.registerFactory(
      () => SessionLiveCubit(locator(), locator(), locator(), locator()));

  locator.registerFactory(() => ConnectivityLiveCubit());
  locator.registerFactory(() => ScrollLiveCubit());

  // usecase
  /*locator.registerLazySingleton(() => UpdateUserPassword(locator()));
  locator.registerLazySingleton(() => UpdateProfilePassword(locator()));
  locator.registerLazySingleton(() => GetAuthenticate(locator()));
  locator.registerLazySingleton(() => GetHasLogIn(locator()));
  locator.registerLazySingleton(() => GetSession(locator()));
  locator.registerLazySingleton(() => GetSessionRole(locator()));
  locator.registerLazySingleton(() => GetSideOptions(locator()));
  locator.registerLazySingleton(() => DoLogOff(locator()));
  locator.registerLazySingleton(() => RegisterUser(locator()));
  locator.registerLazySingleton(() => ChangeOrga(locator()));*/

  /*locator.registerLazySingleton(() => AddOrga(locator()));
  locator.registerLazySingleton(() => AddOrgaUser(locator()));
  locator.registerLazySingleton(() => DeleteOrga(locator()));
  locator.registerLazySingleton(() => DeleteOrgaUser(locator()));
  locator.registerLazySingleton(() => EnableOrga(locator()));
  locator.registerLazySingleton(() => EnableOrgaUser(locator()));
  locator.registerLazySingleton(() => GetOrga(locator()));
  locator.registerLazySingleton(() => GetOrgas(locator()));
  locator.registerLazySingleton(() => GetOrgaUsers(locator()));
  locator.registerLazySingleton(() => GetOrgaUser(locator()));
  locator.registerLazySingleton(() => UpdateOrga(locator()));
  locator.registerLazySingleton(() => ExistsOrga(locator()));
  locator.registerLazySingleton(() => UpdateOrgaUser(locator()));
  locator.registerLazySingleton(() => GetOrgasByUser(locator()));*/

  locator.registerLazySingleton(() => AddUser(locator()));
  locator.registerLazySingleton(() => DeleteUser(locator()));
  locator.registerLazySingleton(() => EnableUser(locator()));
  locator.registerLazySingleton(() => GetUser(locator()));
  locator.registerLazySingleton(() => GetUsers(locator()));
  locator.registerLazySingleton(() => UpdateUser(locator()));
  locator.registerLazySingleton(() => ExistsUser(locator()));
  locator.registerLazySingleton(() => UpdateProfile(locator()));
  locator.registerLazySingleton(() => ExistsProfile(locator()));
  locator.registerLazySingleton(() => GetUsersNotInOrga(locator()));
  locator.registerLazySingleton(() => GetAuthenticateGoogle(locator()));

  /*locator.registerLazySingleton(() => GetSettingSuper(locator()));
  locator.registerLazySingleton(() => GetSettingAdmin(locator()));
  locator.registerLazySingleton(() => UpdatedSettingSuper(locator()));
  locator.registerLazySingleton(() => UpdatedSettingAdmin(locator()));*/

  /*locator.registerLazySingleton(() => ReadIfRedirectLogin(locator()));
  locator.registerLazySingleton(() => StartRedirectLogin(locator()));

  locator.registerLazySingleton(() => UploadFile(locator()));
  locator.registerLazySingleton(() => UploadFileProfile(locator()));
  locator.registerLazySingleton(() => GetCloudFile(locator()));
  locator.registerLazySingleton(() => RegisterCloudFile(locator()));
  locator.registerLazySingleton(() => RegisterCloudFileProfile(locator()));
  locator.registerLazySingleton(() => UploadFileExternalUri(locator()));*/

  locator.registerLazySingleton(() => GetLocalValue(locator()));
  locator.registerLazySingleton(() => SetLocalValue(locator()));

  // repository
  locator.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
        userDataSource: locator()),
  );
  locator.registerLazySingleton<LocalRepository>(
    () => LocalRepositoryImpl(localDataSource: locator()),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<SettingRepository>(
    () => SettingRepositoryImpl(remoteDataSource: locator()),
  );

  // data source
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(
      sharedPreferences: locator(),
    ),
  );
  locator.registerLazySingleton<UserRemoteDataSource>(
    () =>
        UserRemoteDataSourceImpl(client: locator(), localDataSource: locator()),
  );

  locator.registerLazySingleton<SettingRemoteDataSource>(() =>
      SettingRemoteDataSourceImpl(
          client: locator(), localDataSource: locator()));

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => sharedPreferences);
  final firebaseAuthInstance = FirebaseAuth.instance;
  locator.registerLazySingleton(() => firebaseAuthInstance);
}
