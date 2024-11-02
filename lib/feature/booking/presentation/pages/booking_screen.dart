
import 'package:doktor_randevu/core/constant/assets.dart';
import 'package:doktor_randevu/core/network/error_response.dart';
import 'package:doktor_randevu/core/util/screens.dart';
import 'package:doktor_randevu/core/widgets/collapsible_calendar.dart';
import 'package:doktor_randevu/core/widgets/connectivity_aware_display.dart';
import 'package:doktor_randevu/core/widgets/no_connectivity_indicator.dart';
import 'package:doktor_randevu/feature/booking/data/models/booking_date_info.dart';
import 'package:doktor_randevu/feature/booking/data/models/booking_info.dart';
import 'package:doktor_randevu/feature/booking/data/models/conclusion.dart';
import 'package:doktor_randevu/feature/booking/data/models/main_model.dart';
import 'package:doktor_randevu/feature/booking/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/util/style.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/page_status.dart';
import '../../../../core/widgets/refresh_widget.dart';

class BookingScreen extends StatefulWidget {
  static const routeName = '/booking';

  const BookingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final Style _style = sl<Style>();
  final bookingBloc = sl<BookingBloc>();

  @override
  Widget build(BuildContext context) {
    return ConnectivityAwareDisplay(
      whenNotConnected: NoConnectivityIndicator(),
      whenConnected: Scaffold(
        extendBody: true,
        body: SafeArea(
          child: BlocProvider(
            create: (context) => bookingBloc..add(LoadBookingEvent(upcomingOnly: true)),

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
                return Column(
                  children: [
                    CollapsibleCalendar(
                      focusedDay: state.focusedDay,
                      isExpanded: state.isExpanded,
                      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                        bookingBloc.add(DaySelectedEvent(selectedDay: selectedDay, focusedDay: focusedDay));
                      },
                      chevronVisible: true,
                      onHeaderTap: () {
                        bookingBloc.add(ToggleCalendarEvent(isExpanded: !bookingBloc.state.isExpanded));
                      },
                    ),
                    Expanded(
                      child: _buildBookingList(state),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookingList(BookingState state) {
    if (state.pageStatus is Initial || state.pageStatus is DataLoading) {
      return const LoadingWidget();
    }
    if (state.pageStatus is DataLoaded) {
      switch (state.apiResponse!.status) {
        case ApiResult.Success:
          if (state.apiResponse != null && state.apiResponse!.data is MainModel && (state.apiResponse!.data as MainModel).data.isNotEmpty) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.processedBookingList.length,
              itemBuilder: (context, bookingIndex) {
                BookingDateInfo bookingDateInfo = state.processedBookingList[bookingIndex].bookingDateInfo;
                List<BookingInfo> bookingInfo = state.processedBookingList[bookingIndex].bookingInfo;
                return Column(
                  children: [
                    _buildHeader(bookingDateInfo),
                    _buildDetail(bookingInfo),
                  ],
                );
              },
            );
          } else {
            return _buildNoBooking();
          }
        case ApiResult.Error:
          return RefreshWidget(
            onPressed: () => bookingBloc.add(
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

  Widget _buildHeader(BookingDateInfo bookingDateInfo) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: _style.color(color: 'main_grey_color'),
        border: Border.symmetric(horizontal: BorderSide(color: _style.color(color: 'list_tile_stroke'))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(bookingDateInfo.rowDate),
          const SizedBox(),
        ],
      ),
    );
  }

  Widget _buildDetail(List<BookingInfo> bookingInfoList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: bookingInfoList.asMap().entries.map((entry) {
        int index = entry.key;
        BookingInfo bookingInfo = entry.value;

        return InkWell(
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.pushNamed(context, Screens.conclusion,
                arguments: Conclusion(
                  clientName: bookingInfo.clientName,
                  clientPhone: bookingInfo.clientPhone,
                  serviceName: bookingInfo.serviceName,
                  serviceDuration: bookingInfo.serviceDuration,
                  patientNote: bookingInfo.clientNote,
                  startTime: bookingInfo.timeStart,
                  endTime: bookingInfo.timeEnd,
                  date: bookingInfo.date,
                  title: AppLocalizations.of(context)!.bookInfo,
                  isBookInfo: true
                ));
          },
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bookingInfo.timeStart,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'PublicSans',
                            color: _style.color(color: 'secondary_grey_color'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        bookingInfo.status == "confirmed"
                            ? SvgPicture.asset(Assets.bookingConfirmed)
                            : bookingInfo.status == "pending"
                                ? SvgPicture.asset(Assets.bookingPending)
                                : SvgPicture.asset(Assets.bookingCanceled),
                      ],
                    ),
                    const SizedBox(width: 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bookingInfo.clientName != null
                            ? Text(
                                bookingInfo.clientName!,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'PublicSans', color: _style.color(color: 'secondary_grey_color')),
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: _style.color(color: 'main_color'),
                            borderRadius: const BorderRadius.all(Radius.circular(4)),
                          ),
                          child: Text(
                            "${bookingInfo.serviceName} - ${bookingInfo.serviceDuration} dəq",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: 'PublicSans',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (index < bookingInfoList.length - 1)
                Divider(
                  color: _style.color(color: 'list_tile_stroke'),
                  thickness: 1.0,
                  height: 1.0,
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNoBooking() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}
