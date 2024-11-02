import 'package:doktor_randevu/core/util/connectivity_service.dart';
import 'package:doktor_randevu/core/util/style.dart';
import 'package:doktor_randevu/feature/booking/domain/usecases/create_booking.dart';
import 'package:doktor_randevu/feature/booking/domain/usecases/send_push_notification.dart';
import 'package:doktor_randevu/feature/client/data/datasources/client_remote_data_source.dart';
import 'package:doktor_randevu/feature/client/data/repositories/client_repository_impl.dart';
import 'package:doktor_randevu/feature/client/domain/repositories/client_repository.dart';
import 'package:doktor_randevu/feature/client/domain/usecases/client_creating.dart';
import 'package:doktor_randevu/feature/client/domain/usecases/client_fetching.dart';
import 'package:doktor_randevu/feature/client/presentation/bloc/bloc.dart';
import 'package:doktor_randevu/feature/login/data/datasources/login_remote_data_source.dart';
import 'package:doktor_randevu/feature/login/data/repositories/login_repository_impl.dart';
import 'package:doktor_randevu/feature/login/domain/repositories/login_repository.dart';
import 'package:doktor_randevu/feature/login/domain/usecases/provider_fetching.dart';
import 'package:doktor_randevu/feature/login/domain/usecases/token_fetching.dart';
import 'package:doktor_randevu/feature/login/presentation/bloc/bloc.dart';
import 'package:doktor_randevu/feature/service/data/datasources/service_remote_data_source.dart';
import 'package:doktor_randevu/feature/service/data/repositories/service_repository_impl.dart';
import 'package:doktor_randevu/feature/service/domain/repositories/service_repository.dart';
import 'package:doktor_randevu/feature/service/domain/usecases/load_service.dart';
import 'package:doktor_randevu/feature/service/presentation/bloc/bloc.dart';
import 'package:doktor_randevu/feature/slot/data/datasources/slot_remote_data_source.dart';
import 'package:doktor_randevu/feature/slot/data/repositories/slot_repository_impl.dart';
import 'package:doktor_randevu/feature/slot/domain/repositories/slot_repository.dart';
import 'package:doktor_randevu/feature/slot/domain/usecases/load_slot.dart';
import 'package:doktor_randevu/feature/slot/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../feature/booking/data/datasources/booking_remote_data_source.dart';
import '../../feature/booking/data/repositories/booking_repository_impl.dart';
import '../../feature/booking/domain/repositories/booking_repository.dart';
import '../../feature/booking/domain/usecases/load_booking.dart';
import '../../feature/booking/presentation/bloc/bloc.dart';
import '../network/api_client.dart';

final sl = GetIt.instance;
final navigatorKey = GlobalKey<NavigatorState>();
final ctx = navigatorKey.currentContext;
Future<void> init() async {
  //! Features - Login
  sl.registerFactory(
    () => BookingBloc(
      loadBooking: sl(),
      bookCreating: sl(),
      sendPushNotification: sl(),
    ),
  );
  // * Usecase
  sl.registerLazySingleton(
    () => LoadBooking(bookingRepository: sl()),
  );

  sl.registerLazySingleton(
    () => CreateBooking(bookingRepository: sl()),
  );

  sl.registerLazySingleton(
    () => SendPushNotification(bookingRepository: sl()),
  );
  // * Repository
  sl.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(bookingRemoteDataSource: sl()),
  );
  // * Data sources
  sl.registerLazySingleton<BookingRemoteDataSource>(() => BookingRemoteDataSourceImpl());

  //! Features - Service
  sl.registerFactory(
    () => ServiceBloc(loadService: sl()),
  );
  // * Usecase
  sl.registerLazySingleton(
    () => LoadService(serviceRepository: sl()),
  );
  // * Repository
  sl.registerLazySingleton<ServiceRepository>(
    () => ServiceRepositoryImpl(serviceRemoteDataSource: sl()),
  );
  // * Data sources
  sl.registerLazySingleton<ServiceRemoteDataSource>(() => ServiceRemoteDataSourceImpl());

  //! Features - Service
  sl.registerFactory(
    () => SlotBloc(loadSlot: sl()),
  );
  // * Usecase
  sl.registerLazySingleton(
    () => LoadSlot(slotRepository: sl()),
  );
  // * Repository
  sl.registerLazySingleton<SlotRepository>(
    () => SlotRepositoryImpl(slotRemoteDataSource: sl()),
  );
  // * Data sources
  sl.registerLazySingleton<SlotRemoteDataSource>(() => SlotRemoteDataSourceImpl());

  //! Features - Client
  sl.registerFactory(
    () => ClientBloc(clientFetching: sl(), clientCreating: sl()),
  );
  // * Usecase
  sl.registerLazySingleton(
    () => ClientFetching(clientRepository: sl()),
  );
  // * Usecase
  sl.registerLazySingleton(
    () => ClientCreating(clientRepository: sl()),
  );
  // * Repository
  sl.registerLazySingleton<ClientRepository>(
    () => ClientRepositoryImpl(clientRemoteDataSource: sl()),
  );
  // * Data sources
  sl.registerLazySingleton<ClientRemoteDataSource>(() => ClientRemoteDataSourceImpl());

  //! Features - Login
  sl.registerFactory(
    () => LoginBloc(tokenFetching: sl(), providerFetching: sl()),
  );
  // * Usecase
  sl.registerLazySingleton(
    () => TokenFetching(loginRepository: sl()),
  );
  sl.registerLazySingleton(
    () => ProviderFetching(loginRepository: sl()),
  );
  // * Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(loginRemoteDataSource: sl()),
  );
  sl.registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl());

  //! External
  sl.registerLazySingleton(() => ApiClient());
  sl.registerLazySingleton(() => Style());
  sl.registerLazySingleton(() => ConnectivityService());
}
