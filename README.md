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

| ID | Test Case | Description | Expected Result |
|----|-----------|-------------|-----------------|
| **TC_AUTH_VM_001** | Validate Empty Username | Ensure error is returned when username is empty | `"Username cannot be empty."` |
| **TC_AUTH_VM_002** | Validate Short Password | Ensure error is returned for passwords shorter than 6 chars | `"Password must be at least 6 characters long."` |
| **TC_AUTH_VM_003** | Successful Login | Verify login works for valid credentials | `RequestStatus.idle`, user is not null |
| **TC_AUTH_VM_004** | Login with Invalid Credentials | Verify login fails with invalid credentials | `RequestStatus.error`, exception with message `"Invalid username or password."` |
| **TC_AUTH_VM_005** | Logout Functionality | Ensure session is reset on logout | Protected resource should be inaccessible after logout |
| **TC_AUTH_VM_006** | Username Length Boundary Values | Test usernames at min (3) and max (20) characters | Valid: no error message; Invalid: `"Invalid username length."` |
| **TC_AUTH_VM_007** | Password Length Boundary Values | Test passwords at min (6) and max (20) characters | Valid: no error message; Invalid: `"Password too long."` |
| **TC_AUTH_VM_008** | Login with Special Characters in Username | Ensure special characters are rejected in username | `"Invalid characters in username."` |
| **TC_AUTH_VM_009** | Login with SQL Injection Attempt | Ensure SQL injection strings are rejected securely | `RequestStatus.error`, exception with message `"Invalid username or password."` |
| **TC_AUTH_VM_010** | Login with Empty Fields | Ensure login fails when both fields are empty | `"Username cannot be empty."`, `"Password cannot be empty."` |

---

## Running the Tests

To run the unit tests, use the following command:

```bash
flutter test test/auth_view_model_test.dart
