import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Obx(
                () => SwitchListTile(
                  title: const Text("Dark Theme"),
                  subtitle: const Text("Switch between light and dark mode"),
                  value: controller.isDarkMode.value,
                  onChanged: controller.toggleTheme,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Font Size",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Restart the app after changing this for it to fully apply.",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Obx(
                    () => Column(
                      children: [
                        Slider(
                          value: controller.fontScale.value,
                          min: 0.8,
                          max: 1.4,
                          divisions: 6,
                          label: controller.fontScale.value.toStringAsFixed(1),
                          onChanged: controller.updateFontScale,
                        ),
                        Text(
                          "Sample text preview",
                          style: TextStyle(
                            fontSize: 16 * controller.fontScale.value,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
