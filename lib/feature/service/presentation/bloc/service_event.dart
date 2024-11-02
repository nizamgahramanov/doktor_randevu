part of 'bloc.dart';

abstract class ServiceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadServiceEvent extends ServiceEvent {
  final String? chosenDate;

  LoadServiceEvent({this.chosenDate});
}

class ServiceSelectedEvent extends ServiceEvent {
  final int serviceId;

  ServiceSelectedEvent({required this.serviceId});
}
