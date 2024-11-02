import 'package:doktor_randevu/core/constant/assets.dart';
import 'package:doktor_randevu/core/di/injection.dart';
import 'package:doktor_randevu/core/network/api_response.dart';
import 'package:doktor_randevu/core/network/error_response.dart';
import 'package:doktor_randevu/core/network/urls.dart';
import 'package:doktor_randevu/core/util/style.dart';
import 'package:doktor_randevu/core/widgets/custom_app_bar.dart';
import 'package:doktor_randevu/core/widgets/loading_widget.dart';
import 'package:doktor_randevu/core/widgets/page_status.dart';
import 'package:doktor_randevu/core/widgets/refresh_widget.dart';
import 'package:doktor_randevu/feature/booking/data/models/booking_date_info.dart';
import 'package:doktor_randevu/feature/booking/data/models/booking_info.dart';
import 'package:doktor_randevu/feature/booking/data/models/main_model.dart';
import 'package:doktor_randevu/feature/booking/data/models/provider_model.dart';
import 'package:doktor_randevu/feature/booking/presentation/bloc/bloc.dart';
import 'package:doktor_randevu/feature/login/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/util/screens.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/login';

  const DashboardScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Style _style = sl<Style>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: CustomAppBar(
        title: BlocProvider<LoginBloc>(
          create: (context) => sl<LoginBloc>()..add(GetProviderEvent()),
          child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            if (state.pageStatus is DataLoaded) {
              ProviderModel? providerModel = state.providerModel;

              if (providerModel == null) {
                return const SizedBox.shrink();
              }
              return Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
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
                              Assets.profile, // Your SVG asset
                              fit: BoxFit.scaleDown,
                              colorFilter: ColorFilter.mode(
                                _style.color(color: 'circle_avatar_color'),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.welcome,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'PublicSans',
                          color: _style.color(
                            color: 'grey_text_color',
                          ),
                        ),
                      ),
                      Text(
                        providerModel.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.bold,
                          color: _style.color(
                            color: 'main_text_color',
                          ),
                          height: 1.32,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ),
      ),
      body: BlocProvider(
        create: (context) => sl<BookingBloc>()..add(LoadBookingEvent(upcomingOnly: true)),
        child: BlocListener<BookingBloc, BookingState>(
          listener: (context, state) {
            if (state.pageStatus is DataLoaded && state.apiResponse!.status == ApiResult.Error && state.apiResponse!.data is ErrorResponse) {
              final errorResponse = state.apiResponse!.data as ErrorResponse;
              if (errorResponse.code == 419) {
                Navigator.of(context).pushReplacementNamed(Screens.login);
              }
            }
          },
          child: BlocBuilder<BookingBloc, BookingState>(builder: (context, state) {
            return SafeArea(
              child: _buildUI(state),
            );
          }),
        ),
      ),
    );
  }

  _buildUI(BookingState state) {
    if (state.pageStatus is Initial || state.pageStatus is DataLoading) {
      return const LoadingWidget();
    }
    if (state.pageStatus is DataLoaded) {
      switch (state.apiResponse!.status) {
        case ApiResult.Success:
          if (state.apiResponse != null && state.apiResponse!.data is MainModel && state.processedBookingList.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    AppLocalizations.of(context)!.nextMeetings,
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'PublicSans',
                      color: _style.color(
                        color: 'main_text_color',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.processedBookingList.length,
                    itemBuilder: (context, bookingIndex) {
                      BookingDateInfo bookingDateInfo = state.processedBookingList[bookingIndex].bookingDateInfo;
                      List<BookingInfo> bookingInfo = state.processedBookingList[bookingIndex].bookingInfo;
                      return Column(
                        children: [_buildItem(bookingInfo)],
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return _buildNoBooking();
          }
        case ApiResult.Error:
          return RefreshWidget(
            onPressed: () => context.read<BookingBloc>().add(
                  LoadBookingEvent(upcomingOnly: true),
                ),
          );
        default:
          return const LoadingWidget();
      }
    } else {
      return const LoadingWidget();
    }
  }

  Widget _buildNoBooking() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            height: 1,
            color: _style.color(color: 'list_tile_stroke'),
          ),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                AppLocalizations.of(context)!.noBooking,
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
      ),
    );
  }

  _buildItem(List<BookingInfo> bookingInfoList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: bookingInfoList.asMap().entries.map((entry) {
        int index = entry.key;
        BookingInfo bookingInfo = entry.value;
        String initials = bookingInfo.clientName!.isNotEmpty ? bookingInfo.clientName!.split(' ').map((e) => e[0].toUpperCase()).take(2).join() : '';

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _style.color(color: 'list_tile_bg'),
                  shape: BoxShape.rectangle,
                  border: Border.all(color: _style.color(color: 'list_tile_stroke'), width: .5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: _style.color(color: 'circle_avatar_color'),
                          child: Text(
                            initials,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'PublicSans',
                              color: _style.color(color: 'white'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bookingInfo.clientName!,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.bold,
                                  color: _style.color(color: 'main_text_color'),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${bookingInfo.serviceName} - ${bookingInfo.serviceDuration} ${AppLocalizations.of(context)!.minute}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _style.color(color: 'main_color'),
                                  fontFamily: 'PublicSans',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.dateAndTime.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'PublicSans',
                          color: _style.color(
                            color: 'grey_text_color',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _style.color(color: 'main_grey_color'),
                              borderRadius: const BorderRadius.all(Radius.circular(4)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(Assets.dashboardMeeting),
                                const SizedBox(
                                  width: 8,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    bookingInfo.date,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'PublicSans',
                                      color: _style.color(
                                        color: 'secondary_grey_color',
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _style.color(color: 'main_grey_color'),
                              borderRadius: const BorderRadius.all(Radius.circular(4)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(Assets.dashboardTime),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '${bookingInfo.timeStart} - ${bookingInfo.timeEnd}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'PublicSans',
                                    color: _style.color(
                                      color: 'secondary_grey_color',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
