

import 'package:doktor_randevu/feature/booking/domain/entities/provider_entity.dart';
import 'package:doktor_randevu/feature/client/domain/entities/client_entity.dart';

import '../../../service/domain/entities/service_entity.dart';

class DatamEntity {
  ProviderEntity provider;
  ServiceEntity service;
  ClientEntity? client;
  String status;
  dynamic membershipId;
  dynamic invoiceId;
  dynamic invoiceStatus;
  bool? invoicePaymentReceived;
  dynamic invoiceNumber;
  dynamic invoiceDatetime;
  dynamic invoicePaymentProcessor;
  dynamic ticketCode;
  dynamic ticketValidationDatetime;
  dynamic ticketIsUsed;
  dynamic testingStatus;
  dynamic userStatusId;
  dynamic categoryId;
  dynamic locationId;
  dynamic category;
  dynamic location;
  bool? canBeEdited;
  bool? canBeCanceled;
  int? id;
  String? code;
  String startDatetime;
  String endDatetime;
  int? serviceId;
  int? providerId;
  int? clientId;
  int? duration;

  DatamEntity({
    required this.provider,
    required this.service,
    required this.client,
    required this.status,
    required this.membershipId,
    required this.invoiceId,
    required this.invoiceStatus,
    required this.invoicePaymentReceived,
    required this.invoiceNumber,
    required this.invoiceDatetime,
    required this.invoicePaymentProcessor,
    required this.ticketCode,
    required this.ticketValidationDatetime,
    required this.ticketIsUsed,
    required this.testingStatus,
    required this.userStatusId,
    required this.categoryId,
    required this.locationId,
    required this.category,
    required this.location,
    required this.canBeEdited,
    required this.canBeCanceled,
    required this.id,
    required this.code,
    required this.startDatetime,
    required this.endDatetime,
    required this.serviceId,
    required this.providerId,
    required this.clientId,
    required this.duration,
  });
}