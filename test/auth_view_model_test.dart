import 'package:flutter_test/flutter_test.dart';
import 'package:johan_software_testing_midterm/models/models.dart';
import 'package:johan_software_testing_midterm/viewmodels/auth_view_model.dart';

class FakeAuthService extends AuthService {
  @override
  Future<User> login(String username, String password) async {
    if (username == 'testuser' && password == 'password123') {
      return const User(username: 'testuser');
    } else {
      throw Exception("Invalid username or password.");
    }
  }

  @override
  Future<void> logout() async {}
}

void main() {
  late AuthViewModel viewModel;

  setUp(() {
    viewModel = AuthViewModel(authService: FakeAuthService());
  });

  group('AuthViewModel Tests', () {
    test('TC_AUTH_VM_001 - Validate Empty Username', () {
      final result = viewModel.validateUsername('');
      expect(result, "Username cannot be empty.");
    });

    test('TC_AUTH_VM_002 - Validate Short Password', () {
      final result = viewModel.validatePassword('123');
      expect(result, "Password must be at least 6 characters long.");
    });

    test('TC_AUTH_VM_003 - Successful Login', () async {
      await viewModel.initiateLogin('testuser', 'password123');
      expect(viewModel.user?.username, 'testuser');
      expect(viewModel.status, RequestStatus.idle);
    });

    test('TC_AUTH_VM_004 - Login with Invalid Credentials', () async {
      expectLater(
        () async => await viewModel.initiateLogin('invaliduser', 'wrongpassword'),
        throwsA(predicate((e) {
          expect(viewModel.status, RequestStatus.error);
          expect(e.toString(), contains('Invalid username or password.'));
          return true;
        })),
      );
    });

    test('TC_AUTH_VM_005 - Logout Functionality', () async {
      await viewModel.initiateLogin('testuser', 'password123');
      expect(viewModel.user?.username, 'testuser');

      await viewModel.initiateLogout();

      // User is not set to null, but we can simulate session invalidation
      // In real apps, we check the token/session cleanup
      // So we just check that logout doesn't throw
      expect(viewModel.user?.username, null);
      expect(viewModel.status, RequestStatus.idle);
    });

    test('TC_AUTH_VM_006 - Username Length Boundary Values', () {
      final valid = viewModel.validateUsername('abc'); // min 3
      final invalidShort = viewModel.validateUsername('ab');
      final invalidLong = viewModel.validateUsername('a' * 21); // >20

      expect(valid, null);
      expect(invalidShort, "Invalid username length.");
      expect(invalidLong, "Invalid username length.");
    });

    test('TC_AUTH_VM_007 - Password Length Boundary Values', () {
      final valid = viewModel.validatePassword('123456'); // min 6
      final invalidShort = viewModel.validatePassword('12345');
      final invalidLong = viewModel.validatePassword('1' * 21); // >20

      expect(valid, null);
      expect(invalidShort, "Password must be at least 6 characters long.");
      expect(invalidLong, "Password too long.");
    });

    test('TC_AUTH_VM_008 - Login with Special Characters in Username', () {
      final result = viewModel.validateUsername('user@name!');
      expect(result, "Invalid characters in username.");
    });

    test('TC_AUTH_VM_009 - Login with SQL Injection Attempt', () async {
      expectLater(
        () async => await viewModel.initiateLogin("' OR 1=1 --", "any"),
        throwsA(predicate((e) {
          expect(viewModel.status, RequestStatus.error);
          expect(e.toString(), contains('Invalid username or password.'));
          return true;
        })),
      );
    });

    test('TC_AUTH_VM_010 - Login with Empty Fields', () {
      final userResult = viewModel.validateUsername('');
      final passResult = viewModel.validatePassword('');

      expect(userResult, "Username cannot be empty.");
      expect(passResult, "Password cannot be empty.");
    });
  });
}
