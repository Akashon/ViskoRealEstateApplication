import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final nameCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final dobCtrl = TextEditingController();

  final RxString gender = "Male".obs;

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(
          color: glass.textPrimary,
          onPressed: () => Get.back(),
        ),
        title: const Text("Personal Information"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _glassInput(glass, "Full Name", nameCtrl),
          const SizedBox(height: 15),
          _dateInput(glass),
          const SizedBox(height: 20),
          _genderSelector(glass),
          const SizedBox(height: 20),
          _glassInput(glass, "Address", addressCtrl, maxLines: 3),
          const SizedBox(height: 40),
          _saveButton(glass),
        ],
      ),
    );
  }

  // ===============================================================
  // WIDGETS
  // ===============================================================

  Widget _glassInput(
    GlassColors glass,
    String hint,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          decoration: BoxDecoration(
            color: glass.cardBackground,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: glass.glassBorder),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: TextStyle(color: glass.textPrimary),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: glass.textSecondary),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _dateInput(GlassColors glass) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          dobCtrl.text = "${picked.day}/${picked.month}/${picked.year}";
        }
      },
      child: AbsorbPointer(
        child: _glassInput(glass, "Date of Birth", dobCtrl),
      ),
    );
  }

  Widget _genderSelector(GlassColors glass) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: glass.cardBackground,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: glass.glassBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Gender",
                style: TextStyle(
                  color: glass.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => Row(
                  children: ["Male", "Female", "Other"].map((g) {
                    final selected = gender.value == g;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => gender.value = g,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: selected
                                ? LinearGradient(
                                    colors: [
                                      glass.chipSelectedGradientStart,
                                      glass.chipSelectedGradientEnd,
                                    ],
                                  )
                                : null,
                            border: Border.all(
                              color: glass.glassBorder,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              g,
                              style: TextStyle(
                                color:
                                    selected ? Colors.white : glass.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _saveButton(GlassColors glass) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              glass.chipSelectedGradientStart,
              glass.chipSelectedGradientEnd,
            ],
          ),
        ),
        child: const Center(
          child: Text(
            "Save Changes",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
