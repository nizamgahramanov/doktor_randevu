part of 'bloc.dart';

class SlotBloc extends Bloc<SlotEvent, SlotState> {
  final LoadSlot loadSlot;

  SlotBloc({required this.loadSlot}) : super(SlotState()) {
    on<LoadSlotEvent>(_loadSlot);
    on<SlotSelectedEvent>(_slotSelected);
    on<ToggleCalendarEvent>(_toggleCalendar);
    on<DaySelectedEvent>(_daySelected);
  }

  Future<void> _loadSlot(LoadSlotEvent event, emit) async {
    try {
      final apiResponse = await loadSlot.call(SlotParams(
        serviceId: event.serviceId,
        chosenDate: event.chosenDate,
        providerId: event.providerId
      ));
      state.copyWith(
        pageStatus: DataLoading(),
      );
      apiResponse.fold(
        (failure) => emit(
          state.copyWith(
            pageStatus: DataLoadFailed(),
          ),
        ),
        (apiResponse) => emit(
          state.copyWith(
            pageStatus: DataLoaded(),
            apiResponse: apiResponse,
            groupedSlots: groupSlots(
              apiResponse.data as List<SlotModel>,
            ),
          ),
        ),
      );
    } on Error {
      print("ERROR in bloc");
    }
  }

  groupSlots(List<SlotModel> slots) {
    List<Map<String, dynamic>> sections = [];
    if (slots.isNotEmpty) {
      sections = [
        {
          'title': 'morning',
          'times': slots.where((slot) {
            final hour = int.parse(slot.time.split(':')[0]);
            return hour >= 9 && hour < 13;
          }).toList(),
        },
        {
          'title': 'afternoon',
          'times': slots.where((slot) {
            final hour = int.parse(slot.time.split(':')[0]);
            return hour >= 13 && hour <= 16;
          }).toList(),
        },
        {
          'title': 'evening',
          'times': slots.where((slot) {
            final hour = int.parse(slot.time.split(':')[0]);
            return hour >= 17 && hour < 21;
          }).toList(),
        },
      ];
    }
    return sections;
  }

  FutureOr<void> _slotSelected(SlotSelectedEvent event, emit) {
    emit(state.copyWith(
      selectedSlotId: event.slotId,

    ));
  }

  FutureOr<void> _toggleCalendar(ToggleCalendarEvent event, emit) {
    emit(state.copyWith(isExpanded: event.isExpanded));
  }

  FutureOr<void> _daySelected(DaySelectedEvent event, emit) async {
    emit(
      state.copyWith(
        selectedDay: event.selectedDay,
        focusedDay: event.focusedDay,
        pageStatus: DataLoading(),
        selectedSlotId: ''
      ),
    );
    await _loadSlot(LoadSlotEvent(chosenDate: DateFormat('yyyy-MM-dd').format(event.selectedDay), serviceId: event.serviceId, providerId: event.providerId), emit);
  }
}
