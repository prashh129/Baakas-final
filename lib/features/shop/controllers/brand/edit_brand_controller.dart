import 'package:baakas_admin/data/repositories/product/product_repository.dart';
import 'package:baakas_admin/features/shop/controllers/product/product_controller.dart';
import 'package:baakas_admin/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/brands/brand_repository.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../media/controllers/media_controller.dart';
import '../../../media/models/image_model.dart';
import '../../models/brand_category_model.dart';
import '../../models/brand_model.dart';
import '../../models/category_model.dart';
import 'brand_controller.dart';

class EditBrandController extends GetxController {
  static EditBrandController get instance => Get.find();

  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final repository = Get.put(BrandRepository());
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  /// Init Data
  void init(BrandModel brand) {
    name.text = brand.name;
    imageURL.value = brand.image;
    isFeatured.value = brand.isFeatured;
    if (brand.brandCategories != null) {
      selectedCategories.addAll(brand.brandCategories ?? []);
    }
  }

  /// Toggle Category Selection
  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  /// Method to reset fields
  void resetFields() {
    name.clear();
    loading(false);
    isFeatured(false);
    imageURL.value = '';
    selectedCategories.clear();
  }

  /// Pick Thumbnail Image from Media
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Set the selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selectedImage
      imageURL.value = selectedImage.url;
    }
  }

  /// Register new Brand
  Future<void> updateBrand(BrandModel brand) async {
    try {
      // Start Loading
      BaakasFullScreenLoader.popUpCircular();

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BaakasFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        BaakasFullScreenLoader.stopLoading();
        return;
      }

      // Is Data Updated
      bool isBrandUpdated = false;
      if (brand.image != imageURL.value ||
          brand.name != name.text.trim() ||
          brand.isFeatured != isFeatured.value) {
        isBrandUpdated = true;

        // Map Data
        brand.image = imageURL.value;
        brand.name = name.text.trim();
        brand.isFeatured = isFeatured.value;
        brand.updatedAt = DateTime.now();

        // Call Repository to Update
        await repository.updateBrand(brand);
      }

      // Update BrandCategories
      if (selectedCategories.isNotEmpty) await updateBrandCategories(brand);

      // Update Brand Data in Products
      if (isBrandUpdated) await updateBrandInProducts(brand);

      // Update All Data list
      BrandController.instance.updateItemFromLists(brand);

      // Update UI Listeners
      update();

      // Remove Loader
      BaakasFullScreenLoader.stopLoading();

      // Success Message & Redirect
      BaakasLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your Record has been updated.',
      );
    } catch (e) {
      BaakasFullScreenLoader.stopLoading();
      BaakasLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Update Categories of this Brand
  updateBrandCategories(BrandModel brand) async {
    // Fetch all BrandCategories
    final brandCategories = await repository.getCategoriesOfSpecificBrand(
      brand.id,
    );

    // SelectedCategoryIds
    final selectedCategoryIds = selectedCategories.map((e) => e.id);

    // Identify categories to remove
    final categoriesToRemove =
        brandCategories
            .where(
              (existingCategory) =>
                  !selectedCategoryIds.contains(existingCategory.categoryId),
            )
            .toList();

    // Remove unselected categories
    for (var categoryToRemove in categoriesToRemove) {
      await BrandRepository.instance.deleteBrandCategory(
        categoryToRemove.id ?? '',
      );
    }

    // Identify new categories to add
    final newCategoriesToAdd =
        selectedCategories
            .where(
              (newCategory) =>
                  !brandCategories.any(
                    (existingCategory) =>
                        existingCategory.categoryId == newCategory.id,
                  ),
            )
            .toList();

    // Add new categories
    for (var newCategory in newCategoriesToAdd) {
      var brandCategory = BrandCategoryModel(
        brandId: brand.id,
        categoryId: newCategory.id,
      );
      brandCategory.id = await BrandRepository.instance.createBrandCategory(
        brandCategory,
      );
    }

    brand.brandCategories!.assignAll(selectedCategories);
    BrandController.instance.updateItemFromLists(brand);
  }

  /// Update Products of this Brand
  updateBrandInProducts(BrandModel brand) async {
    final productController = Get.put(ProductController());

    // Check if Products are available, if not then fetch them
    if (productController.allItems.isEmpty) {
      await productController.fetchItems();
    }

    // Once products are fetched, Get all products of this brand
    final brandProducts =
        productController.allItems
            .where(
              (product) =>
                  product.brand != null && product.brand!.id == brand.id,
            )
            .toList();
    if (brandProducts.isNotEmpty) {
      // Update Brand in Products
      for (var product in brandProducts) {
        product.brand = brand;
        await ProductRepository.instance.updateProductSpecificValue(
          product.id,
          {'Brand': brand.toJson()},
        );
        // productController.updateItemFromLists(product); // Optional as allItems are Rx Type hence, will automatically updated when brandProducts changed
      }
    }
  }
}
