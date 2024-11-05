import 'package:doktor_randevu/core/util/global_functions.dart';
import 'package:doktor_randevu/core/util/local_storage.dart';
import 'package:doktor_randevu/core/widgets/custom_app_bar.dart';
import 'package:doktor_randevu/core/widgets/loading_widget.dart';
import 'package:doktor_randevu/feature/login/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constant/assets.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/network/urls.dart';
import '../../../../core/util/style.dart';
import '../../../../core/widgets/page_status.dart';
import '../../../booking/data/models/provider_model.dart';
import '../../../login/presentation/bloc/bloc.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = '/service';

  const SettingScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final Style _style = sl<Style>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: CustomAppBar(
          title: Text(
            AppLocalizations.of(context)!.profileTitle,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'PublicSans',
              fontWeight: FontWeight.bold,
              color: _style.color(
                color: 'secondary_grey_color',
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: BlocProvider<LoginBloc>(
            create: (context) => sl<LoginBloc>()..add(GetProviderEvent()),
            child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
              if (state.pageStatus is DataLoaded) {
                ProviderModel? providerModel = state.providerModel;
                if (providerModel == null) {
                  return const SizedBox.shrink();
                }
                return Container(
                  color: _style.color(color: 'light_grey'),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          AppLocalizations.of(context)!.profilePhoto.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'PublicSans',
                            color: _style.color(color: 'secondary_text_color'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            const Divider(height: 1, thickness: 1),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: _style.color(color: 'list_tile_stroke'), width: .7),
                              ),
                              child: providerModel.picture != null
                                  ? ClipOval(
                                      child: Image.network(
                                        Urls.baseUrl + providerModel.picturePreview,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipOval(
                                      child: SvgPicture.asset(
                                        Assets.profile,
                                        fit: BoxFit.scaleDown,
                                        colorFilter: ColorFilter.mode(
                                          _style.color(color: 'circle_avatar_color'),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              providerModel.name,
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'PublicSans',
                                color: _style.color(color: 'main_text_color'),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              providerModel.phone,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'PublicSans',
                                color: _style.color(color: 'main_color'),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Divider(height: 1, thickness: 1),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const Divider(height: 1, thickness: 1),
                      InkWell(
                        onTap: () {
                          GlobalFunctions.instance.showAlertDialog(
                            title: AppLocalizations.of(context)!.logoutAlertTitle,
                            description: AppLocalizations.of(context)!.logoutAlertDescription,
                            buttonBackground: _style.color(color: 'main_color'),
                            context: context,
                            onFirstButtonPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                                    (route) => false,
                              );
                              LocalStorage.removeToken();
                            },
                            onSecondButtonPressed: () {
                              Navigator.of(context).pop();
                            },
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context)!.logout,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'PublicSans',
                                color: _style.color(color: 'red'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(height: 1, thickness: 1),
                    ],
                  ),
                );
              } else if (state.pageStatus is Initial || state.pageStatus is DataLoading) {
                return const LoadingWidget();
              } else {
                return const SizedBox.shrink();
              }
            }),
          ),
        ));
  }
}
