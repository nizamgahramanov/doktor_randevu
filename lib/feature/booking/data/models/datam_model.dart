

import 'package:doktor_randevu/feature/service/data/models/service_model.dart';

import '../../../client/data/models/client_model.dart';
import '../../domain/entities/datam_entity.dart';
import 'provider_model.dart';

class DatamModel extends DatamEntity {
  DatamModel({
    super.id,
    required super.provider,
    required super.service,
    super.client,
    required super.status,
    super.membershipId,
    super.invoiceId,
    super.invoiceStatus,
    super.invoicePaymentReceived,
    super.invoiceNumber,
    super.invoiceDatetime,
    super.invoicePaymentProcessor,
    super.ticketCode,
    super.ticketValidationDatetime,
    super.ticketIsUsed,
    super.testingStatus,
    super.userStatusId,
    super.categoryId,
    super.locationId,
    super.category,
    super.location,
    super.canBeEdited,
    super.canBeCanceled,
    super.code,
    required super.startDatetime,
    required super.endDatetime,
    super.serviceId,
    super.providerId,
    super.clientId,
    required super.duration,
  });

  factory DatamModel.fromJson(Map<String, dynamic> json) {
    return DatamModel(
      provider: ProviderModel.fromJson(json['provider']),
      service: ServiceModel.fromJson(json['service']),
      client: json['client'] != null ? ClientModel.fromJson(json['client']) : null,
      status: json['status'],
      membershipId: json['membershipId'],
      invoiceId: json['invoiceId'],
      invoiceStatus: json['invoiceStatus'],
      invoicePaymentReceived: json['invoicePaymentReceived'],
      invoiceNumber: json['invoiceNumber'],
      invoiceDatetime: json['invoiceDatetime'],
      invoicePaymentProcessor: json['invoicePaymentProcessor'],
      ticketCode: json['ticketCode'],
      ticketValidationDatetime: json['ticketValidationDatetime'],
      ticketIsUsed: json['ticketIsUsed'],
      testingStatus: json['testingStatus'],
      userStatusId: json['userStatusId'],
      categoryId: json['categoryId'],
      locationId: json['locationId'],
      category: json['category'],
      location: json['location'],
      canBeEdited: json['can_be_edited'],
      canBeCanceled: json['can_be_canceled'],
      id: json['id'],
      code: json['code'],
      startDatetime: json['start_datetime'],
      endDatetime: json['end_datetime'],
      serviceId: json['service_id'],
      providerId: json['provider_id'],
      clientId: json['clientId'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'service': service,
      'client': client,
      'status': status,
      'membershipId': membershipId,
      'invoiceId': invoiceId,
      'invoiceStatus': invoiceStatus,
      'invoicePaymentReceived': invoicePaymentReceived,
      'invoiceNumber': invoiceNumber,
      'invoiceDatetime': invoiceDatetime,
      'invoicePaymentProcessor': invoicePaymentProcessor,
      'ticketCode': ticketCode,
      'ticketValidationDatetime': ticketValidationDatetime,
      'ticketIsUsed': ticketIsUsed,
      'testingStatus': testingStatus,
      'userStatusId': userStatusId,
      'categoryId': categoryId,
      'locationId': locationId,
      'category': category,
      'location': location,
      'canBeEdited': canBeEdited,
      'canBeCanceled': canBeCanceled,
      'id': id,
      'code': code,
      'startDatetime': startDatetime,
      'endDatetime': endDatetime,
      'serviceId': serviceId,
      'providerId': providerId,
      'clientId': clientId,
      'duration': duration,
    };
  }
}