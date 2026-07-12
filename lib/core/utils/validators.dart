import 'package:flutter/material.dart';
import 'constants.dart';

class Validators {
  static String? requiredField(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }
    return null;
  }

  static String? username(String? value) {
    if (value == null || value.isEmpty) return 'Username is required';
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  static String? title(String? value) {
    if (value == null || value.isEmpty) return 'Title is required';
    if (value.length < AppConstants.minTitleLength) {
      return 'Title must be at least ${AppConstants.minTitleLength} characters';
    }
    if (value.length > AppConstants.maxTitleLength) {
      return 'Title must be less than ${AppConstants.maxTitleLength} characters';
    }
    return null;
  }

  static String? body(String? value) {
    if (value == null || value.isEmpty) return 'Content is required';
    if (value.length < AppConstants.minBodyLength) {
      return 'Content must be at least ${AppConstants.minBodyLength} characters';
    }
    if (value.length > AppConstants.maxBodyLength) {
      return 'Content must be less than ${AppConstants.maxBodyLength} characters';
    }
    return null;
  }

  static String? comment(String? value) {
    if (value == null || value.trim().isEmpty) return 'Comment cannot be empty';
    if (value.length > AppConstants.maxCommentLength) {
      return 'Comment must be less than ${AppConstants.maxCommentLength} characters';
    }
    return null;
  }
}