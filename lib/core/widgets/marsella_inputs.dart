import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marsellafrontend/core/themes/marsella_colors.dart';
import 'package:marsellafrontend/core/themes/marsella_text_styles.dart';
import 'package:marsellafrontend/core/widgets/marsella_buttons.dart';
import 'package:marsellafrontend/core/widgets/marsella_icons.dart';
import 'package:marsellafrontend/core/widgets/marsella_widgets.dart';

import 'package:textfield_tags/textfield_tags.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/themes/marsella_screen.dart';
import '../themes/marsella_themedata.dart';
import '../validators.dart';

class MarsellaInputData {
  final Color textColor;
  final Color borderColor;
  final Color enabledBorderColor;
  final Color fillColor;
  final Color hintColor;
  final Color suffixIconColor;
  final Color cancelIconColor;
  final Color errorColor;

  const MarsellaInputData(
      {required this.textColor,
      required this.borderColor,
      required this.enabledBorderColor,
      required this.fillColor,
      required this.hintColor,
      required this.suffixIconColor,
      required this.cancelIconColor,
      required this.errorColor});
}

class MarsellaTagInputData {
  final Color textColor;
  final Color borderColor;
  final Color enabledBorderColor;
  final Color fillColor;
  final Color hintColor;
  final Color suffixIconColor;
  final Color cancelIconColor;
  final Color errorColor;
  final Color tagBackgroundColor;
  final Color tagTextColor;
  final Color tagIconColor;

  const MarsellaTagInputData(
      {required this.textColor,
      required this.borderColor,
      required this.enabledBorderColor,
      required this.fillColor,
      required this.hintColor,
      required this.suffixIconColor,
      required this.cancelIconColor,
      required this.errorColor,
      required this.tagBackgroundColor,
      required this.tagTextColor,
      required this.tagIconColor});
}

class MarsellaCheckboxData {
  final Color textColor;
  final Color fillColor;
  final Color borderColor;
  final Color checkColor;
  const MarsellaCheckboxData({
    required this.textColor,
    required this.fillColor,
    required this.borderColor,
    required this.checkColor,
  });
}

class MarsellaToggleData {
  final Color textColor;
  final Color activeThumbColor;
  final Color activeTrackColor;
  final Color inactiveThumbColor;
  final Color inactiveTrackColor;

  const MarsellaToggleData({
    required this.textColor,
    required this.activeThumbColor,
    required this.activeTrackColor,
    required this.inactiveThumbColor,
    required this.inactiveTrackColor,
  });
}

class MarsellaSideMenuInputSearch extends StatelessWidget {
  const MarsellaSideMenuInputSearch({
    super.key,
    required this.hintText,
    required this.text,
    required this.searchController,
    this.onPressedIcon,
    this.onSubmitted,
  });

  final String hintText;
  final String text;
  final TextEditingController searchController;
  final VoidCallback? onPressedIcon;
  final String? Function(String?)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    FocusNode fn = FocusNode();
    final shThemeData = MarsellaTheme.of(context).sideMenuInputSearchData;

    return Container(
      height: 40,
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: TextFormField(
        autofocus: searchController.text.isNotEmpty,
        focusNode: fn,
        onFieldSubmitted: (value) {
          if (onSubmitted != null) {
            onSubmitted?.call(value);
          }
          fn.requestFocus();
        },
        controller: searchController,
        textAlignVertical: TextAlignVertical.bottom,
        style: MarsellaTextStyles.textPlaceholder(shThemeData.textColor),
        decoration: InputDecoration(
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: shThemeData.borderColor,
                style: BorderStyle.solid,
              ),
            ),
            fillColor: shThemeData.fillColor,
            alignLabelWithHint: true,
            hintStyle:
                MarsellaTextStyles.textPlaceholderText(shThemeData.hintColor),
            hintText: hintText,
            suffixIcon: IconButton(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onPressed: onPressedIcon,
                icon: searchController.text.isEmpty
                    ? MarsellaIconSearch(color: shThemeData.suffixIconColor)
                    : MarsellaIconCancelSearch(
                        color: shThemeData.suffixIconColor,
                      )),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: shThemeData.enabledBorderColor,
                style: BorderStyle.solid,
              ),
            )),
      ),
    );
  }
}

class MarsellaAppBarInputSearch extends StatelessWidget {
  const MarsellaAppBarInputSearch({
    super.key,
    required this.hintText,
    required this.text,
    required this.searchController,
    this.onPressedIcon,
    this.onSubmitted,
    this.focusNode,
  });
  final String hintText;
  final String text;
  final TextEditingController searchController;
  final VoidCallback? onPressedIcon;
  final FocusNode? focusNode;
  final String? Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    FocusNode fn = FocusNode();
    final shThemeData = MarsellaTheme.of(context).sideMenuInputSearchData;
    return Container(
      width: MarsellaScreen.screenIsSmallSize(context) ? 60 : 305,
      padding: const EdgeInsets.only(top: 13, right: 15, bottom: 27),
      child: TextFormField(
        autofocus: searchController.text.isNotEmpty,
        focusNode: fn,
        onFieldSubmitted: (value) {
          if (onSubmitted != null) {
            onSubmitted?.call(value);
          }
          fn.requestFocus();
        },
        controller: searchController,
        textAlignVertical: TextAlignVertical.bottom,
        style: MarsellaTextStyles.textPlaceholder(shThemeData.textColor),
        decoration: InputDecoration(
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: shThemeData.borderColor,
                style: BorderStyle.solid,
              ),
            ),
            fillColor: shThemeData.fillColor,
            alignLabelWithHint: true,
            hintStyle:
                MarsellaTextStyles.textPlaceholderText(shThemeData.hintColor),
            hintText: hintText,
            suffixIcon: IconButton(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onPressed: onPressedIcon,
                icon: searchController.text.isEmpty
                    ? MarsellaIconSearch(color: shThemeData.suffixIconColor)
                    : MarsellaIconCancelSearch(
                        color: shThemeData.suffixIconColor,
                      )),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: shThemeData.enabledBorderColor,
                style: BorderStyle.solid,
              ),
            )),
      ),
    );
  }
}

class MarsellaAppBarInputSearchMobile extends StatelessWidget {
  MarsellaAppBarInputSearchMobile(
      {super.key,
      required this.isExpanded,
      required this.hintText,
      required this.text,
      required this.searchController,
      this.onPressedIcon,
      this.onSubmitted,
      this.onTap});

  final bool isExpanded;
  final String hintText;
  final String text;
  final TextEditingController searchController;
  final VoidCallback? onPressedIcon;
  final VoidCallback? onTap;
  final String? Function(String?)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    FocusNode fn = FocusNode();

    final shThemeData = MarsellaTheme.of(context).sideMenuInputSearchData;
    return TextFormField(
      autofocus: searchController.text.isNotEmpty,
      focusNode: fn,
      onFieldSubmitted: (value) {
        if (onSubmitted != null) {
          onSubmitted?.call(value);
        }
        fn.requestFocus();
      },
      controller: searchController,
      textAlignVertical: TextAlignVertical.bottom,
      style: MarsellaTextStyles.textPlaceholder(shThemeData.textColor),
      decoration: InputDecoration(
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: shThemeData.borderColor,
              style: BorderStyle.solid,
            ),
          ),
          fillColor: shThemeData.fillColor,
          alignLabelWithHint: true,
          hintStyle:
              MarsellaTextStyles.textPlaceholderText(shThemeData.hintColor),
          hintText: hintText,
          suffixIcon: isExpanded
              ? IconButton(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: onPressedIcon,
                  icon: MarsellaIconCancelSearch(
                      color: shThemeData.suffixIconColor))
              : IconButton(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: onTap,
                  padding: const EdgeInsetsDirectional.only(end: 9.0),
                  icon: MarsellaIconSearch(color: shThemeData.suffixIconColor),
                ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: shThemeData.enabledBorderColor,
              style: BorderStyle.solid,
            ),
          )),
    );
  }
}

class MarsellaAdminInputSearch extends StatelessWidget {
  const MarsellaAdminInputSearch({
    super.key,
    required this.hintText,
    //required this.text,
    required this.searchController,
    this.onPressedIcon,
    this.onSubmitted,
  });
  final String hintText;
  //final String text;
  final TextEditingController searchController;
  final VoidCallback? onPressedIcon;
  final String? Function(String?)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    FocusNode fn = FocusNode();
    final shThemeData = MarsellaTheme.of(context).sideMenuInputSearchData;

    return TextFormField(
      autofocus: searchController.text.isNotEmpty,
      focusNode: fn,
      onFieldSubmitted: (value) {
        if (onSubmitted != null) {
          onSubmitted?.call(value);
        }
        fn.requestFocus();
      },
      controller: searchController,
      textAlignVertical: TextAlignVertical.bottom,
      style: MarsellaTextStyles.textPlaceholder(shThemeData.textColor),
      decoration: InputDecoration(
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: shThemeData.borderColor,
              style: BorderStyle.solid,
            ),
          ),
          fillColor: shThemeData.fillColor,
          alignLabelWithHint: true,
          hintStyle:
              MarsellaTextStyles.textPlaceholderText(shThemeData.hintColor),
          hintText: hintText,
          suffixIcon: IconButton(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onPressed: onPressedIcon,
              icon: searchController.text.isEmpty
                  ? MarsellaIconSearch(color: shThemeData.suffixIconColor)
                  : MarsellaIconCancelSearch(
                      color: shThemeData.suffixIconColor,
                    )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: shThemeData.enabledBorderColor,
              style: BorderStyle.solid,
            ),
          )),
    );
  }
}

class MarsellaPostInputTitle extends StatelessWidget {
  const MarsellaPostInputTitle({
    super.key,
    required this.titleController,
    required this.hintText,
    required this.text,
    this.validator,
  });

  final TextEditingController titleController;
  final String hintText;
  final String text;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).postInputData;
    final shThemeDataAll = MarsellaTheme.of(context);

    return Container(
      height: 91,
      padding: const EdgeInsets.only(top: 10.0, bottom: 20),
      child: TextFormField(
        key: const ValueKey('txtTitle'),
        maxLength: 150,
        controller: titleController,
        validator: validator,
        decoration: InputDecoration(
          counterStyle: MarsellaTextStyles.textCounterTextFormField(
              shThemeDataAll.textData.textColor),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: shThemeData.borderColor,
              style: BorderStyle.solid,
            ),
          ),
          isDense: true,
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: shThemeData.errorColor,
            style: BorderStyle.solid,
          )),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: MarsellaColors.marsellaRed,
            style: BorderStyle.solid,
          )),
          errorStyle: MarsellaTextStyles.textStrongError(shThemeData.errorColor),
          errorMaxLines: 2,
          fillColor: shThemeData.fillColor,
          alignLabelWithHint: true,
          hintStyle:
              MarsellaTextStyles.textPlaceholderText(shThemeData.hintColor),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: shThemeData.enabledBorderColor,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}

class MarsellaPostInput extends StatelessWidget {
  const MarsellaPostInput({
    super.key,
    required TextEditingController titleController,
    required this.hintText,
    required this.text,
    this.validator,
    this.onChanged,
  }) : _titleController = titleController;

  final TextEditingController _titleController;
  final String hintText;
  final String text;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).postInputData;
    final shThemeDataAll = MarsellaTheme.of(context);

    return Container(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: TextFormField(
        key: const ValueKey('txtName'),
        //maxLength: 150,
        controller: _titleController,
        onChanged: onChanged,
        validator: validator,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: shThemeData.borderColor,
                style: BorderStyle.solid,
              ),
            ),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
              width: 1,
              color: shThemeData.errorColor,
              style: BorderStyle.solid,
            )),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
              width: 1,
              color: MarsellaColors.marsellaRed,
              style: BorderStyle.solid,
            )),
            errorStyle:
                MarsellaTextStyles.textStrongError(shThemeData.errorColor),
            filled: true,
            errorMaxLines: 2,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: shThemeData.borderColor,
                style: BorderStyle.solid,
              ),
            ),
            fillColor: shThemeData.fillColor,
            alignLabelWithHint: true,
            hintStyle:
                MarsellaTextStyles.textPlaceholderText(shThemeData.hintColor),
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: shThemeData.enabledBorderColor,
                style: BorderStyle.solid,
              ),
            )),
      ),
    );
  }
}

class MarsellaPostInputPass extends StatelessWidget {
  const MarsellaPostInputPass({
    super.key,
    required this.titleController,
    required this.hintText,
    required this.text,
    this.validator,
  });

  final TextEditingController titleController;
  final String hintText;
  final String text;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).postInputData;
    final shThemeDataAll = MarsellaTheme.of(context);

    return Container(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: TextFormField(
        key: const ValueKey('txtPass'),
        //maxLength: 150,
        controller: titleController,
        validator: (value) => Validators.validateName(value ?? ""),
        obscureText: true,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          counterStyle: MarsellaTextStyles.textCounterTextFormField(
              shThemeDataAll.textData.textColor),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: shThemeData.borderColor,
              style: BorderStyle.solid,
            ),
          ),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: shThemeData.errorColor,
            style: BorderStyle.solid,
          )),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: MarsellaColors.marsellaRed,
            style: BorderStyle.solid,
          )),
          errorStyle: MarsellaTextStyles.textStrongError(shThemeData.errorColor),
          errorMaxLines: 1,
          fillColor: shThemeData.fillColor,
          alignLabelWithHint: true,
          hintStyle:
              MarsellaTextStyles.textPlaceholderText(shThemeData.hintColor),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: shThemeData.enabledBorderColor,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}

class MarsellaPostInputTextContent extends StatelessWidget {
  const MarsellaPostInputTextContent({
    super.key,
    required this.contentController,
    required this.hintText,
    required this.text,
    this.validator,
  });

  final TextEditingController contentController;
  final String hintText;
  final String text;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).postInputData;
    final shThemeDataAll = MarsellaTheme.of(context);
    return Container(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: TextFormField(
        validator: validator,
        maxLength: 500,
        maxLines: 4,
        minLines: 4,
        controller: contentController,
        key: const ValueKey('txtContent'),
        decoration: InputDecoration(
          counterStyle: MarsellaTextStyles.textCounterTextFormField(
              shThemeDataAll.textData.textColor),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: shThemeData.borderColor,
              style: BorderStyle.solid,
            ),
          ),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: shThemeData.errorColor,
            style: BorderStyle.solid,
          )),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: MarsellaColors.marsellaRed,
            style: BorderStyle.solid,
          )),
          errorStyle: MarsellaTextStyles.textStrongError(shThemeData.errorColor),
          errorMaxLines: 2,
          fillColor: shThemeData.fillColor,
          alignLabelWithHint: true,
          hintStyle:
              MarsellaTextStyles.textPlaceholderText(shThemeData.hintColor),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: shThemeData.enabledBorderColor,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}

class MarsellaPostInputSources extends StatelessWidget {
  const MarsellaPostInputSources(
      {super.key,
      required this.sourceController,
      required this.hintText,
      required this.text,
      this.validator,
      this.initialTags,
      this.textSeparators,
      this.letterCase,
      this.focusNode,
      required this.textfieldTagsController});

  final TextEditingController sourceController;
  final String hintText;
  final String text;

  final String? Function(String)? validator;

  final List<String>? initialTags;
  final List<String>? textSeparators;
  final LetterCase? letterCase;
  final FocusNode? focusNode;
  final TextfieldTagsController textfieldTagsController;

  @override
  Widget build(BuildContext context) {
    double _distanceToField = MediaQuery.of(context).size.width;
    final shThemeData = MarsellaTheme.of(context).postInputData;
    return Container(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: TextFieldTags(
          key: key,
          textEditingController: sourceController,
          validator: validator,
          initialTags: initialTags,
          textSeparators: textSeparators,
          letterCase: letterCase,
          focusNode: focusNode,
          textfieldTagsController: textfieldTagsController,
          inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
            return ((context, sc, tags, onTagDelete) {
              final shThemeData = MarsellaTheme.of(context);
              return Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextField(
                  controller: tec,
                  focusNode: fn,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        width: 1,
                        color: shThemeData.postInputData.borderColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        width: 1,
                        color: shThemeData.postInputData.borderColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                    helperText: '',
                    hintText: textfieldTagsController.hasTags ? '' : hintText,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 12),
                    fillColor: shThemeData.postInputData.fillColor,
                    alignLabelWithHint: true,
                    hintStyle: MarsellaTextStyles.textPlaceholderText(
                        shThemeData.postInputData.hintColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        width: 1,
                        color: shThemeData.postInputData.enabledBorderColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                    errorText: error,
                    errorStyle: MarsellaTextStyles.textStrongError(
                        shThemeData.errorColor),
                    errorMaxLines: 2,
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 1,
                      color: shThemeData.errorColor,
                      style: BorderStyle.solid,
                    )),
                    prefixIconConstraints:
                        BoxConstraints(maxWidth: _distanceToField * 0.74),
                    prefixIcon: tags.isNotEmpty
                        ? SingleChildScrollView(
                            controller: sc,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: tags.map((String tag) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0),
                                  ),
                                  color: shThemeData
                                      .tagInputData.tagBackgroundColor,
                                ),
                                margin: const EdgeInsets.only(
                                    left: 4.0, right: 4.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2.0, vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(width: 4.0),
                                    InkWell(
                                      child: MarsellaIconCancel(
                                        color: shThemeData
                                            .tagInputData.tagIconColor,
                                      ),
                                      onTap: () {
                                        onTagDelete(tag);
                                      },
                                    ),
                                    InkWell(
                                      child: Text(
                                        ' $tag',
                                        style: MarsellaTextStyles.textTag(
                                            shThemeData
                                                .tagInputData.tagTextColor),
                                      ),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              );
                            }).toList()),
                          )
                        : null,
                  ),
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                ),
              );
            });
          }),
    );
  }
}

class MarsellaPostInputTagCategories extends StatelessWidget {
  const MarsellaPostInputTagCategories(
      {super.key,
      required this.categoryController,
      required this.hintText,
      required this.text,
      this.validator,
      this.initialTags,
      this.textSeparators,
      this.letterCase,
      this.focusNode,
      required this.textfieldTagsController});

  final TextEditingController categoryController;
  final String hintText;
  final String text;

  final String? Function(String)? validator;

  final List<String>? initialTags;
  final List<String>? textSeparators;
  final LetterCase? letterCase;
  final FocusNode? focusNode;
  final TextfieldTagsController textfieldTagsController;
  @override
  Widget build(BuildContext context) {
    double _distanceToField = MediaQuery.of(context).size.width;
    final shThemeData = MarsellaTheme.of(context).postInputData;
    return Container(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: TextFieldTags(
          key: key,
          textEditingController: categoryController,
          validator: validator,
          initialTags: initialTags,
          textSeparators: textSeparators,
          letterCase: letterCase,
          focusNode: focusNode,
          textfieldTagsController: textfieldTagsController,
          inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
            return ((context, sc, tags, onTagDelete) {
              final shThemeData = MarsellaTheme.of(context);

              return Padding(
                padding: const EdgeInsets.all(0.0),
                child: RawKeyboardListener(
                  focusNode: FocusNode(),
                  onKey: (event) {
                    if (tec.text.isEmpty &&
                        event.logicalKey == LogicalKeyboardKey.backspace) {
                      onTagDelete(textfieldTagsController.getTags!.last);
                    }
                  },
                  child: TextField(
                    controller: tec,
                    focusNode: fn,
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          width: 1,
                          color: shThemeData.postInputData.borderColor,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          width: 1,
                          color: shThemeData.postInputData.borderColor,
                          style: BorderStyle.solid,
                        ),
                      ),
                      helperText: '',
                      hintText: textfieldTagsController.hasTags ? '' : hintText,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 12),
                      fillColor: shThemeData.postInputData.fillColor,
                      alignLabelWithHint: true,
                      hintStyle: MarsellaTextStyles.textPlaceholderText(
                          shThemeData.postInputData.hintColor),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          width: 1,
                          color: shThemeData.postInputData.enabledBorderColor,
                          style: BorderStyle.solid,
                        ),
                      ),
                      errorText: error,
                      errorStyle: MarsellaTextStyles.textStrongError(
                          shThemeData.errorColor),
                      errorMaxLines: 2,
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 1,
                        color: shThemeData.errorColor,
                        style: BorderStyle.solid,
                      )),
                      prefixIconConstraints:
                          BoxConstraints(maxWidth: _distanceToField * 0.74),
                      prefixIcon: tags.isNotEmpty
                          ? SingleChildScrollView(
                              controller: sc,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: tags.map((String tag) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                    color: shThemeData
                                        .tagInputData.tagBackgroundColor,
                                  ),
                                  margin: const EdgeInsets.only(
                                      left: 4.0, right: 4.0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 4.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(width: 4.0),
                                      InkWell(
                                        child: MarsellaIconCancel(
                                          color: shThemeData
                                              .tagInputData.tagIconColor,
                                        ),
                                        onTap: () {
                                          onTagDelete(tag);
                                        },
                                      ),
                                      InkWell(
                                        child: Text(
                                          ' $tag',
                                          style: MarsellaTextStyles.textTag(
                                              shThemeData
                                                  .tagInputData.tagTextColor),
                                        ),
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                );
                              }).toList()),
                            )
                          : null,
                    ),
                    onChanged: onChanged,
                    onSubmitted: (value) {
                      if (onSubmitted != null) {
                        onSubmitted.call(value);
                      }
                      fn.requestFocus();
                    },
                  ),
                ),
              );
            });
          }),
    );
  }
}

class MarsellaCheckbox extends StatelessWidget {
  const MarsellaCheckbox({
    super.key,
    required this.text,
    required this.isChecked,
    required this.onChanged,
  });

  final String text;
  final bool? isChecked;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).checkBoxData;
    return Row(
      children: [
        Checkbox(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: BorderSide(
                color: shThemeData.borderColor,
                width: 2,
              )),
          side: BorderSide(
            color: shThemeData.borderColor,
            width: 2,
          ),
          checkColor: shThemeData.checkColor,
          hoverColor: shThemeData.fillColor,
          fillColor: MaterialStatePropertyAll(shThemeData.fillColor),
          value: isChecked,
          onChanged: onChanged,
        ),
        Text(text,
            style: MarsellaTextStyles.textPlaceholder(shThemeData.textColor)),
      ],
    );
  }
}

class MarsellaPostInputMediaURL extends StatelessWidget {
  const MarsellaPostInputMediaURL({
    super.key,
    required this.contentControllerMediaUrl,
    required this.hintText,
    required this.text,
    this.validator,
  });

  final TextEditingController contentControllerMediaUrl;
  final String hintText;
  final String text;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).postInputData;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        child: TextFormField(
          controller: contentControllerMediaUrl,
          key: const ValueKey("txtURL"),
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: shThemeData.borderColor,
                style: BorderStyle.solid,
              ),
            ),
            isDense: true,
            fillColor: shThemeData.fillColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            alignLabelWithHint: true,
            hintStyle:
                MarsellaTextStyles.textPlaceholderText(shThemeData.hintColor),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: shThemeData.enabledBorderColor,
                style: BorderStyle.solid,
              ),
            ),
            errorStyle:
                MarsellaTextStyles.textStrongError(shThemeData.errorColor),
            errorMaxLines: 1,
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
              width: 1,
              color: shThemeData.errorColor,
              style: BorderStyle.solid,
            )),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
              width: 1,
              color: MarsellaColors.marsellaRed,
              style: BorderStyle.solid,
            )),
          ),
        ),
      ),
    );
  }
}

class MarsellaLoginPasswordInput extends StatelessWidget {
  const MarsellaLoginPasswordInput({
    super.key,
    required TextEditingController passwordController,
    required this.hintText,
    required this.text,
    this.validator,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;
  final String hintText;
  final String text;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).loginInputData;
    return Container(
      width: 290,
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: TextFormField(
        validator: validator,
        style: MarsellaTextStyles.textPlaceholder(shThemeData.textColor),
        textInputAction: TextInputAction.next,
        controller: _passwordController,
        key: key,
        obscureText: true,
        obscuringCharacter: '*',
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: shThemeData.borderColor,
                style: BorderStyle.solid,
              ),
            ),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
              width: 1,
              color: shThemeData.errorColor,
              style: BorderStyle.solid,
            )),
            filled: true,
            errorMaxLines: 2,
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
              width: 1,
              color: MarsellaColors.marsellaRed,
              style: BorderStyle.solid,
            )),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: shThemeData.borderColor,
                style: BorderStyle.solid,
              ),
            ),
            errorStyle:
                MarsellaTextStyles.textStrongError(shThemeData.errorColor),
            fillColor: shThemeData.fillColor,
            alignLabelWithHint: true,
            hintStyle:
                MarsellaTextStyles.textPlaceholderText(shThemeData.hintColor),
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: shThemeData.enabledBorderColor,
                style: BorderStyle.solid,
              ),
            )),
      ),
    );
  }
}

class MarsellaLoginUsernameInput extends StatelessWidget {
  const MarsellaLoginUsernameInput({
    super.key,
    required this.emailController,
    required this.hintText,
    required this.text,
    this.validator,
  });

  final TextEditingController emailController;
  final String hintText;
  final String text;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).loginInputData;
    return Container(
      width: 290,
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: TextFormField(
        validator: validator,
        style: MarsellaTextStyles.textPlaceholder(shThemeData.textColor),
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: shThemeData.borderColor,
                style: BorderStyle.solid,
              ),
            ),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
              width: 1,
              color: shThemeData.errorColor,
              style: BorderStyle.solid,
            )),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
              width: 1,
              color: MarsellaColors.marsellaRed,
              style: BorderStyle.solid,
            )),
            errorStyle:
                MarsellaTextStyles.textStrongError(shThemeData.errorColor),
            filled: true,
            errorMaxLines: 2,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: shThemeData.borderColor,
                style: BorderStyle.solid,
              ),
            ),
            fillColor: shThemeData.fillColor,
            alignLabelWithHint: true,
            hintStyle:
                MarsellaTextStyles.textPlaceholderText(shThemeData.hintColor),
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: shThemeData.enabledBorderColor,
                style: BorderStyle.solid,
              ),
            )),
        controller: emailController,
      ),
    );
  }
}

class ShamiaInputToggleOption extends StatelessWidget {
  const ShamiaInputToggleOption({
    super.key,
    this.onChanged,
    required this.active,
    required this.text,
  });

  final Function(bool)? onChanged;
  final bool active;
  final String text;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).toggleData;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: MarsellaTextStyles.textPageTitle(shThemeData.textColor),
          ),
          text == ''
              ? const SizedBox()
              : const SizedBox(
                  width: 10,
                ),
          Switch(
              value: active,
              activeColor: shThemeData.activeThumbColor,
              activeTrackColor: shThemeData.activeTrackColor,
              inactiveThumbColor: shThemeData.inactiveThumbColor,
              inactiveTrackColor: shThemeData.inactiveTrackColor,
              onChanged: onChanged),
        ],
      ),
    );
  }
}

class MarsellaProfileInput extends StatelessWidget {
  const MarsellaProfileInput({
    required this.key,
    required this.hintText,
    this.validator,
    required this.controller,
    this.maxLength,
    this.obscureText,
    this.obscuringCharacter,
  });

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final int? maxLength;
  final bool? obscureText;
  final String? obscuringCharacter;
  final ValueKey key;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).postInputData;
    final shThemeDataAll = MarsellaTheme.of(context);

    return Container(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: TextFormField(
        key: key,
        textInputAction: TextInputAction.none,
        obscureText: obscureText ?? false,
        obscuringCharacter: obscuringCharacter ?? '*',
        maxLength: maxLength,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          counterStyle: MarsellaTextStyles.textCounterTextFormField(
              shThemeDataAll.textData.textColor),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: shThemeData.borderColor,
              style: BorderStyle.solid,
            ),
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: shThemeData.errorColor,
            style: BorderStyle.solid,
          )),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: MarsellaColors.marsellaRed,
            style: BorderStyle.solid,
          )),
          errorStyle: MarsellaTextStyles.textStrongError(shThemeData.errorColor),
          errorMaxLines: 2,
          fillColor: shThemeData.fillColor,
          alignLabelWithHint: true,
          hintStyle:
              MarsellaTextStyles.textPlaceholderText(shThemeData.hintColor),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: shThemeData.enabledBorderColor,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}
