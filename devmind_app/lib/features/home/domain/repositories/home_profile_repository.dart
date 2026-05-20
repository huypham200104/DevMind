import '../entities/home_user_profile.dart';

abstract interface class HomeProfileRepository {
  Stream<HomeUserProfile?> watchProfile(String uid);
}
