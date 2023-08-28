import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marsellafrontend/core/validators.dart';
import 'package:marsellafrontend/core/widgets/marsella_selectors.dart';
import 'package:marsellafrontend/presentation/users/bloc/user_event.dart';

import '../../../core/bloc/searchpost_cubit.dart';
import '../../../core/bloc/searchuser_cubit.dart';
import '../../../core/bloc/session_cubit.dart';
import '../../../core/bloc/visibility_cubit.dart';
import '../../../core/themes/marsella_colors.dart';
import '../../../core/themes/marsella_screen.dart';
import '../../../core/themes/marsella_text_styles.dart';
import '../../../core/themes/marsella_themedata.dart';
import '../../../core/widgets/marsella_buttons.dart';
import '../../../core/widgets/marsella_inputs.dart';
import '../../../core/widgets/marsella_post_widgets.dart';
import '../../../core/widgets/marsella_texts.dart';
import '../../../core/widgets/marsella_widgets.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../../../injection.dart' as di;
import '../bloc/user_bloc.dart';
import '../bloc/user_cubit.dart';
import '../bloc/user_state.dart';

class UsersPage extends StatelessWidget {
  UsersPage({Key? key}) : super(key: key);

  //Ordenamiento
  final Map<String, String> listFields = <String, String>{
    "Email": "email",
    "Nombre": "name",
    "Usuario": "username"
  };

  final TextEditingController _searchController = TextEditingController();
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final int _fixPageSize = 10;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoaded && state.message != "") {
          snackBarNotify(context, state.message, Icons.account_circle);
        } else if (state is UserStart && state.message != "") {
          snackBarNotify(context, state.message, Icons.account_circle);
        } else if (state is UserError && state.message != "") {
          snackBarNotify(context, state.message, Icons.cancel_outlined);
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return _bodyDesign(context);
        },
      ),
    );
  }

  Widget _bodyDesign(BuildContext context) {
    int num = 3;
    int numPage = 1;
    int totalPage = 1;
    List<String> optionsDropdown = [
      'Default',
      'System',
      'Giorgio Armani',
      'Codelco'
    ];
    String? selectedOption = 'Default';
    bool userNotInOrga = false;
    final TextEditingController _searchUserController = TextEditingController();
    final int _fixPageSize = 10;
    final shThemeData = MarsellaTheme.of(context);

    //Ordenamiento
    final Map<String, String> listFields = <String, String>{
      "Email": "email",
      "Nombre": "name",
      "Usuario": "username"
    };
    if (context.read<SearchPostLiveCubit>().state.orderFields.isEmpty) {
      context.read<SearchPostLiveCubit>().setOrderFields(
          <String, String>{listFields.keys.first: listFields.values.first});
    }
    //_searchUserController.text = context.read<SearchUserLiveCubit>().state.searchText;
    return BlocProvider<UserLiveCubit>(
      create: (context) => UserLiveCubit(
        di.locator(),
      ),
      child: BlocProvider<SearchUserLiveCubit>(
        create: (context) => SearchUserLiveCubit(),
        child: Container(
          padding: MarsellaScreen.screenIsNormalSize(context)
              ? const EdgeInsets.only(left: 15.0, right: 15.0)
              : const EdgeInsets.only(left: 15.0, right: 15.0, top: 31.0),
          child: Column(
            children: [
              BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                return (state is UserListLoaded)
                    ? MarsellaPageTitle(text: 'Usuarios (${state.users.length})')
                    : (state is UserLoaded)
                        ? const MarsellaPageTitle(text: 'Usuario')
                        : (state is UserUpdatePassword)
                            ? const MarsellaPageTitle(
                                text: 'Actualizar contraseña')
                            : (state is UserAdding)
                                ? const MarsellaPageTitle(text: 'Nuevo usuario')
                                : (state is UserEditing)
                                    ? const MarsellaPageTitle(
                                        text: 'Editar usuario')
                                    : (state is UserListNotInOrgaLoaded)
                                        ? MarsellaPageTitle(
                                            text:
                                                'Usuarios no asociados a la organización (${state.users.length})')
                                        : const MarsellaPageTitle(
                                            text: 'Usuarios');
              }),
              BlocBuilder<VisibilityLiveCubit, VisibilityLiveState>(
                builder: (context, statecubitvisibility) {
                  _searchUserController.text = context.read<SearchUserLiveCubit>().state.searchText;
                  List<Widget> childrens = [];
                  childrens.add(const SizedBox(
                    height: 20,
                  ));
                  childrens.add(MarsellaContainerSimple(
                      child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 8,
                          children: [
                            BlocBuilder<SearchPostLiveCubit,
                                SearchPostLiveState>(
                              builder: (context, statecubitsearch) {
                                return MarsellaSideMenuDropdown(
                                  value: statecubitsearch.orderFields.values
                                      .first, //state.fieldsOrder.keys.first,
                                  items: listFields.entries
                                      .map<DropdownMenuItem<String>>((field) {
                                    return DropdownMenuItem<String>(
                                      value: field.value,
                                      child: Text(field.key),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      context.read<UserBloc>().add(
                                          OnUserListLoad(
                                              context
                                                  .read<SessionLiveCubit>()
                                                  .getOrgaId, //state.orgaId,
                                              statecubitsearch
                                                  .searchText, //state.searchText,
                                              <String, int>{value: 1},
                                              statecubitsearch
                                                  .pageIndex, //state.pageIndex,
                                              _fixPageSize));
                                      for (var element in listFields.entries) {
                                        if (element.value == value) {
                                          context
                                              .read<SearchPostLiveCubit>()
                                              .setOrderFields(
                                                  {element.key: element.value});
                                          break;
                                        }
                                      }
                                    }
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              width: 175,
                              child: MarsellaIconTextButton(
                                text: 'Asociar usuario',
                                active: false,
                                icon: Icons.group_add,
                                onPressed: () {
                                  context.read<UserBloc>().add(
                                      OnUserListNotInOrga(
                                          context
                                              .read<SessionLiveCubit>()
                                              .getOrgaId, //state.orgaId,
                                          _searchController.text,
                                          <String, int>{
                                            listFields.values.first: 1
                                          },
                                          1,
                                          _fixPageSize));
                                  userNotInOrga = true;
                                  //context.read<VisibilityLiveCubit>().hideVisibility();
                                },
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: MarsellaIconTextButton(
                                text: 'Agregar usuario',
                                active: false,
                                icon: Icons.person_add,
                                onPressed: () {
                                  context
                                      .read<UserBloc>()
                                      .add(const OnUserPrepareForAdd());
                                  context
                                      .read<VisibilityLiveCubit>()
                                      .hideVisibility();
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                  height: 40,
                                  width: 290,
                                  child: BlocBuilder<SearchUserLiveCubit,
                                      SearchUserLiveState>(
                                    builder: (context, statecubituser) {
                                      _searchUserController.text =
                                          statecubituser.searchText;
                                      return MarsellaAdminInputSearch(
                                        hintText: 'Buscar usuarios',
                                        //text: '',
                                        searchController: _searchUserController,
                                        onSubmitted: (p0) {
                                          if (_searchUserController
                                              .text.isNotEmpty) {
                                            userNotInOrga
                                            ?context.read<UserBloc>().add(
                                              OnUserListLoad(
                                                context.read<SessionLiveCubit>()
                                                  .getOrgaId,
                                                _searchUserController.text,
                                                <String, int>{
                                                  listFields.values.first: 1
                                                },
                                                1,
                                                _fixPageSize))
                                            :context.read<UserBloc>().add(
                                              OnUserListNotInOrga(
                                                context.read<SessionLiveCubit>()
                                                  .getOrgaId,
                                                _searchUserController.text,
                                                <String, int>{
                                                  listFields.values.first: 1
                                                },
                                                1,
                                                _fixPageSize));
                                            /*context.read<UserBloc>().add(
                                              (!userNotInOrga)
                                              ? OnUserListLoad(
                                                  context
                                                      .read<
                                                          SessionLiveCubit>()
                                                      .getOrgaId,
                                                  _searchUserController
                                                      .text,
                                                  <String, int>{
                                                    listFields
                                                        .values.first: 1
                                                  },
                                                  1,
                                                  _fixPageSize)
                                              : OnUserListNotInOrga(
                                                  _searchUserController
                                                      .text,
                                                  context
                                                      .read<
                                                          SessionLiveCubit>()
                                                      .getOrgaId,
                                                  <String, int>{
                                                    listFields
                                                        .values.first: 1
                                                  },
                                                  1,
                                                  _fixPageSize));*/
                                            context
                                                .read<SearchUserLiveCubit>()
                                                .changeSearchText(
                                                    _searchUserController.text);
                                            Navigator.of(context).popUntil(
                                                (route) => route.isFirst);
                                          } else if (_searchController
                                              .text.isEmpty) {
                                            context.read<UserBloc>().add(
                                                !userNotInOrga
                                                    ? OnUserListLoad(
                                                        context
                                                            .read<
                                                                SessionLiveCubit>()
                                                            .getOrgaId,
                                                        "",
                                                        <String, int>{
                                                          listFields
                                                              .values.first: 1
                                                        },
                                                        //context.read<SearchUserLiveCubit>().state.orderFields,//state.fieldsOrder,
                                                        1,
                                                        _fixPageSize)
                                                    : OnUserListNotInOrga(
                                                        "",
                                                        context
                                                            .read<
                                                                SessionLiveCubit>()
                                                            .getOrgaId,
                                                        <String, int>{
                                                          listFields
                                                              .values.first: 1
                                                        },
                                                        1,
                                                        _fixPageSize));
                                            context
                                                .read<SearchUserLiveCubit>()
                                                .changeSearchText('');

                                            Navigator.of(context).popUntil(
                                                (route) => route.isFirst);
                                          }
                                          return null;
                                        },
                                        onPressedIcon: () {
                                          if (_searchUserController
                                                  .text.isNotEmpty &&
                                              _searchUserController.text ==
                                                  context
                                                      .read<
                                                          SearchUserLiveCubit>()
                                                      .state
                                                      .searchText) {
                                            context.read<UserBloc>().add(
                                                !userNotInOrga
                                                    ? OnUserListLoad(
                                                        context
                                                            .read<
                                                                SessionLiveCubit>()
                                                            .getOrgaId,
                                                        '',
                                                        <String, int>{
                                                          listFields
                                                              .values.first: 1
                                                        },
                                                        1,
                                                        _fixPageSize)
                                                    : OnUserListNotInOrga(
                                                        '',
                                                        context
                                                            .read<
                                                                SessionLiveCubit>()
                                                            .getOrgaId,
                                                        <String, int>{
                                                          listFields
                                                              .values.first: 1
                                                        },
                                                        1,
                                                        _fixPageSize));
                                            _searchUserController.text = '';
                                            context
                                                .read<SearchUserLiveCubit>()
                                                .changeSearchText('');
                                            Navigator.of(context).popUntil(
                                                (route) => route.isFirst);
                                          } else if (context
                                                  .read<SearchUserLiveCubit>()
                                                  .state
                                                  .searchText
                                                  .isEmpty &&
                                              _searchUserController
                                                  .text.isNotEmpty) {
                                            context.read<UserBloc>().add(
                                                !userNotInOrga
                                                    ? OnUserListLoad(
                                                        context
                                                            .read<
                                                                SessionLiveCubit>()
                                                            .getOrgaId,
                                                        _searchUserController
                                                            .text,
                                                        <String,
                                                            int>{
                                                          listFields
                                                              .values.first: 1
                                                        },
                                                        1,
                                                        _fixPageSize)
                                                    : OnUserListNotInOrga(
                                                        _searchUserController
                                                            .text,
                                                        context
                                                            .read<
                                                                SessionLiveCubit>()
                                                            .getOrgaId,
                                                        <String, int>{
                                                          listFields
                                                              .values.first: 1
                                                        },
                                                        1,
                                                        _fixPageSize));
                                            context
                                                .read<SearchUserLiveCubit>()
                                                .changeSearchText(
                                                    _searchUserController.text);
                                            Navigator.of(context).popUntil(
                                                (route) => route.isFirst);
                                          }
                                        },
                                      );
                                    },
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )));
                  childrens.add(const SizedBox(
                    height: 7,
                  ));
                  childrens.add(
                    MarsellaContainerSimple(
                        //Paginado
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_rounded),
                            color: MarsellaColors.marsellaBlack20,
                            iconSize: 17,
                            splashRadius: 20,
                            padding: const EdgeInsets.all(0),
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Página $numPage de $totalPage',
                          style: MarsellaTextStyles.textPageTitle(
                              shThemeData.textData.formFieldTopLabelColor),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios_rounded),
                            color: MarsellaColors.marsellaBlack20,
                            iconSize: 17,
                            splashRadius: 20,
                            padding: const EdgeInsets.all(0),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    )),
                  );
                  return context.read<VisibilityLiveCubit>().state.visibility
                      ? Column(
                          children: childrens,
                        )
                      : const SizedBox();
                },
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserStart) {
                    context.read<UserBloc>().add(OnUserListLoad("", "",
                        <String, int>{listFields.values.first: 1}, 1, 10));
                  }
                  if (state is UserLoading) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: const Center(
                        child: MarsellaCircularIndicator(
                          size: MarsellaCircularSize.normal,
                        ),
                      ),
                    );
                  }
                  if (state is UserError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is UserListLoaded) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                MarsellaContainerSimple(
                                  //Usuarios
                                  child:
                                      BlocBuilder<UserLiveCubit, UserLiveState>(
                                    builder: (context, statecubit) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    right: 16.0, bottom: 13.0),
                                                child: MarsellaPostAvatar(
                                                  imageURL: state.users[index]
                                                      .pictureThumbnailUrl,
                                                ),
                                              ),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    bottom: 17,
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      context
                                                          .read<UserBloc>()
                                                          .add(OnUserLoad(state
                                                              .users[index]
                                                              .id));
                                                      context
                                                          .read<
                                                              VisibilityLiveCubit>()
                                                          .hideVisibility();
                                                    },
                                                    child: Text(
                                                        state.users[index].name,
                                                        style: MarsellaTextStyles
                                                            .textButtonLabel(
                                                                shThemeData
                                                                    .postData
                                                                    .titleTextColor)),
                                                  )),
                                              const Spacer(),
                                              ShamiaInputToggleOption(
                                                text: '',
                                                active:
                                                    MarsellaEnabled.isEnabled(
                                                        state.users[index].id,
                                                        state.users[index]
                                                            .enabled,
                                                        statecubit.checksList),
                                                onChanged: (value) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          GestureDetector(
                                                            onTap: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child:
                                                                MarsellaAlertDialog(
                                                              title:
                                                                  '¿Desea ${(!value ? "deshabilitar" : "habilitar")} el usuario?',
                                                              content:
                                                                  'Esta acción afecta el acceso del usuario al sistema',
                                                              buttons: [
                                                                MarsellaOnlyTextButton(
                                                                  key: const ValueKey(
                                                                      "btnConfirmEnable"),
                                                                  text: (!value
                                                                      ? "Deshabilitar"
                                                                      : "Habilitar"),
                                                                  active: false,
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context,
                                                                        true);
                                                                  },
                                                                ),
                                                                const Expanded(
                                                                    child:
                                                                        SizedBox()),
                                                                MarsellaOnlyTextButton(
                                                                  key: const ValueKey(
                                                                      "btnCancelEnable"),
                                                                  text:
                                                                      'Cancelar',
                                                                  active: false,
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context,
                                                                        false);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          )).then((option) => {
                                                        if (option)
                                                          {
                                                            context
                                                                .read<
                                                                    UserLiveCubit>()
                                                                .changeCheckEnable(
                                                                    state
                                                                        .users[
                                                                            index]
                                                                        .id,
                                                                    value),
                                                          }
                                                      });
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.person,
                                                color: shThemeData
                                                    .textData.subTextColor,
                                                size: 28,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(state.users[index].username,
                                                  style: MarsellaTextStyles
                                                      .textButtonLabel(
                                                    shThemeData
                                                        .textData.subTextColor,
                                                  )),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Icon(
                                                Icons.email,
                                                color: shThemeData
                                                    .textData.subTextColor,
                                                size: 22,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(state.users[index].email,
                                                  style: MarsellaTextStyles
                                                      .textButtonLabel(
                                                    shThemeData
                                                        .textData.subTextColor,
                                                  )),
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    );
                  }
                  if (state is UserLoaded) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        MarsellaContainerSimple(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        right: 16.0, bottom: 13.0),
                                    child: MarsellaPostAvatar(
                                      imageURL: state.user.pictureThumbnailUrl,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Text(state.user.name,
                                          style: MarsellaTextStyles
                                              .textTitleRegisterUser(shThemeData
                                                  .postData.titleTextColor))),
                                ],
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              const MarsellaFormFieldTopLabel(
                                  text: 'Nombre de usuario'),
                              const SizedBox(
                                height: 20,
                              ),
                              MarsellaStrongText(
                                text: state.user.username,
                              ),
                              const SizedBox(
                                height: 36,
                              ),
                              const MarsellaFormFieldTopLabel(
                                  text: 'Correo electrónico'),
                              const SizedBox(
                                height: 20,
                              ),
                              MarsellaStrongText(
                                text: state.user.email,
                              ),
                              const SizedBox(
                                height: 36,
                              ),
                              const MarsellaFormFieldTopLabel(text: 'Estado'),
                              const SizedBox(
                                height: 20,
                              ),
                              MarsellaStrongText(
                                text: state.user.enabled
                                    ? 'Habilitado'
                                    : 'Deshabilitado',
                              ),
                              const SizedBox(
                                height: 34,
                              ),
                              Wrap(
                                spacing: 4.0,
                                runSpacing: 4.0,
                                children: [
                                  SizedBox(
                                    width: 114,
                                    height: 40,
                                    child: MarsellaOnlyTextButton(
                                      text: 'Modificar',
                                      active: false,
                                      onPressed: () {
                                        context.read<UserBloc>().add(
                                            OnUserPrepareForEdit(state.user));
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 106,
                                    height: 40,
                                    child: MarsellaOnlyTextButton(
                                      text: 'Eliminar',
                                      active: false,
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                GestureDetector(
                                                  onTap: () =>
                                                      Navigator.pop(context),
                                                  child: MarsellaAlertDialog(
                                                    title:
                                                        '¿Desea eliminar el usuario?',
                                                    content:
                                                        'La eliminación es permanente',
                                                    buttons: [
                                                      MarsellaDeleteIconButton(
                                                        key: const ValueKey(
                                                            "btnConfirmDelete"),
                                                        text: 'Eliminar',
                                                        active: false,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, true);
                                                        },
                                                      ),
                                                      const Expanded(
                                                          child: SizedBox()),
                                                      MarsellaOnlyTextButton(
                                                        key: const ValueKey(
                                                            "btnCancelDelete"),
                                                        text: 'Cancelar',
                                                        active: false,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, false);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                )).then((value) => {
                                              if (value)
                                                {
                                                  context.read<UserBloc>().add(
                                                      OnUserDelete(
                                                          state.user.id,
                                                          state.user.username))
                                                }
                                            });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: state.user.enabled ? 132 : 106,
                                    height: 40,
                                    child: MarsellaOnlyTextButton(
                                      text: state.user.enabled
                                          ? "Deshabilitar"
                                          : "Habilitar",
                                      active: false,
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                GestureDetector(
                                                  onTap: () =>
                                                      Navigator.pop(context),
                                                  child: MarsellaAlertDialog(
                                                    title:
                                                        '¿Desea ${(state.user.enabled ? "deshabilitar" : "habilitar")} el usuario?',
                                                    content:
                                                        'Esta acción afecta el acceso del usuario al sistema',
                                                    buttons: [
                                                      MarsellaOnlyTextButton(
                                                        key: const ValueKey(
                                                            "btnConfirmEnable"),
                                                        text:
                                                            (state.user.enabled
                                                                ? "Deshabilitar"
                                                                : "Habilitar"),
                                                        active: false,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, true);
                                                        },
                                                      ),
                                                      const Expanded(
                                                          child: SizedBox()),
                                                      MarsellaOnlyTextButton(
                                                        key: const ValueKey(
                                                            "btnCancelEnable"),
                                                        text: 'Cancelar',
                                                        active: false,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, false);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                )).then((value) => {
                                              if (value)
                                                {
                                                  context.read<UserBloc>().add(
                                                      OnUserEnable(
                                                          state.user.id,
                                                          !state.user.enabled,
                                                          state.user.username))
                                                }
                                            });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 189,
                                    height: 40,
                                    child: MarsellaOnlyTextButton(
                                      text: 'Cambiar contraseña',
                                      active: false,
                                      onPressed: () {
                                        context.read<UserBloc>().add(
                                            OnUserShowPasswordModifyForm(
                                                (state.user)));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MarsellaOnlyTextButton(
                                    text: 'Volver',
                                    active: false,
                                    onPressed: () {
                                      context
                                          .read<UserBloc>()
                                          .add(OnUserListLoad(
                                            "",
                                            _searchController.text,
                                            <String, int>{
                                              listFields.values.first: 1
                                            },
                                            1,
                                            10,
                                          ));
                                      context
                                          .read<VisibilityLiveCubit>()
                                          .showVisibility();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  if (state is UserUpdatePassword) {
                    final TextEditingController passwordController =
                        TextEditingController();
                    final TextEditingController repeatPasswordController =
                        TextEditingController();
                    return Column(
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        MarsellaContainerSimple(
                            child: Form(
                          key: _key,
                          child: UserUpdatePasswordForm(
                            passwordController: passwordController,
                            repeatPasswordController: repeatPasswordController,
                            keyForm: _key,
                            state: state,
                          ),
                        )),
                      ],
                    );
                  }
                  if (state is UserAdding) {
                    final TextEditingController nameController =
                        TextEditingController();
                    final TextEditingController usernameController =
                        TextEditingController();
                    final TextEditingController emailController =
                        TextEditingController();
                    final TextEditingController passwordController =
                        TextEditingController();
                    final TextEditingController repeatPasswordController =
                        TextEditingController();
                    return Column(
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        MarsellaContainerSimple(
                            child: Form(
                          key: _key,
                          child: UserAddingForm(
                              nameController: nameController,
                              usernameController: usernameController,
                              emailController: emailController,
                              passwordController: passwordController,
                              repeatPasswordController:
                                  repeatPasswordController,
                              searchController: _searchController,
                              listFields: listFields,
                              keyForm: _key,
                              state: state),
                        )),
                      ],
                    );
                  }
                  if (state is UserEditing) {
                    final TextEditingController nameController =
                        TextEditingController();
                    final TextEditingController usernameController =
                        TextEditingController();
                    final TextEditingController emailController =
                        TextEditingController();
                    nameController.text = state.user.name;
                    usernameController.text = state.user.username;
                    emailController.text = state.user.email;
                    return Column(
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        MarsellaContainerSimple(
                            child: Form(
                          key: _key,
                          child: UserEditingForm(
                              nameController: nameController,
                              usernameController: usernameController,
                              emailController: emailController,
                              keyForm: _key,
                              state: state),
                        )),
                      ],
                    );
                  }
                  if (state is UserListNotInOrgaLoaded) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.users.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  MarsellaContainerSimple(
                                    //Usuarios
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  right: 16.0, bottom: 13.0),
                                              child: MarsellaPostAvatar(
                                                imageURL: state.users[index]
                                                    .pictureThumbnailUrl,
                                              ),
                                            ),
                                            const Spacer(),
                                            IgnorePointer(
                                              child: ShamiaInputToggleOption(
                                                  text: '',
                                                  active:
                                                      state.users[index].enabled,
                                                  onChanged: (value) {}),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: shThemeData
                                                  .textData.subTextColor,
                                              size: 28,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(state.users[index].username,
                                                style: MarsellaTextStyles
                                                    .textButtonLabel(
                                                  shThemeData
                                                      .textData.subTextColor,
                                                )),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Icon(
                                              Icons.email,
                                              color: shThemeData
                                                  .textData.subTextColor,
                                              size: 22,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(state.users[index].email,
                                                style: MarsellaTextStyles
                                                    .textButtonLabel(
                                                  shThemeData
                                                      .textData.subTextColor,
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              );
                            }),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class UserUpdatePasswordForm extends StatelessWidget {
  const UserUpdatePasswordForm({
    super.key,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.keyForm,
    required this.state,
  });

  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  final GlobalKey<FormState> keyForm;
  final UserUpdatePassword state;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const MarsellaFormFieldTopLabel(text: 'Contraseña'),
      const SizedBox(height: 10),
      MarsellaPostInputPass(
        key: const ValueKey("txtPassword"),
        hintText: '',
        text: '',
        titleController: passwordController,
        validator: (value) => Validators.validateName(value ?? ""),
      ),
      const Divider(
        height: 16,
        color: Colors.transparent,
      ),
      const MarsellaFormFieldTopLabel(text: 'Repetir Contraseña'),
      const SizedBox(height: 10),
      MarsellaPostInputPass(
        key: const ValueKey("txtRepeatPassword"),
        hintText: '',
        text: '',
        titleController: repeatPasswordController,
        validator: (value) => Validators.validatePasswordEqual(
            value ?? "", passwordController.text),
      ),
      const Divider(
        height: 16,
        color: Colors.transparent,
      ),
      Row(
        children: [
          MarsellaCancelIconButton(
              text: 'Cancelar',
              onPressed: () {
                context.read<UserBloc>().add(OnUserLoad(state.user.id));
              },
              active: false),
          const Expanded(
            child: SizedBox(
              width: 0,
            ),
          ),
          MarsellaOkIconButton(
              text: 'Guardar cambios',
              onPressed: () {
                if (keyForm.currentState?.validate() == true) {
                  context.read<UserBloc>().add(OnUserSaveNewPassword(
                      passwordController.text, state.user));
                  showDialog(
                    context: context,
                    builder: (context) => MarsellaAlertDialog(
                      title: 'Contraseña modificada',
                      content: 'La contraseña se modificó correctamente.',
                      buttons: [
                        MarsellaOnlyTextButton(
                            text: 'Ok',
                            active: false,
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  );
                }
              },
              active: false),
        ],
      )
    ]);
  }
}

class UserEditingForm extends StatelessWidget {
  const UserEditingForm({
    super.key,
    required this.nameController,
    required this.usernameController,
    required this.emailController,
    required this.keyForm,
    required this.state,
  });

  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final GlobalKey<FormState> keyForm;
  final UserEditing state;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const MarsellaFormFieldTopLabel(text: 'Nombre'),
      const SizedBox(height: 10),
      MarsellaPostInput(
        key: const ValueKey("txtNombre"),
        hintText: '',
        text: '',
        titleController: nameController,
        validator: (value) => Validators.validateName(value ?? ""),
      ),
      const Divider(
        height: 16,
        color: Colors.transparent,
      ),
      const MarsellaFormFieldTopLabel(text: 'Username'),
      const SizedBox(height: 10),
      MarsellaPostInput(
        key: const ValueKey("txtUsername"),
        hintText: '',
        text: '',
        titleController: usernameController,
        onChanged: (value) {
          context.read<UserBloc>().add(OnUserValidateEdit(state.user.id,
              usernameController.text, emailController.text, state));
        },
        validator: (value) => Validators.validateName(value ?? ""),
      ),
      const Divider(
        height: 16,
        color: Colors.transparent,
      ),
      const MarsellaFormFieldTopLabel(text: 'Email'),
      const SizedBox(height: 10),
      MarsellaPostInput(
        key: const ValueKey("txtEmail"),
        hintText: '',
        text: '',
        titleController: emailController,
        onChanged: (value) {
          context.read<UserBloc>().add(OnUserValidateEdit(state.user.id,
              usernameController.text, emailController.text, state));
        },
        validator: (value) => Validators.validateName(value ?? ""),
      ),
      const Divider(
        height: 16,
        color: Colors.transparent,
      ),
      Row(
        children: [
          MarsellaCancelIconButton(
              text: 'Cancelar',
              onPressed: () {
                context.read<UserBloc>().add(OnUserLoad(state.user.id));
              },
              active: false),
          const Expanded(
            child: SizedBox(
              width: 0,
            ),
          ),
          MarsellaOkIconButton(
              text: 'Guardar',
              onPressed: () {
                if (keyForm.currentState?.validate() == true) {
                  context.read<UserBloc>().add(OnUserEdit(
                      state.user.id,
                      nameController.text,
                      usernameController.text,
                      emailController.text,
                      state.user.enabled,
                      state.user));
                  context.read<VisibilityLiveCubit>().showVisibility();
                }
              },
              active: false),
        ],
      )
    ]);
  }
}

class UserAddingForm extends StatelessWidget {
  const UserAddingForm({
    super.key,
    required this.nameController,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.searchController,
    required this.listFields,
    required this.keyForm,
    required this.state,
  });

  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  final TextEditingController searchController;
  final Map<String, String> listFields;
  final GlobalKey<FormState> keyForm;
  final UserAdding state;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const MarsellaFormFieldTopLabel(text: 'Nombre'),
      const SizedBox(height: 10),
      MarsellaPostInput(
        key: const ValueKey("txtNombre"),
        hintText: '',
        text: '',
        titleController: nameController,
        validator: (value) => Validators.validateName(value ?? ""),
      ),
      const Divider(
        height: 16,
        color: Colors.transparent,
      ),
      const MarsellaFormFieldTopLabel(text: 'Username'),
      const SizedBox(height: 10),
      MarsellaPostInput(
        key: const ValueKey("txtUsername"),
        hintText: '',
        text: '',
        titleController: usernameController,
        onChanged: (value) {
          context.read<UserBloc>().add(OnUserValidate(
              usernameController.text, emailController.text, state));
        },
        validator: (value) => Validators.validateName(value ?? ""),
      ),
      const Divider(
        height: 16,
        color: Colors.transparent,
      ),
      const MarsellaFormFieldTopLabel(text: 'Email'),
      const SizedBox(height: 10),
      MarsellaPostInput(
        key: const ValueKey("txtEmail"),
        hintText: '',
        text: '',
        titleController: emailController,
        onChanged: (value) {
          context.read<UserBloc>().add(OnUserValidate(
              usernameController.text, emailController.text, state));
        },
        validator: (value) => Validators.validateName(value ?? ""),
      ),
      const Divider(
        height: 16,
        color: Colors.transparent,
      ),
      const MarsellaFormFieldTopLabel(text: 'Contraseña'),
      const SizedBox(height: 10),
      MarsellaPostInputPass(
        key: const ValueKey("txtPassword"),
        hintText: '',
        text: '',
        titleController: passwordController,
        validator: (value) => Validators.validateName(value ?? ""),
      ),
      const Divider(
        height: 16,
        color: Colors.transparent,
      ),
      const MarsellaFormFieldTopLabel(text: 'Repetir Contraseña'),
      const SizedBox(height: 10),
      MarsellaPostInputPass(
        key: const ValueKey("txtRepeatPassword"),
        hintText: '',
        text: '',
        titleController: repeatPasswordController,
        validator: (value) => Validators.validatePasswordEqual(
            value ?? "", passwordController.text),
      ),
      const Divider(
        height: 16,
        color: Colors.transparent,
      ),
      Row(
        children: [
          MarsellaCancelIconButton(
              text: 'Cancelar',
              onPressed: () {
                context.read<UserBloc>().add(OnUserListLoad(
                    "",
                    searchController.text,
                    <String, int>{listFields.values.first: 1},
                    1,
                    10));
                context.read<VisibilityLiveCubit>().showVisibility();
              },
              active: false),
          const Expanded(
            child: SizedBox(
              width: 0,
            ),
          ),
          MarsellaOkIconButton(
              text: 'Guardar',
              onPressed: () {
                if (keyForm.currentState?.validate() == true) {
                  context.read<UserBloc>().add(OnUserAdd(
                      nameController.text,
                      usernameController.text,
                      emailController.text,
                      passwordController.text));
                  context.read<VisibilityLiveCubit>().showVisibility();
                }
              },
              active: false),
        ],
      )
    ]);
  }
}
