// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:visko_rocky_flutter/theme/app_theme.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class LegalWebViewPage extends StatefulWidget {
//   final String title;
//   final String url;

//   const LegalWebViewPage({
//     super.key,
//     required this.title,
//     required this.url,
//   });

//   @override
//   State<LegalWebViewPage> createState() => _LegalWebViewPageState();
// }

// class _LegalWebViewPageState extends State<LegalWebViewPage> {
//   late final WebViewController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(Uri.parse(widget.url));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final glass = Theme.of(context).extension<GlassColors>()!;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,

//       appBar: AppBar(
//         leading: CupertinoNavigationBarBackButton(
//           color: glass.textPrimary,
//         ),
//         title: Text(widget.title),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: ClipRRect(
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//           child: Container(
//             decoration: BoxDecoration(
//               color: glass.cardBackground,
//               border: Border(
//                 top: BorderSide(color: glass.glassBorder),
//               ),
//             ),
//             child: WebViewWidget(controller: controller),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LegalWebViewPage extends StatefulWidget {
  final String title;
  final String url;

  const LegalWebViewPage({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  State<LegalWebViewPage> createState() => _LegalWebViewPageState();
}

class _LegalWebViewPageState extends State<LegalWebViewPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      // 🔥 FIXED APP BAR (NO TRANSPARENT BUG)
      appBar: AppBar(
        elevation: 0,
        backgroundColor: glass.solidSurface, // 🔥 UPDATED
        surfaceTintColor: glass.solidSurface, // 🔥 IMPORTANT (Material 3 fix)
        leading: CupertinoNavigationBarBackButton(
          color: glass.textPrimary, // theme based
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            color: glass.textPrimary, // 🔥 UPDATED
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            decoration: BoxDecoration(
              color: glass.cardBackground, // 🔥 theme card
              border: Border(
                top: BorderSide(
                  color: glass.glassBorder, // 🔥 theme border
                ),
              ),
            ),
            // child: WebViewWidget(
            //   controller: controller,
            // ),
          ),
        ),
      ),
    );
  }
}
