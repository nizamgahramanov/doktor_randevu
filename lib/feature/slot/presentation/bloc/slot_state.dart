part of 'bloc.dart';

class SlotState {
  final PageStatus pageStatus;
  final ApiResponse? apiResponse;
  final List<Map<String, dynamic>>? groupedSlots;
  final String selectedSlotId;
  final bool isExpanded;
  final DateTime? selectedDay;
  final DateTime? focusedDay;

  SlotState({
    this.pageStatus = const Initial(),
    this.apiResponse,
    this.groupedSlots,
    this.selectedSlotId = '',
    this.isExpanded = false,
    this.selectedDay,
    this.focusedDay,
  });

  SlotState copyWith({
    PageStatus? pageStatus,
    ApiResponse? apiResponse,
    List<Map<String, dynamic>>? groupedSlots,
    String? selectedSlotId,
    bool? isExpanded,
    DateTime? selectedDay,
    DateTime? focusedDay,

  }) {
    return SlotState(
      pageStatus: pageStatus ?? this.pageStatus,
      apiResponse: apiResponse ?? this.apiResponse,
      groupedSlots: groupedSlots ?? this.groupedSlots,
      selectedSlotId: selectedSlotId ?? this.selectedSlotId,
      isExpanded: isExpanded ?? this.isExpanded,
      selectedDay: selectedDay ?? this.selectedDay,
      focusedDay: focusedDay ?? this.focusedDay,
    );
  }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;
  //   return other is SlotState && other.selectedSlotId == selectedSlotId;
  // }

  // @override
  // List<Object?> get props => [pageStatus, apiResponse, groupedSlots, selectedSlotId,isExpanded];
}
