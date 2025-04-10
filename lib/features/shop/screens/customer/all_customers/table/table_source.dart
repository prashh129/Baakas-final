import 'package:baakas_admin/routes/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/icons/table_action_icon_buttons.dart';
import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/customer/customer_controller.dart';

class CustomerRows extends DataTableSource {
  final controller = CustomerController.instance;

  @override
  DataRow? getRow(int index) {
    final customer = controller.filteredItems[index];
    return DataRow2(
      onTap:
          () => Get.toNamed(BaakasRoutes.customerDetails, arguments: customer),
      selected: controller.selectedRows[index],
      onSelectChanged:
          (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              BaakasRoundedImage(
                width: 50,
                height: 50,
                padding: BaakasSizes.sm,
                image: customer.profilePicture,
                imageType: ImageType.network,
                borderRadius: BaakasSizes.borderRadiusMd,
                backgroundColor: BaakasColors.primaryBackground,
              ),
              const SizedBox(width: BaakasSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  customer.fullName,
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.apply(color: BaakasColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(customer.email)),
        DataCell(Text(customer.phoneNumber)),
        DataCell(
          Text(customer.createdAt == null ? '' : customer.formattedDate),
        ),
        DataCell(
          BaakasTableActionButtons(
            view: true,
            edit: false,
            onViewPressed:
                () => Get.toNamed(
                  BaakasRoutes.customerDetails,
                  arguments: customer,
                ),
            onDeletePressed: () => controller.confirmAndDeleteItem(customer),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount =>
      controller.selectedRows.where((selected) => selected).length;
}
