// import 'package:bloc_test/bloc_test.dart';
// import 'package:core/generated/l10n.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:totalfit/model/user.dart';
// import 'package:totalfit/storage/cloud/request/sign_in_with_social_request.dart';
// import 'package:totalfit/storage/cloud/server_api.dart';
// import 'package:totalfit/storage/db/local_storage.dart';
// import 'package:totalfit/ui/screen/auth/entry/bloc/entry_bloc.dart';
//
// class MockServerApi extends Mock implements ServerApi {}
// class MockLocalStorage extends Mock implements LocalStorage {}
// class MockSignInWithSocialRequest extends Mock implements SignInWithSocialRequest{}
// class MockS extends Mock implements S {}
//
// // final testUserInstance = User(
// //   firstName: 'Derek',
// //   lastName: 'Garrett',
// //   email: 'derek.g@gmail.com',
// //   photo: 'https://i.pravatar.cc/150?img=11',
// //   birthday: '1990-12-10',
// //   registerDate: '2021-06-12',
// //   status: Status.INACTIVE,
// //   token: 'securityToken',
// //   verifyEmailSent: '2021-06-14T18:14:12.246Z',
// //   roles: ['athlete'],
// //   height: '170',
// //   weight: '70',
// //   country: 'USA',
// //   city: 'New York',
// //   gender: Gender.MALE
// // );
//
// void main() {
//
//   group('EntryBloc tests', () {
//     MockServerApi mockServerApi;
//     MockLocalStorage mockLocalStorage;
//     EntryBloc entryBloc;
//     MockSignInWithSocialRequest mockSignInWithSocialRequest;
//
//     setUp(() {
//       mockServerApi = MockServerApi();
//       mockLocalStorage = MockLocalStorage();
//       mockSignInWithSocialRequest = MockSignInWithSocialRequest();
//
//       entryBloc = EntryBloc(
//         serverApi: mockServerApi,
//         localStorage: mockLocalStorage,
//       );
//     });
//
//     tearDown(() {
//       entryBloc?.close();
//     });
//
//     test('Initial state is correct', () async {
//       await expectLater(entryBloc.state, EntryState.initial());
//     });
//
//     test('Throws AssertionError if Server Api contract is null', () {
//       expect(
//         () => EntryBloc(serverApi: null, localStorage: null),
//         throwsA(isAssertionError),
//       );
//     });
//
//     // blocTest(
//     //   'Should emit Sign up with Facebook if repository throws',
//     //   build: () {
//     //     when(mockServerApi.signInWithSocial(mockSignInWithSocialRequest))
//     //       .thenAnswer((_) => Future.value(testUserInstance));
//     //     return entryBloc;
//     //   },
//     //   act: (EntryBloc entryBloc) async => entryBloc.add(SignUpWithSocial(FacebookSignUp())),
//     //   expect: () => [
//     //     isA<EntryState>().having(
//     //       (state) => state.formStatus, 'form status in progress', equals(FormStatus.pure)
//     //     ),
//     //   ],
//     // );
//
//   });
// }
void main() {

}