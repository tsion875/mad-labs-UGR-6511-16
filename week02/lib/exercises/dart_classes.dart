// Week 2 Dart exercises — classes, inheritance, sealed types, mixins,
// generics, extensions and async.
//
// Each section has a description of what the tests expect. Implement the
// missing pieces; run: flutter test test/exercises/dart_classes_test.dart
// The worked examples from the lecture are in lecture_examples.dart.
//
// ignore_for_file: unused_import
import 'dart:async';

// ---------------------------------------------------------------------------
// Exercise 1 — Student
// ---------------------------------------------------------------------------

class Student {
  Student({required this.firstName, required this.lastName, required this.id});

  /// Named constructor for an anonymous visitor.
  // TODO(lab): use an initialiser list (`: firstName = 'Guest', ...`)
  Student.guest() : this(firstName: 'Guest', lastName: '', id: 'GUEST');

  final String firstName;
  final String lastName;
  final String id;

  String get fullName => lastName.isEmpty ? firstName : '$firstName $lastName';

  @override
  String toString() => 'Student($id, $fullName)';
}

// ---------------------------------------------------------------------------
// Exercise 2 — Shapes
// ---------------------------------------------------------------------------

sealed class Shape {
  const Shape();
}

class Circle extends Shape {
  const Circle(this.radius);
  final double radius;
}

class Rectangle extends Shape {
  const Rectangle(this.width, this.height);
  final double width;
  final double height;
}

class Square extends Rectangle {
  const Square(double side) : super(side, side);
}

double area(Shape shape) {
  return switch (shape) {
    Circle(radius: final r) => 3.14159 * r * r,
    Square(width: final w) => w * w,
    Rectangle(width: final w, height: final h) => w * h,
  };
}

// ---------------------------------------------------------------------------
// Exercise 3 (Extra task) — Mixins
// ---------------------------------------------------------------------------

// TODO(lab): mixin Logger { ... }
// TODO(lab): mixin Greeter { ... }

class Robot {
  Robot(this.name);
  final String name;

  List<String> get logs => throw UnimplementedError();
  String introduce() => throw UnimplementedError();
}

// ---------------------------------------------------------------------------
// Exercise 4 — Stack<T>
// ---------------------------------------------------------------------------

class Stack<T> {
  final List<T> _items = [];

  bool get isEmpty => _items.isEmpty;

  int get length => _items.length;

  void push(T item) {
    _items.add(item);
  }

  T pop() {
    if (_items.isEmpty) {
      throw StateError('Cannot pop from an empty stack');
    }
    return _items.removeLast();
  }

  T? peek() => _items.isEmpty ? null : _items.last;
}

// ---------------------------------------------------------------------------
// Exercise 5 (Extra task) — Extension StringX
// ---------------------------------------------------------------------------

extension StringX on String {
  String capitalize() => throw UnimplementedError(); // TODO(lab)
  String titleCase() => throw UnimplementedError(); // TODO(lab)
}

// ---------------------------------------------------------------------------
// Exercise 6 — Wallet
// ---------------------------------------------------------------------------

class InsufficientFundsException implements Exception {
  InsufficientFundsException(this.requested, this.available);
  final int requested;
  final int available;
}

class Wallet {
  Wallet([this._balance = 0]);
  int _balance;

  int get balance => _balance;

  void deposit(int amount) {
    if (amount <= 0) {
      throw ArgumentError('Deposit must be greater than zero');
    }
    _balance += amount;
  }

  void withdraw(int amount) {
    if (amount > _balance) {
      throw InsufficientFundsException(amount, _balance);
    }
    _balance -= amount;
  }

  bool tryWithdraw(int amount) {
    if (amount > _balance) {
      return false;
    }
    _balance -= amount;
    return true;
  }
}

// ---------------------------------------------------------------------------
// Exercise 7 — Futures
// ---------------------------------------------------------------------------

Future<String> fetchGreeting(
  String name, {
  Duration delay = const Duration(milliseconds: 10),
}) async {
  await Future.delayed(delay);
  return 'Hello, $name';
}

Future<List<String>> fetchAllGreetings(List<String> names) {
  return Future.wait(names.map(fetchGreeting));
}

Future<String> fetchGreetingOrThrow(String name) async {
  if (name.isEmpty) {
    throw ArgumentError('Name cannot be empty');
  }
  return fetchGreeting(name);
}
