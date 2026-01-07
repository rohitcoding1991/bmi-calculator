abstract class AuthRepo{
  Future<Object> login({required String email, required String password});
  Future<Object> updateProfile({required String name});
  Future<Object?> getProfile();
  void logout();
}