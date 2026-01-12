import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:visko_rocky_flutter/theme/app_theme.dart';

class InquiryForm extends StatefulWidget {
  final String propertySlug;

  const InquiryForm({
    super.key,
    required this.propertySlug,
    required propertyName,
    required propertyData,
  });

  @override
  State<InquiryForm> createState() => _InquiryFormState();
}

class _InquiryFormState extends State<InquiryForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController mobileCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController messageCtrl = TextEditingController();

  bool isSubmitting = false;

  Future<void> submitInquiry() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSubmitting = true);

    final url = Uri.parse(
      "https://api.visko.group/api/fraction/inquiry/landing-inquiry",
    );

    final body = {
      "li_name": nameCtrl.text.trim(),
      "li_contact": mobileCtrl.text.trim(),
      "li_email": emailCtrl.text.trim(),
      "li_message": messageCtrl.text.trim(),
      "property_slug": widget.propertySlug,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      setState(() => isSubmitting = false);

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSnack(
          data["message"] ?? "Inquiry sent successfully",
          success: true,
        );
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(context);
        });
      } else {
        _showSnack(
          data["message"] ?? "Failed to submit inquiry",
          success: false,
        );
      }
    } catch (e) {
      setState(() => isSubmitting = false);
      _showSnack("Something went wrong. Please try again.", success: false);
    }
  }

  /// ✅ CLEAN FEEDBACK SNACKBAR (not button-like)
  void _showSnack(String msg, {required bool success}) {
    final glass = Theme.of(context).extension<GlassColors>()!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        backgroundColor: success
            ? glass.cardBackground.withOpacity(0.95)
            : Colors.red.shade600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Row(
          children: [
            Icon(
              success ? Icons.check_circle_outline : Icons.error_outline,
              color: success ? Colors.green : Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                msg,
                style: TextStyle(
                  color: success ? glass.textPrimary : Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    final primary = Theme.of(context).primaryColor;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: glass.glassBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: glass.glassBorder),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "Inquiry Form",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: glass.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 20),

                        _glassField(
                          "Name",
                          nameCtrl,
                          glass,
                        ),
                        const SizedBox(height: 10),

                        /// 📱 MOBILE NUMBER (10 digits only)
                        _glassField(
                          "Mobile Number",
                          mobileCtrl,
                          glass,
                          keyboard: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Please enter mobile number";
                            }
                            if (v.length != 10) {
                              return "Mobile number must be 10 digits";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),

                        /// 📧 EMAIL VALIDATION
                        _glassField(
                          "Email",
                          emailCtrl,
                          glass,
                          keyboard: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Please enter email";
                            }
                            final emailRegex = RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            );
                            if (!emailRegex.hasMatch(v)) {
                              return "Enter valid email address";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),

                        _glassField(
                          "Message",
                          messageCtrl,
                          glass,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isSubmitting ? null : submitInquiry,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: glass.chipSelectedGradientStart,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isSubmitting
                                ? SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor:
                                          AlwaysStoppedAnimation(primary),
                                    ),
                                  )
                                : Text(
                                    "Submit",
                                    style: TextStyle(
                                      color: glass.solidSurface,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// ❌ CLOSE BUTTON
          Positioned(
            top: 6,
            right: 6,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: glass.glassBackground,
                      border: Border.all(color: glass.glassBorder),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: glass.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassField(
    String hint,
    TextEditingController ctrl,
    GlassColors glass, {
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboard,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      validator: validator ??
          (v) => v == null || v.isEmpty ? "Please enter $hint" : null,
      style: TextStyle(color: glass.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: glass.textSecondary),
        filled: true,
        fillColor: glass.cardBackground,
        border: _border(glass),
        enabledBorder: _border(glass),
        focusedBorder: _border(glass, focus: true),
      ),
    );
  }

  OutlineInputBorder _border(GlassColors glass, {bool focus = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: focus ? glass.chipSelectedGradientStart : glass.glassBorder,
        width: focus ? 1.4 : 1,
      ),
    );
  }
}


// import 'dart:convert';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:visko_rocky_flutter/theme/app_theme.dart';

// class InquiryForm extends StatefulWidget {
//   final String propertySlug;

//   const InquiryForm({
//     super.key,
//     required this.propertySlug,
//     required propertyName,
//     required propertyData,
//   });

//   @override
//   State<InquiryForm> createState() => _InquiryFormState();
// }

// class _InquiryFormState extends State<InquiryForm> {
//   final TextEditingController nameCtrl = TextEditingController();
//   final TextEditingController mobileCtrl = TextEditingController();
//   final TextEditingController emailCtrl = TextEditingController();
//   final TextEditingController messageCtrl = TextEditingController();

//   bool isSubmitting = false;
//   final _formKey = GlobalKey<FormState>();

//   Future<void> submitInquiry() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => isSubmitting = true);

//     final url = Uri.parse(
//       "https://api.visko.group/api/fraction/inquiry/landing-inquiry",
//     );

//     final body = {
//       "li_name": nameCtrl.text,
//       "li_contact": mobileCtrl.text,
//       "li_email": emailCtrl.text,
//       "li_message": messageCtrl.text,
//       "property_slug": widget.propertySlug,
//     };

//     try {
//       final response = await http.post(
//         url,
//         body: jsonEncode(body),
//         headers: {"Content-Type": "application/json"},
//       );

//       setState(() => isSubmitting = false);
//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         _showSnack(data["message"] ?? "Inquiry sent successfully!", true);
//         Future.delayed(const Duration(milliseconds: 400), () {
//           Navigator.pop(context);
//         });
//       } else {
//         _showSnack(data["message"] ?? "Failed to submit inquiry", false);
//       }
//     } catch (_) {
//       setState(() => isSubmitting = false);
//       _showSnack("Something went wrong!", false);
//     }
//   }

//   void _showSnack(String msg, bool success) {
//     final glass = Theme.of(context).extension<GlassColors>()!;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(msg),
//         backgroundColor:
//             success ? glass.chipSelectedGradientStart : glass.glassBorder,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final glass = Theme.of(context).extension<GlassColors>()!;
//     final primary = Theme.of(context).primaryColor;

//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(20),
//       child: Stack(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
//               child: Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: glass.glassBackground,
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: glass.glassBorder),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 6),
//                         Text(
//                           "Inquiry Form",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: glass.textPrimary,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         _glassField("Name", nameCtrl, glass),
//                         const SizedBox(height: 10),
//                         _glassField(
//                           "Mobile Number",
//                           mobileCtrl,
//                           glass,
//                           keyboard: TextInputType.phone,
//                           validator: (v) {
//                             if (v == null || v.isEmpty) {
//                               return "Please enter mobile number";
//                             }
//                             if (v.length < 10) {
//                               return "Enter valid mobile number";
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 10),
//                         _glassField(
//                           "Email",
//                           emailCtrl,
//                           glass,
//                           keyboard: TextInputType.emailAddress,
//                           validator: (v) {
//                             if (v == null || v.isEmpty) {
//                               return "Please enter email";
//                             }
//                             if (!v.contains("@")) {
//                               return "Enter valid email";
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 10),
//                         _glassField(
//                           "Message",
//                           messageCtrl,
//                           glass,
//                           maxLines: 3,
//                         ),
//                         const SizedBox(height: 20),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: isSubmitting ? null : submitInquiry,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: glass.chipSelectedGradientStart,
//                               padding: const EdgeInsets.symmetric(vertical: 18),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: isSubmitting
//                                 ? SizedBox(
//                                     width: 22,
//                                     height: 22,
//                                     child: CircularProgressIndicator(
//                                       strokeWidth: 2,
//                                       valueColor:
//                                           AlwaysStoppedAnimation(primary),
//                                     ),
//                                   )
//                                 : Text(
//                                     "Submit",
//                                     style: TextStyle(
//                                       color: glass.solidSurface,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           /// CLOSE BUTTON
//           Positioned(
//             top: 6,
//             right: 6,
//             child: GestureDetector(
//               onTap: () => Navigator.pop(context),
//               child: ClipOval(
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
//                   child: Container(
//                     height: 36,
//                     width: 36,
//                     decoration: BoxDecoration(
//                       color: glass.glassBackground,
//                       border: Border.all(color: glass.glassBorder),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.close,
//                       size: 18,
//                       color: glass.textPrimary,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _glassField(
//     String hint,
//     TextEditingController ctrl,
//     GlassColors glass, {
//     TextInputType keyboard = TextInputType.text,
//     int maxLines = 1,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       controller: ctrl,
//       keyboardType: keyboard,
//       maxLines: maxLines,
//       validator: validator ??
//           (v) => v == null || v.isEmpty ? "Please enter $hint" : null,
//       style: TextStyle(color: glass.textPrimary),
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: TextStyle(color: glass.textSecondary),
//         filled: true,
//         fillColor: glass.cardBackground,
//         border: _border(glass),
//         enabledBorder: _border(glass),
//         focusedBorder: _border(glass, focus: true),
//       ),
//     );
//   }

//   OutlineInputBorder _border(GlassColors glass, {bool focus = false}) {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: BorderSide(
//         color: focus ? glass.chipSelectedGradientStart : glass.glassBorder,
//         width: focus ? 1.4 : 1,
//       ),
//     );
//   }
// }

