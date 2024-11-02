import 'package:doktor_randevu/core/constant/assets.dart';
import 'package:doktor_randevu/core/widgets/collapsible_calendar.dart';
import 'package:doktor_randevu/core/widgets/custom_elevated_button.dart';
import 'package:doktor_randevu/core/widgets/loading_widget.dart';
import 'package:doktor_randevu/feature/booking/data/models/conclusion.dart';
import 'package:doktor_randevu/feature/slot/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/util/screens.dart';
import '../../../../core/util/style.dart';
import '../../../../core/widgets/page_status.dart';

class SlotScreen extends StatefulWidget {
  static const routeName = '/slot';

  const SlotScreen({Key? key, required this.conclusion}) : super(key: key);
  final Conclusion conclusion;

  @override
  State<SlotScreen> createState() => _SlotScreenState();
}

class _SlotScreenState extends State<SlotScreen> {
  final Style _style = sl<Style>();
  final slotBloc = sl<SlotBloc>();

  @override
  Widget build(BuildContext context) {
    final slotBloc = sl<SlotBloc>();
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          lazy: false,
          create: (context) => slotBloc
            ..add(
              LoadSlotEvent(
                serviceId: widget.conclusion.serviceId!,
                providerId: widget.conclusion.providerId!,
              ),
            ),
          child: BlocBuilder<SlotBloc, SlotState>(builder: (context, state) {
            return Column(
              children: [
                CollapsibleCalendar(
                  focusedDay: state.focusedDay,
                  isExpanded: state.isExpanded,
                  showBackButton: true,
                  onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                    slotBloc.add(
                      DaySelectedEvent(
                        selectedDay: selectedDay,
                        focusedDay: focusedDay,
                        serviceId: widget.conclusion.serviceId!,
                        providerId: widget.conclusion.providerId!,
                      ),
                    );
                  },
                  onHeaderTap: () {
                    slotBloc.add(ToggleCalendarEvent(isExpanded: !state.isExpanded));
                  },
                ),
                const Divider(height: 1),
                Expanded(
                  child: Stack(
                    children: [
                      if (state.groupedSlots?.isNotEmpty ?? false)
                        ListView.builder(
                          itemCount: state.groupedSlots!.length,
                          itemBuilder: (context, index) {
                            final section = state.groupedSlots![index];
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      getLocalizedTitle(context, section['title']),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'PublicSans',
                                        color: _style.color(color: 'secondary_text_color'),
                                      ),
                                    ),
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      childAspectRatio: 3,
                                    ),
                                    itemCount: section['times'].length,
                                    itemBuilder: (context, i) {
                                      final time = section['times'][i].time;
                                      return InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () => slotBloc.add(SlotSelectedEvent(slotId: section['times'][i].id)),
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: state.selectedSlotId == section['times'][i].id ? _style.color(color: 'main_color') : _style.color(color: 'main_grey_color'),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            time!.substring(0, 5),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'PublicSans',
                                              color: _style.color(
                                                color: state.selectedSlotId == section['times'][i].id ? 'white' : 'main_text_color',
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      else if (state.pageStatus is! DataLoading)
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Assets.noSlot),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                                child: Text(
                                  AppLocalizations.of(context)!.noSlotDescription,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'PublicSans',
                                    fontWeight: FontWeight.bold,
                                    color: _style.color(color: 'main_text_color'),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (state.pageStatus is DataLoading)
                        const Center(
                          child: LoadingWidget(),
                        ),
                    ],
                  ),
                ),
                CustomElevatedButton(
                  buttonText: AppLocalizations.of(context)!.continueBtn,
                  backgroundColor: _style.color(color: state.selectedSlotId != '' ? 'main_color' : 'deActive_indicator'),
                  onPressed: state.selectedSlotId != ''
                      ? () {
                          DateTime startDateTime = DateTime.parse(state.selectedSlotId);
                          String formattedDate = DateFormat('yyyy-MM-dd').format(startDateTime);
                          String startTime = DateFormat('HH:mm').format(startDateTime);
                          DateTime endDateTime = startDateTime.add(const Duration(hours: 1));
                          String endTime = DateFormat('HH:mm').format(endDateTime);
                          widget.conclusion.startDateTime = state.selectedSlotId;
                          widget.conclusion.startTime = startTime;
                          widget.conclusion.endTime = endTime;
                          widget.conclusion.date = formattedDate;
                          Navigator.pushNamed(context, Screens.client, arguments: widget.conclusion);
                        }
                      : null,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  borderRadius: 8,
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

String getLocalizedTitle(BuildContext context, String title) {
  switch (title) {
    case 'morning':
      return AppLocalizations.of(context)!.morning;
    case 'afternoon':
      return AppLocalizations.of(context)!.afternoon;
    case 'evening':
      return AppLocalizations.of(context)!.evening;
    default:
      return title;
  }
}
