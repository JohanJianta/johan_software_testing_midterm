# Midterm Assignment: Unit Testing in Flutter

## Overview

This Flutter application demonstrates an **authentication system** with a `ChangeNotifier`-based `AuthViewModel` that handles:

- Username and password validation
- Login and logout functionality
- Real-time status updates via `RequestStatus` (idle, loading, error)
- Interaction with a simple `AuthService` that connects to a remote dummy login API

This project was created as part of a **Software Testing Midterm Assignment**, focusing on writing unit tests to ensure the correctness and robustness of the authentication logic.

---

## Test Cases

| Test Case ID   | Description                               | Preconditions                                                     | Test Steps                                                                                 | Expected Result                                                       |
| -------------- | ----------------------------------------- | ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------ | --------------------------------------------------------------------- |
| TC_AUTH_VM_001 | Validate Empty Username                   | AuthViewModel is initialized with FakeAuthService                 | Call `validateUsername('')`                                                                | Returns `"Username cannot be empty."`                                 |
| TC_AUTH_VM_002 | Validate Short Password                   | AuthViewModel is initialized with FakeAuthService                 | Call `validatePassword('123')`                                                             | Returns `"Password must be at least 6 characters long."`              |
| TC_AUTH_VM_003 | Successful Login                          | AuthViewModel is initialized with FakeAuthService                 | Call `initiateLogin('testuser', 'password123')`                                            | `user.username == 'testuser'`, `status == idle`                       |
| TC_AUTH_VM_004 | Login with Invalid Credentials            | AuthViewModel is initialized with FakeAuthService                 | Call `initiateLogin('invaliduser', 'wrongpassword')`                                       | Throws error `"Invalid username or password."`, `status == error`     |
| TC_AUTH_VM_005 | Logout Functionality                      | AuthViewModel is initialized and logged in with valid credentials | Call `initiateLogout()`                                                                    | `user == null`, `status == idle`                                      |
| TC_AUTH_VM_006 | Username Length Boundary Values           | AuthViewModel is initialized                                      | Call `validateUsername('abc')`, `validateUsername('ab')`, `validateUsername('a'*21)`       | Returns `null` for valid, `"Invalid username length."` for short/long |
| TC_AUTH_VM_007 | Password Length Boundary Values           | AuthViewModel is initialized                                      | Call `validatePassword('123456')`, `validatePassword('12345')`, `validatePassword('1'*21)` | Returns `null` for valid, error messages for short/long               |
| TC_AUTH_VM_008 | Login with Special Characters in Username | AuthViewModel is initialized                                      | Call `validateUsername('user@name!')`                                                      | Returns `"Invalid characters in username."`                           |
| TC_AUTH_VM_009 | Login with SQL Injection Attempt          | AuthViewModel is initialized                                      | Call `initiateLogin("' OR 1=1 --", "any")`                                                 | Throws error `"Invalid username or password."`, `status == error`     |
| TC_AUTH_VM_010 | Login with Empty Fields                   | AuthViewModel is initialized                                      | Call `validateUsername('')`, `validatePassword('')`                                        | Returns `"Username cannot be empty."`, `"Password cannot be empty."`  |

---

## Running the Tests

To run the unit tests, use the following command:

```bash
flutter test test/auth_view_model_test.dart
```
