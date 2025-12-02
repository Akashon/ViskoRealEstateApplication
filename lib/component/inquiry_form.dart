// import 'dart:convert';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class InquiryForm extends StatefulWidget {
//   final bool isDark;
//   final String propertySlug; // optional property ID / slug

//   const InquiryForm({
//     super.key,
//     required this.isDark,
//     required this.propertySlug,
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

//   // --------------------------
//   // API SUBMIT LOGIC
//   // --------------------------
//   Future<void> submitInquiry() async {
//     setState(() => isSubmitting = true);

//     final url = Uri.parse(
//       "https://apimanager.viskorealestate.com/submit-property-inquiry",
//     );

//     final body = {
//       "name": nameCtrl.text,
//       "mobile": mobileCtrl.text,
//       "email": emailCtrl.text,
//       "message": messageCtrl.text,
//       "property_slug": widget.propertySlug,
//     };

//     try {
//       final response = await http.post(url, body: body);

//       setState(() => isSubmitting = false);

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         if (data["status"] == true) {
//           Navigator.pop(context);
//           showSuccess("Inquiry sent successfully!");
//         } else {
//           showError("Failed to submit inquiry.");
//         }
//       } else {
//         showError("Server error. Try again.");
//       }
//     } catch (e) {
//       setState(() => isSubmitting = false);
//       showError("Something went wrong!");
//     }
//   }

//   void showSuccess(String msg) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.green));
//   }

//   void showError(String msg) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool isDark = widget.isDark;

//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(20),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
//           child: Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: isDark
//                   ? Colors.white.withOpacity(0.05)
//                   : Colors.white.withOpacity(0.85),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: isDark ? Colors.white24 : Colors.grey.shade300,
//               ),
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Text(
//                     "Inquiry Form",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: isDark ? Colors.white : Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   TextField(
//                     controller: nameCtrl,
//                     decoration: _glassInputDecoration("Name", isDark),
//                   ),
//                   const SizedBox(height: 10),

//                   TextField(
//                     controller: mobileCtrl,
//                     keyboardType: TextInputType.phone,
//                     decoration: _glassInputDecoration("Mobile Number", isDark),
//                   ),
//                   const SizedBox(height: 10),

//                   TextField(
//                     controller: emailCtrl,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: _glassInputDecoration("Email", isDark),
//                   ),
//                   const SizedBox(height: 10),

//                   TextField(
//                     controller: messageCtrl,
//                     maxLines: 3,
//                     decoration: _glassInputDecoration("Message", isDark),
//                   ),

//                   const SizedBox(height: 20),

//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: isSubmitting ? null : submitInquiry,
//                       style: ElevatedButton.styleFrom(
//                         // backgroundColor: CustomColor.kPrimaryColor,
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: isSubmitting
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : const Text(
//                               "Submit",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // ---------------------------
//   // GLASS INPUT FIELD DESIGN
//   // ---------------------------
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
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(
//           // color: CustomColor.kPrimaryColor,
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

const Color kPrimaryOrange = Color(0xffF26A33);

class InquiryForm extends StatefulWidget {
  final bool isDark;
  final String propertySlug;

  const InquiryForm({
    super.key,
    required this.isDark,
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

  // --------------------------
  // API POST LOGIC WITH PRINTS
  // --------------------------
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

    // 🔥 PRINT ALL INPUT DATA HERE
    print("========= USER INPUT =========");
    print("Name: ${nameCtrl.text}");
    print("Mobile: ${mobileCtrl.text}");
    print("Email: ${emailCtrl.text}");
    print("Message: ${messageCtrl.text}");
    print("Property Slug: ${widget.propertySlug}");
    print("====================================");

    try {
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"},
      );

      setState(() => isSubmitting = false);

      final data = jsonDecode(response.body);

      // 🔥 PRINT API RESPONSE
      print("========= API RESPONSE =========");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("================================");

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"] ?? "Inquiry sent successfully!"),
            backgroundColor: Colors.green,
          ),
        );

        Future.delayed(const Duration(milliseconds: 400), () {
          Navigator.pop(context);
        });
      } else {
        showError(data["message"] ?? "Failed to submit inquiry");
      }
    } catch (e) {
      setState(() => isSubmitting = false);
      showError("Something went wrong!");
    }
  }

  void showError(String msg) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = widget.isDark;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? Colors.white24 : Colors.grey.shade300,
              ),
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
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // NAME
                    TextFormField(
                      controller: nameCtrl,
                      decoration: _glassInputDecoration("Name", isDark),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // MOBILE
                    TextFormField(
                      controller: mobileCtrl,
                      keyboardType: TextInputType.phone,
                      decoration: _glassInputDecoration(
                        "Mobile Number",
                        isDark,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter mobile number";
                        }
                        if (value.length < 10) {
                          return "Enter a valid mobile number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // EMAIL
                    TextFormField(
                      controller: emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _glassInputDecoration("Email", isDark),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter email";
                        }
                        if (!value.contains("@")) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // MESSAGE
                    TextFormField(
                      controller: messageCtrl,
                      maxLines: 3,
                      decoration: _glassInputDecoration("Message", isDark),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your message";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // SUBMIT BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isSubmitting ? null : submitInquiry,
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: CustomColor.kPrimaryColor,
                          backgroundColor: kPrimaryOrange,

                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isSubmitting
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
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
    );
  }

  InputDecoration _glassInputDecoration(String hint, bool isDark) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
      filled: true,
      fillColor: isDark
          ? Colors.white.withOpacity(0.05)
          : Colors.grey.withOpacity(0.15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark ? Colors.white24 : Colors.grey.shade300,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark ? Colors.white24 : Colors.grey.shade300,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
          color: Color.fromARGB(66, 197, 28, 28),
          width: 1.4,
        ),
      ),
    );
  }
}
