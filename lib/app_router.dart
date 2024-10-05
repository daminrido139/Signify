import 'package:go_router/go_router.dart';
import 'package:signify/router_constants.dart';
import 'package:signify/services/auth_service.dart';
import 'package:signify/ui/Student/call_page.dart';
import 'package:signify/ui/Student/common_page.dart';
import 'package:signify/ui/auth/loginpage.dart';

final appRouter = GoRouter(
  redirect: (context, state) {
    // If logged in
    if (AuthService.isLoggedIn()) {
      if (state.fullPath == RouterConstants.loginRoute) {
        return RouterConstants.commonPageRoute;
      }
      return null;
    }
    //If not logged in
    return null;
  },
  initialLocation: RouterConstants.loginRoute,
  routes: [
    GoRoute(
      path: RouterConstants.loginRoute,
      name: RouterConstants.loginRoute,
      builder: (context, state) => const Loginpage(),
    ),
    GoRoute(
      path: RouterConstants.commonPageRoute,
      name: RouterConstants.commonPageRoute,
      builder: (context, state) => const Commonpage(),
    ),
    GoRoute(
      path: RouterConstants.callPage,
      name: RouterConstants.callPage,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return CallPage(
          callId: args["callId"],
        );
      },
    ),
  ],
);
