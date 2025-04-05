import 'package:baakas_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../widgets/image_meta.dart';
import '../widgets/settings_form.dart';

class SettingsDesktopScreen extends StatelessWidget {
  const SettingsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(BaakasSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              BaakasBreadcrumbsWithHeading(
                heading: 'Settings',
                breadcrumbItems: ['Settings'],
              ),
              SizedBox(height: BaakasSizes.spaceBtwSections),

              // Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Pic and Meta
                  Expanded(child: ImageAndMeta()),
                  SizedBox(width: BaakasSizes.spaceBtwSections),

                  // Form
                  Expanded(flex: 2, child: SettingsForm()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
