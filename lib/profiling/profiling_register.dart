import 'package:debug_input_filler/Exeptions/profiling.exceptions.dart';
import 'package:debug_input_filler/profiling/profiling.model.dart';

class DebugProfileRegistry {
  static final DebugProfileRegistry _instance =
      DebugProfileRegistry._internal();

  static DebugProfileRegistry get instance => _instance;

  // --- Internal state
  final List<DebugProfile> _profiles = [];
  int _currentProfileIndex = 0;
  // ignore: unused_field
  bool _initialized = false;

  // --- Private constructor
  DebugProfileRegistry._internal();

  /// Optional one-time initialization.
  /// Call this early (e.g. in main) if you want to seed profiles.
  /// Calling initialize more than once will append profiles unless you pass clearExisting:true.
  void initialize({
    List<DebugProfile>? initialProfiles,
    int profileIndex = 0,
    bool clearExisting = false,
  }) {
    if (clearExisting) {
      _profiles.clear();
      _currentProfileIndex = 0;
    }

    if (initialProfiles != null && initialProfiles.isNotEmpty) {
      if (profileIndex < 0 || profileIndex > initialProfiles.length - 1) {
        throw MissMatchProfileIndex(profileIndex, initialProfiles.length - 1);
      }
      _profiles.addAll(initialProfiles);
      _currentProfileIndex = profileIndex;
    }

    _initialized = true;
  }

  /// Register a single profile at runtime.
  void register(DebugProfile profile) {
    _profiles.add(profile);
    // if this is the first profile added, ensure index stays valid
    if (_profiles.length == 1) {
      _currentProfileIndex = 0;
    }
  }

  /// Clears all profiles and resets index.
  void clear() {
    _profiles.clear();
    _currentProfileIndex = 0;
  }

  /// Whether any profiles are present.
  bool get hasProfiles => _profiles.isNotEmpty;

  /// Read-only list of profiles.
  List<DebugProfile> get profiles => List.unmodifiable(_profiles);

  /// Current profile index
  int get currentProfileIndex => _currentProfileIndex;

  set currentProfileIndex(int index) {
    if (_profiles.isEmpty) {
      throw ArgumentError.value(index, 'index', 'No profiles available');
    }
    if (index < 0 || index >= _profiles.length) {
      throw ArgumentError.value(index, 'index', 'Invalid profile index');
    }
    _currentProfileIndex = index;
  }

  /// Get current (active) profile
  DebugProfile get currentProfile {
    if (_profiles.isEmpty) {
      throw StateError('No profiles registered');
    }
    return _profiles[_currentProfileIndex];
  }

  /// Safely get profile by index (throws if invalid)
  DebugProfile getProfileByIndex(int index) {
    if (index < 0 || index >= _profiles.length) {
      throw ArgumentError.value(index, 'index', 'Invalid profile index');
    }
    return _profiles[index];
  }
}
