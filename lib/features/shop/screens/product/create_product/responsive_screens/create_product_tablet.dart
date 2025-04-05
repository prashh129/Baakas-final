import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';

class CreateProductTabletScreen extends StatelessWidget {
  const CreateProductTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(BaakasSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaakasBreadcrumbsWithHeading(
                  returnToPreviousScreen: true,
                  heading: 'Create Product',
                  breadcrumbItems: [BaakasRoutes.products, 'Create Product']),
              SizedBox(height: BaakasSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
