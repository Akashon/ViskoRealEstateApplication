// import 'dart:convert';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// const Color kPrimaryOrange = Color(0xffF26A33);

// class InquiryForm extends StatefulWidget {
//   final bool isDark;
//   final String propertySlug;

//   const InquiryForm({
//     super.key,
//     required this.isDark,
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
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(data["message"] ?? "Inquiry sent successfully!"),
//             backgroundColor: Colors.green,
//           ),
//         );

//         Future.delayed(const Duration(milliseconds: 400), () {
//           Navigator.pop(context);
//         });
//       } else {
//         showError(data["message"] ?? "Failed to submit inquiry");
//       }
//     } catch (e) {
//       setState(() => isSubmitting = false);
//       showError("Something went wrong!");
//     }
//   }

//   void showError(String msg) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(msg), backgroundColor: Colors.red),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool isDark = widget.isDark;

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
//                   color: isDark
//                       ? Colors.white.withOpacity(0.05)
//                       : Colors.white.withOpacity(0.85),
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(
//                     color: isDark ? Colors.white24 : Colors.grey.shade300,
//                   ),
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
//                             color: isDark ? Colors.white : Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         TextFormField(
//                           controller: nameCtrl,
//                           decoration: _glassInputDecoration("Name", isDark),
//                           validator: (value) => value == null || value.isEmpty
//                               ? "Please enter your name"
//                               : null,
//                         ),
//                         const SizedBox(height: 10),
//                         TextFormField(
//                           controller: mobileCtrl,
//                           keyboardType: TextInputType.phone,
//                           decoration:
//                               _glassInputDecoration("Mobile Number", isDark),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return "Please enter mobile number";
//                             }
//                             if (value.length < 10) {
//                               return "Enter a valid mobile number";
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 10),
//                         TextFormField(
//                           controller: emailCtrl,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: _glassInputDecoration("Email", isDark),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return "Please enter email";
//                             }
//                             if (!value.contains("@")) {
//                               return "Enter a valid email";
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 10),
//                         TextFormField(
//                           controller: messageCtrl,
//                           maxLines: 3,
//                           decoration: _glassInputDecoration("Message", isDark),
//                           validator: (value) => value == null || value.isEmpty
//                               ? "Enter your message"
//                               : null,
//                         ),
//                         const SizedBox(height: 20),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: isSubmitting ? null : submitInquiry,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: kPrimaryOrange,
//                               padding: const EdgeInsets.symmetric(vertical: 18),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: isSubmitting
//                                 ? const CircularProgressIndicator(
//                                     color: Colors.white,
//                                   )
//                                 : const Text(
//                                     "Submit",
//                                     style: TextStyle(
//                                       color: Colors.white,
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

//           /// ❌ CLOSE BUTTON
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
//                       color: isDark
//                           ? Colors.white.withOpacity(0.08)
//                           : Colors.black.withOpacity(0.06),
//                       border: Border.all(
//                         color: isDark ? Colors.white24 : Colors.grey.shade300,
//                       ),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.close,
//                       size: 18,
//                       color: isDark ? Colors.white : Colors.black,
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

//   InputDecoration _glassInputDecoration(String hint, bool isDark) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
//       filled: true,
//       fillColor: isDark
//           ? Colors.white.withOpacity(0.05)
//           : Colors.grey.withOpacity(0.15),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(
//           color: isDark ? Colors.white24 : Colors.grey.shade300,
//         ),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(
//           color: isDark ? Colors.white24 : Colors.grey.shade300,
//         ),
//       ),
//       focusedBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(12)),
//         borderSide: BorderSide(
//           color: Color.fromARGB(66, 197, 28, 28),
//           width: 1.4,
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
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
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController mobileCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController messageCtrl = TextEditingController();

  bool isSubmitting = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> submitInquiry() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSubmitting = true);

    final url = Uri.parse(
      "https://api.visko.group/api/fraction/inquiry/landing-inquiry",
    );

    final body = {
      "li_name": nameCtrl.text,
      "li_contact": mobileCtrl.text,
      "li_email": emailCtrl.text,
      "li_message": messageCtrl.text,
      "property_slug": widget.propertySlug,
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"},
      );

      setState(() => isSubmitting = false);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSnack(data["message"] ?? "Inquiry sent successfully!", true);
        Future.delayed(const Duration(milliseconds: 400), () {
          Navigator.pop(context);
        });
      } else {
        _showSnack(data["message"] ?? "Failed to submit inquiry", false);
      }
    } catch (_) {
      setState(() => isSubmitting = false);
      _showSnack("Something went wrong!", false);
    }
  }

  void _showSnack(String msg, bool success) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor:
            success ? glass.chipSelectedGradientStart : glass.glassBorder,
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
                        const SizedBox(height: 6),
                        Text(
                          "Inquiry Form",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: glass.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _glassField("Name", nameCtrl, glass),
                        const SizedBox(height: 10),
                        _glassField(
                          "Mobile Number",
                          mobileCtrl,
                          glass,
                          keyboard: TextInputType.phone,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Please enter mobile number";
                            }
                            if (v.length < 10) {
                              return "Enter valid mobile number";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        _glassField(
                          "Email",
                          emailCtrl,
                          glass,
                          keyboard: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Please enter email";
                            }
                            if (!v.contains("@")) {
                              return "Enter valid email";
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

          /// CLOSE BUTTON
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
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboard,
      maxLines: maxLines,
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
