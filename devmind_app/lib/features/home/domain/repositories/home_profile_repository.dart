import '../entities/home_user_profile.dart';
import '../entities/daily_check_in_summary.dart';

abstract interface class HomeProfileRepository {
  Stream<HomeUserProfile?> watchProfile(String uid);
  Stream<DailyCheckInSummary> watchDailyCheckIn(String uid);
  Future<bool> claimDailyCheckIn(String uid);
}
