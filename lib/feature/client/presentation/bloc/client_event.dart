part of 'bloc.dart';

abstract class ClientEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadClientEvent extends ClientEvent {}

class ClientSelectedEvent extends ClientEvent {
  final int clientId;

  ClientSelectedEvent({required this.clientId});
}

class CreateClientEvent extends ClientEvent {
  final ClientModel newClientModel;

  CreateClientEvent({required this.newClientModel});
}
