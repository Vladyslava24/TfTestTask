//Todo repair tests after changes
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:bloc_test/bloc_test.dart';
// import 'package:core/core.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:totalfit/data/source/remote/remote_storage.dart';
// import 'package:totalfit/data/source/repository/explore_repository_impl.dart';
// import 'package:totalfit/domain/bloc/explore_bloc/explore_bloc.dart';
// import 'package:totalfit/exception/error_codes.dart';
// import 'package:totalfit/exception/tf_exception.dart';
// import 'package:totalfit/model/explore/explore_model.dart';
// import 'package:workout/workout_model.dart';
//
// class MockRemoteStorage extends Mock implements RemoteStorage {}
//
// class MockExploreRepositoryImpl extends Mock implements ExploreRepositoryImpl {}
//
// final testExploreModelInstance = ExploreModel(
//   exploreWODMonth: null,
//   exploreCollections: WorkoutCollectionResponse(
//     workoutCollections: []
//   )
// );
//
// final testApiExceptionInstance = ApiException(
//   serverErrorCode: 400,
//   serverErrorMessage: 'Bad request',
//   serverLogMessage: 'Something went wrong'
// );
//
// void main() {
//
//   ExploreBloc exploreBloc;
//   MockExploreRepositoryImpl exploreRepositoryImpl;
//   MockRemoteStorage mockRemoteStorage;
//
//   setUp(() {
//     mockRemoteStorage = MockRemoteStorage();
//     exploreRepositoryImpl = MockExploreRepositoryImpl();
//     exploreBloc = ExploreBloc(exploreRepository: exploreRepositoryImpl);
//   });
//
//   tearDown(() {
//     exploreBloc.close();
//   });
//
//   group('ExploreBloc tests', () {
//     blocTest(
//       'ExploreBloc emits [] when nothing is added',
//       build: () => ExploreBloc(),
//       expect: () => [],
//     );
//
//     blocTest(
//       'ExploreBloc emits [ExploreState] when ExploreFetch is added',
//       build: () => ExploreBloc(),
//       act: (bloc) => bloc.add(ExploreFetch()),
//       expect: () => [isA<ExploreState>()],
//     );
//
//     blocTest(
//       'should emit ExploreFetch and expect correct states',
//       build: () {
//         when(exploreRepositoryImpl.fetchExplore()).thenAnswer((_) async {
//           return Future.value(testExploreModelInstance);
//         });
//         return exploreBloc;
//       },
//       act: (ExploreBloc bloc) async => bloc.add(ExploreFetch()),
//       expect: () => [
//         ExploreState.withValue(true, false, null, null),
//         ExploreState.withValue(false, false, testExploreModelInstance, null),
//       ],
//       verify: (_) {
//         verify(exploreRepositoryImpl.fetchExplore()).called(1);
//       }
//     );
//
//     blocTest(
//       'should emit ExploreReload and expect correct states',
//       build: () {
//         when(exploreRepositoryImpl.fetchExplore()).thenAnswer((_) =>
//           Future.value(testExploreModelInstance));
//         return exploreBloc;
//       },
//       act: (ExploreBloc bloc) async => bloc.add(ExploreReLoad()),
//       expect: () => [
//         ExploreState.withValue(false, true, null, null),
//         ExploreState.withValue(false, false, testExploreModelInstance, null),
//       ],
//       verify: (_) {
//         verify(exploreRepositoryImpl.fetchExplore()).called(1);
//       }
//     );
//
//     blocTest(
//       'should handle error future and expect correct states',
//       build: () {
//         when(exploreRepositoryImpl.fetchExplore()).thenAnswer((_) =>
//           Future.error(testApiExceptionInstance));
//         return exploreBloc;
//       },
//       act: (ExploreBloc bloc) async => bloc.add(ExploreFetch()),
//       expect: () => [
//         ExploreState.withValue(true, false, null, null),
//         ExploreState.withValue(
//           false,
//           false,
//           null,
//           TfException(ErrorCode.ERROR_LOAD_EXPLORE, 'Bad request')
//         ),
//       ],
//     );
//   });
//
//   group('Explore Model tests', () {
//       test('Parsing json from WODOfMonthRequest equal type', () async {
//
//         final jsonFile = File('test/test_data/explore/wod_of_month.json');
//         final decodedWODOfMonthResponse = jsonDecode(await jsonFile.readAsString());
//         final workout = WorkoutDto.fromMap(decodedWODOfMonthResponse);
//
//         when(mockRemoteStorage.fetchWODOfTheMonth())
//             .thenAnswer((_) => Future.value(workout));
//
//         expect(await mockRemoteStorage.fetchWODOfTheMonth(), isA<WorkoutDto>());
//       });
//
//       test('Parsing json from WODOfMonthRequest equal value', () async {
//
//         final jsonFile = File('test/test_data/explore/wod_of_month.json');
//         final decodedWODOfMonthResponse = jsonDecode(await jsonFile.readAsString());
//         final workout = WorkoutDto.fromMap(decodedWODOfMonthResponse);
//
//         when(mockRemoteStorage.fetchWODOfTheMonth())
//             .thenAnswer((_) => Future.value(workout));
//
//         expect(await mockRemoteStorage.fetchWODOfTheMonth(), workout);
//       });
//
//       test('Parsing json from Collection priority request and equal type', () async {
//
//         final jsonFile = File('test/test_data/explore/collection_priority.json');
//         final decodeWorkoutCollectionResponse = jsonDecode(await jsonFile.readAsString());
//         final workoutCollection = WorkoutCollectionResponse.fromJson(decodeWorkoutCollectionResponse);
//
//         when(mockRemoteStorage.fetchWODCollectionPriority())
//             .thenAnswer((_) => Future.value(workoutCollection));
//
//         expect(await mockRemoteStorage.fetchWODCollectionPriority(), isA<WorkoutCollectionResponse>());
//       });
//
//       test('Parsing json from Collection priority request and equal value', () async {
//
//         final jsonFile = File('test/test_data/explore/collection_priority.json');
//         final decodeWorkoutCollectionResponse = jsonDecode(await jsonFile.readAsString());
//         final workoutCollection = WorkoutCollectionResponse.fromJson(decodeWorkoutCollectionResponse);
//
//         when(mockRemoteStorage.fetchWODCollectionPriority())
//             .thenAnswer((_) => Future.value(workoutCollection));
//
//         expect(await mockRemoteStorage.fetchWODCollectionPriority(), workoutCollection);
//       });
//   });
// }