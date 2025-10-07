class Validation {
  static String? passValidator(value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  static String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  static String? weddingNameValidator(value) {
    if (value == null || value.isEmpty) {
      return "Wedding name is required";
    }
    if (value.length < 3) {
      return "Wedding name must be at least 3 characters";
    }
    return null;
  }
}
