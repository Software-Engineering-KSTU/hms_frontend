class UserDto {
  final int id;
  final String username;
  final String email;
  final String role;

  UserDto({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
    );
  }
}
