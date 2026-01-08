class PendingNavigation {
  static String? route;
  static Object? arguments;

  static void set(String r, {Object? args}) {
    route = r;
    arguments = args;
  }

  static bool get hasPending => route != null;

  static void clear() {
    route = null;
    arguments = null;
  }
}
