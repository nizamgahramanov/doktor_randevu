import 'package:doktor_randevu/core/util/local_storage.dart';
import 'package:doktor_randevu/core/widgets/custom_app_bar.dart';
import 'package:doktor_randevu/core/widgets/refresh_widget.dart';
import 'package:doktor_randevu/feature/booking/data/models/conclusion.dart';
import 'package:doktor_randevu/feature/booking/data/models/main_model.dart';
import 'package:doktor_randevu/feature/service/data/models/service_model.dart';
import 'package:doktor_randevu/feature/service/presentation/bloc/bloc.dart';
import 'package:doktor_randevu/feature/service/presentation/widgets/service_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/util/screens.dart';
import '../../../../core/util/style.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/page_status.dart';

class ServiceScreen extends StatefulWidget {
  static const routeName = '/service';

  const ServiceScreen({Key? key, required this.conclusion}) : super(key: key);
  final Conclusion conclusion;
  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final Style _style = sl<Style>();
  final serviceBloc = sl<ServiceBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: CustomAppBar(
        title: Text(
          AppLocalizations.of(context)!.complain,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'PublicSans',
            fontWeight: FontWeight.bold,
            color: _style.color(
              color: 'secondary_grey_color',
            ),
          ),
        ),
        // title: AppLocalizations.of(context)!.complain,
        showBackButton: true,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => serviceBloc..add(LoadServiceEvent()),
          child: BlocBuilder<ServiceBloc, ServiceState>(builder: (context, state) {
            if (state.pageStatus is Initial || state.pageStatus is DataLoading) {
              return const LoadingWidget();
            }
            if (state.pageStatus is DataLoaded) {
              switch (state.apiResponse!.status) {
                case ApiResult.Success:
                  if (state.apiResponse != null && state.apiResponse!.data is MainModel) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: (state.apiResponse!.data as MainModel).data.length,
                            itemBuilder: (context, bookingIndex) {
                              final service = (state.apiResponse!.data.data as List<ServiceModel>)[bookingIndex];
                              final isSelected = state.selectedServiceId == service.id; // Check if the service is selected
                              return ServiceItem(service: service, isSelected: isSelected);
                            },
                          ),
                        ),
                        CustomElevatedButton(
                          buttonText: AppLocalizations.of(context)!.continueBtn,
                          backgroundColor: state.selectedServiceId != null ? _style.color(color: 'main_color') : _style.color(color: 'deActive_indicator'),
                          onPressed: state.selectedServiceId != null
                              ? () async {
                                  final selectedService = (state.apiResponse!.data.data as List<ServiceModel>).firstWhere((service) => service.id == state.selectedServiceId);
                                  String? providerEmail = await LocalStorage.getProviderEmail();
                                  String? providerId = await LocalStorage.getProviderId();
                                  widget.conclusion.serviceId = state.selectedServiceId;
                                  widget.conclusion.serviceName = selectedService.name;
                                  widget.conclusion.serviceDuration = selectedService.duration.toString();
                                  widget.conclusion.providerEmail = providerEmail;
                                  widget.conclusion.providerId = providerId != null ? int.tryParse(providerId) : null;
                                  Navigator.pushNamed(
                                    context,
                                    Screens.slot,
                                    arguments: widget.conclusion,
                                  );
                                }
                              : null,
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          borderRadius: 8,
                        )
                      ],
                    );
                  } else {
                    return RefreshWidget(onPressed: () {});
                  }
                case ApiResult.Error:
                  return RefreshWidget(
                    onPressed: () => context.read<ServiceBloc>()
                      ..add(
                        LoadServiceEvent(),
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
    );
  }
}
