class HomeUserProfile {
  const HomeUserProfile({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoUrl,
    required this.freeExplainCount,
    required this.paidCredits,
    required this.globalRank,
    required this.currentPathTitle,
    required this.completedDays,
    required this.totalDays,
    required this.progress,
  });

  factory HomeUserProfile.fallback({
    required String uid,
    required String? displayName,
    required String? email,
    required String? photoUrl,
  }) {
    return HomeUserProfile(
      uid: uid,
      displayName: _fallbackDisplayName(displayName, email),
      email: email ?? '',
      photoUrl: photoUrl,
      freeExplainCount: 0,
      paidCredits: 0,
      globalRank: 0,
      currentPathTitle: 'Lộ trình Fullstack Engineer',
      completedDays: 12,
      totalDays: 20,
      progress: 0.65,
    );
  }

  final String uid;
  final String displayName;
  final String email;
  final String? photoUrl;
  final int freeExplainCount;
  final int paidCredits;
  final int globalRank;
  final String currentPathTitle;
  final int completedDays;
  final int totalDays;
  final double progress;

  int get availableCredits => freeExplainCount + paidCredits;

  String get firstName {
    final normalizedName = displayName.trim();
    if (normalizedName.isEmpty) {
      return 'bạn';
    }

    return normalizedName.split(RegExp(r'\s+')).first;
  }

  HomeUserProfile mergeFallback(HomeUserProfile fallback) {
    return HomeUserProfile(
      uid: uid,
      displayName: displayName.trim().isEmpty
          ? fallback.displayName
          : displayName.trim(),
      email: email.trim().isEmpty ? fallback.email : email.trim(),
      photoUrl: photoUrl?.trim().isNotEmpty == true
          ? photoUrl!.trim()
          : fallback.photoUrl,
      freeExplainCount: freeExplainCount,
      paidCredits: paidCredits,
      globalRank: globalRank,
      currentPathTitle: currentPathTitle.trim().isEmpty
          ? fallback.currentPathTitle
          : currentPathTitle.trim(),
      completedDays: completedDays,
      totalDays: totalDays,
      progress: progress.clamp(0, 1).toDouble(),
    );
  }

  static String _fallbackDisplayName(String? displayName, String? email) {
    final normalizedName = displayName?.trim();
    if (normalizedName != null && normalizedName.isNotEmpty) {
      return normalizedName;
    }

    final normalizedEmail = email?.trim();
    if (normalizedEmail != null && normalizedEmail.isNotEmpty) {
      return normalizedEmail.split('@').first;
    }

    return 'Người dùng';
  }
}
