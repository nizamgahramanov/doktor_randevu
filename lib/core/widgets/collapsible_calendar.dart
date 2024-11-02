
import 'package:doktor_randevu/core/constant/locale.dart';
import 'package:doktor_randevu/core/util/style.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../di/injection.dart';

class CollapsibleCalendar extends StatefulWidget {
  final DateTime? focusedDay;
  final DateTime? selectedDay;
  final bool isExpanded;
  final bool chevronVisible;
  final bool showBackButton;
  final Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final VoidCallback onHeaderTap;

  CollapsibleCalendar({
    required this.focusedDay,
    required this.isExpanded,
    required this.onDaySelected,
    required this.onHeaderTap,
    this.chevronVisible = false,
    this.showBackButton = false,
    this.selectedDay,
  });
  @override
  _CollapsibleCalendarState createState() => _CollapsibleCalendarState();
}

class _CollapsibleCalendarState extends State<CollapsibleCalendar> {
  @override
  Widget build(BuildContext context) {
    // BookingBloc bookingBloc = context.read<BookingBloc>();
    final Style _style = sl<Style>();
    return Column(
      children: [
        AnimatedSize(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: TableCalendar(
            headerVisible: true,
            locale: 'az',
            currentDay: DateTime.now(),
            focusedDay: widget.focusedDay ?? DateTime.now(),
            startingDayOfWeek: StartingDayOfWeek.monday,
            availableGestures: AvailableGestures.all,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Ay',
              CalendarFormat.week: 'Hefte',
            },
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            calendarFormat: widget.isExpanded ? CalendarFormat.month : CalendarFormat.week,
            selectedDayPredicate: (day) {
              return isSameDay(widget.focusedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              widget.onDaySelected(selectedDay, focusedDay);
            },
            calendarBuilders: CalendarBuilders(
              headerTitleBuilder: (context, day) {
                String monthName = azMonthNames[day.month] ?? 'Unknown';
                return InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: widget.onHeaderTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (widget.showBackButton)
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 0, right: 24, bottom: 0),
                            child: Container(
                              // color:Colors.red,
                              padding:EdgeInsets.all(8),
                              decoration:BoxDecoration(color: _style.color(color: 'list_tile_stroke'),
                              shape: BoxShape.circle),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 18,
                                color: _style.color(color: 'secondary_grey_color'),
                              ),
                            ),
                          ),
                        ),
                      Text(
                        monthName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PublicSans',
                          color: _style.color(color: 'secondary_grey_color'),
                        ),
                      ),
                      Icon(
                        widget.isExpanded ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
                        color: _style.color(color: 'secondary_grey_color'),
                      ),
                    ],
                  ),
                );
              },
            ),
            headerStyle: HeaderStyle(
              headerPadding: EdgeInsets.symmetric(vertical: 16),
              titleCentered: true,
              leftChevronVisible: widget.chevronVisible,
              rightChevronVisible: widget.chevronVisible,
              formatButtonVisible: false,
              formatButtonDecoration: BoxDecoration(),
              formatButtonTextStyle: TextStyle(),
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: _style.color(color: 'deActive_indicator'),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: _style.color(color: 'main_color'),
                shape: BoxShape.circle,
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
