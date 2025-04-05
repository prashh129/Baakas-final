import 'package:baakas_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:baakas_admin/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/sizes.dart';

class CouponsDesktopScreen extends StatelessWidget {
  const CouponsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const BaakasBreadcrumbsWithHeading(
                heading: 'Coupons',
                breadcrumbItems: ['Coupons'],
              ),
              const SizedBox(height: BaakasSizes.spaceBtwSections * 5),

              Center(
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage(BaakasImages.couponIllustration),
                      width: 300,
                      height: 300,
                    ),
                    const SizedBox(height: BaakasSizes.spaceBtwItems),
                    Text(
                      'Coupons Cooking',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: BaakasSizes.spaceBtwItems),
                    const Text(
                      'Hold onto your hats! We\'re brewing up a Coupons feature for both the Admin Panel and the App. 🎉 \nThe Coupons Screen is just around the corner... get ready for some savings magic! 🪄💸',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
