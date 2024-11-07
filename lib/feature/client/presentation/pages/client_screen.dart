import 'package:doktor_randevu/core/constant/assets.dart';
import 'package:doktor_randevu/core/network/api_response.dart';
import 'package:doktor_randevu/core/network/error_response.dart';
import 'package:doktor_randevu/core/util/global_functions.dart';
import 'package:doktor_randevu/core/util/local_storage.dart';
import 'package:doktor_randevu/core/util/screens.dart';
import 'package:doktor_randevu/core/widgets/custom_app_bar.dart';
import 'package:doktor_randevu/core/widgets/custom_elevated_button.dart';
import 'package:doktor_randevu/core/widgets/loading_widget.dart';
import 'package:doktor_randevu/core/widgets/page_status.dart';
import 'package:doktor_randevu/core/widgets/refresh_widget.dart';
import 'package:doktor_randevu/feature/booking/data/models/conclusion.dart';
import 'package:doktor_randevu/feature/client/data/models/client_model.dart';
import 'package:doktor_randevu/feature/client/presentation/bloc/bloc.dart';
import 'package:doktor_randevu/feature/client/presentation/widgets/client_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/util/style.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../booking/data/models/main_model.dart';

class ClientScreen extends StatefulWidget {
  static const routeName = '/client';

  const ClientScreen({
    Key? key,
    this.conclusion,
    this.showArrowButton = true,
    this.showContinueButton = true,
  }) : super(key: key);
  final Conclusion? conclusion;
  final bool showArrowButton;
  final bool showContinueButton;
  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final Style _style = sl<Style>();
  final clientBloc = sl<ClientBloc>();

  @override
  Widget build(BuildContext context) {
    print("Build method called ");
    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: Text(
            AppLocalizations.of(context)!.patient,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'PublicSans',
              fontWeight: FontWeight.bold,
              color: _style.color(
                color: 'secondary_grey_color',
              ),
            ),
          ),
          // title: AppLocalizations.of(context)!.patients,
          showBackButton: widget.showArrowButton,
          actionButton: [
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => _openCreateClientModal(context),
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _style.color(color: 'main_color'),
                  ),
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocProvider(
            create: (context) => clientBloc..add(LoadClientEvent()),
            child: BlocListener<ClientBloc, ClientState>(
              listener: (context, state) {
                if (state.pageStatus is DataLoaded && state.apiResponse!.status == ApiResult.Error && state.apiResponse!.data is ErrorResponse) {
                  final errorResponse = state.apiResponse!.data as ErrorResponse;
                  if (errorResponse.code == 419) {
                    Navigator.of(context).pushReplacementNamed(Screens.login);
                  }
                }
              },
              child: BlocBuilder<ClientBloc, ClientState>(builder: (context, state) {
                print(state.pageStatus);
                print("BlocBuilder");
                if (state.pageStatus is Initial || state.pageStatus is DataLoading) {
                  return const LoadingWidget();
                }
                if (state.pageStatus is DataLoaded) {
                  switch (state.apiResponse!.status) {
                    case ApiResult.Success:
                      if (state.apiResponse != null && state.apiResponse!.data is MainModel && (state.apiResponse!.data as MainModel).data.isNotEmpty) {
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                itemCount: (state.apiResponse!.data as MainModel).data.length,
                                itemBuilder: (context, bookingIndex) {
                                  final client = (state.apiResponse!.data.data as List<ClientModel>)[bookingIndex];
                                  final isSelected = state.selectedClientId == client.id;
                                  return ClientItem(client: client, isSelected: isSelected);
                                },
                              ),
                            ),
                            widget.showContinueButton? CustomElevatedButton(
                              buttonText: AppLocalizations.of(context)!.continueBtn,
                              backgroundColor: state.selectedClientId != null ? _style.color(color: 'main_color') : _style.color(color: 'deActive_indicator'),
                              showDivider: false,
                              onPressed: state.selectedClientId != null
                                  ? () {
                                      final selectedClient = (state.apiResponse!.data.data as List<ClientModel>).firstWhere((client) => client.id == state.selectedClientId);
                                      widget.conclusion!.clientName = selectedClient.name;
                                      widget.conclusion!.clientPhone = selectedClient.phone;
                                      widget.conclusion!.patientNote = selectedClient.address1;
                                      widget.conclusion!.clientId = selectedClient.id;
                                      Navigator.pushNamed(context, Screens.conclusion, arguments: widget.conclusion);
                                    }
                                  : () {},
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              borderRadius: 8,
                            ):const SizedBox.shrink()
                          ],
                        );
                      } else {
                        return _buildNoClient();
                      }
                    case ApiResult.Error:
                      return RefreshWidget(
                        onPressed: () => context.read<ClientBloc>()
                          ..add(
                            LoadClientEvent(),
                          ),
                      );
                    default:
                      return const LoadingWidget();
                  }
                } else {
                  return const LoadingWidget();
                }
              }),
            ),
          ),
        ),
      );
  }

  void _openCreateClientModal(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController surnameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController noteController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BlocProvider.value(
            value: clientBloc,
            child: BlocListener<ClientBloc, ClientState>(
              listener: (context, state) {
                if (state.createdClientModel!=null) {
                  GlobalFunctions.instance.showCloseDialog(
                      title: AppLocalizations.of(context)!.patientCreated,
                      description: state.createdClientModel!.name,
                      svgPath: Assets.checkMark,
                      buttonBackground: _style.color(color: 'main_color'),
                      context: context,
                      onButtonPressed: () {
                        print("onButtonPressed");
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        clientBloc.add(LoadClientEvent());
                      });
                } else if (state.createdClientModel==null) {
                  GlobalFunctions.instance.showCloseDialog(
                      title: AppLocalizations.of(context)!.failure,
                      svgPath: Assets.checkMark,
                      buttonBackground: _style.color(color: 'main_color'),
                      context: context,
                      onButtonPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      });
                } else if (state.pageStatus is DataSubmitting) {
                  const Center(
                    child: LoadingWidget(),
                  );
                }
              },
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: _style.color(color: 'circle_avatar_color'),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.newClient,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.bold,
                                color: _style.color(color: 'main_text_color'),
                              ),
                            ),
                            InkWell(
                              child: SvgPicture.asset(Assets.close),
                              onTap: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.name.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'PublicSans',
                                      color: _style.color(color: 'secondary_text_color'),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  CustomTextFormField(
                                    controller: nameController,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (String value) {},
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context)!.nameRequired;
                                      } else if (value.length < 3) {
                                        return AppLocalizations.of(context)!.nameCharacterLong;
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.surname.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'PublicSans',
                                      color: _style.color(color: 'secondary_text_color'),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  CustomTextFormField(
                                    controller: surnameController,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (String value) {},
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context)!.surnameRequired;
                                      } else if (value.length < 3) {
                                        return AppLocalizations.of(context)!.surnameCharacterLong;
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.phoneNumber.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'PublicSans',
                                color: _style.color(color: 'secondary_text_color'),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            CustomTextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String value) {},
                              hintText: "${AppLocalizations.of(context)!.example}: 0501112233" ,
                              validator: (value) {
                                final RegExp phoneRegExp = RegExp(r'^(050|051|055|070|077|099|010)\d{7}$');                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!.phoneRequired;
                                } else if (!phoneRegExp.hasMatch(value)) {
                                  return AppLocalizations.of(context)!.phoneCharacterValidation;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.patientNote.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'PublicSans',
                                color: _style.color(color: 'secondary_text_color'),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            CustomTextFormField(
                              controller: noteController,
                              maxLines: 4,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String value) {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomElevatedButton(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        buttonText: AppLocalizations.of(context)!.create,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String? providerEmail = await LocalStorage.getProviderEmail();
                            ClientModel newClient = ClientModel(
                              name: '${nameController.text.trim()} ${surnameController.text.trim()}',
                              phone: phoneController.text.trim(),
                              email: providerEmail!.trim(),
                              address1: noteController.text.trim(),
                            );
                            clientBloc.add(CreateClientEvent(newClientModel: newClient));
                          }
                        },
                        backgroundColor: _style.color(color: 'main_color'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNoClient() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Divider(
          height: 1,
          color: _style.color(color: 'list_tile_stroke'),
        ),
        Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              AppLocalizations.of(context)!.noClient,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: 'PublicSans',
                color: _style.color(
                  color: 'grey_text_color',
                ),
              ),
            )),
        Divider(
          height: 1,
          color: _style.color(color: 'list_tile_stroke'),
        ),
      ],
    );
  }
}
