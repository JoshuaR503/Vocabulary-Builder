import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BadgeManager {

  // Fetch saved Badge count from device.
  Future<int> _fetchBadges(int badgeCount) async {
    // Shared Preferences instance.
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    // Fetch amount of words saved last time.
    if (preferences.containsKey('badgeCount'))  {
      // Saved badge count.
      return preferences.getInt('badgeCount');
    } else {
      // Save badgeCount 
      this._setBadge(badgeCount);
      // Default badge count.
      return badgeCount;
    }
  }

  // Set Badge count in device.
  void _setBadge(int badgeCount) async {
    // Shared Preferences instance.
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    // Save admount of badge.
    preferences.setInt('badgeCount', badgeCount);
  }

  // Update Badge count.
  void updateBadgeCount(int badgeCount) async {
    // Get saved badge amount.
    final int savedBadgeCount = await _fetchBadges(badgeCount);

    // Decide what to do.
    if (badgeCount == savedBadgeCount) {
      // Remove Badge
      FlutterAppBadger.removeBadge();
    } else if (badgeCount != savedBadgeCount) {
      // Set badge.
      this._setBadge(badgeCount);
      // Update badge
      FlutterAppBadger.updateBadgeCount(badgeCount);
    }
  }

}

