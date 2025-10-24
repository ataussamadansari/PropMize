import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/saved_properties_controller.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../global_widgets/shimmer/shimmer_loader.dart';

class SavedPropertiesView extends GetView<SavedPropertiesController> {
    const SavedPropertiesView({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                elevation: 0, // Remove shadow
                scrolledUnderElevation: 0, // Remove elevation when scrolled
                title: const Text('Saved Properties'),
                actions: [
                    Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Obx(() => TweenAnimationBuilder<int>(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.easeOutCubic,
                            tween: IntTween(
                                begin: 0,
                                end: controller.properties.length,
                            ),
                            builder: (BuildContext context, int value, Widget? child) {
                                return Text(
                                    'Saved: $value',
                                    style: context.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                    ),
                                );
                            },
                        )),
                    )

                    /*Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Obx(() => TweenAnimationBuilder<int>(
                            duration: const Duration(milliseconds: 1200),
                            tween: IntTween(
                                begin: 0,
                                end: controller.properties.length,
                            ),
                            builder: (BuildContext context, int value, Widget? child) {
                                return Text(
                                    'Saved: $value',
                                    style: context.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                    ),
                                );
                            },
                        )),
                    )*/

                    /*Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Obx(() => TweenAnimationBuilder<int>(
                            duration: const Duration(milliseconds: 800),
                            tween: IntTween(
                                begin: 0,
                                end: controller.properties.length,
                            ),
                            builder: (BuildContext context, int value, Widget? child) {
                                return Text(
                                    'Saved: $value',
                                    style: context.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                    ),
                                );
                            },
                        )),
                    )*/
                    /* Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Obx(() => Text(
                            'Saved: ${controller.properties.length}',
                            style: context.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                            ),
                        )),
                    )*/
                ],
            ),
            body: Obx(() {
                // Show loading indicator when initially loading
                if (controller.isLoading.value && controller.properties.isEmpty) {
                    if (controller.isLoading.value && controller.properties.isEmpty) {
                        return ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            itemCount: 5,
                            itemBuilder: (context, index) => const ShimmerLoader(),
                        );
                    }
                }

                // Show error state
                if (controller.hasError.value) {
                    return Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                const Icon(
                                    Icons.error_outline,
                                    size: 64,
                                    color: Colors.grey,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                    controller.errorMessage.value,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                    ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                    onPressed: controller.loadLikedProperties,
                                    child: const Text('Try Again'),
                                ),
                            ],
                        ),
                    );
                }

                // Show empty state
                if (controller.properties.isEmpty) {
                    return Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                SvgPicture.asset(
                                    'assets/icons/404 Error-cuate.svg',
                                    width: 300,
                                    height: 300,
                                ),
                                Text(
                                    'No Saved Properties',
                                    style: context.textTheme.headlineSmall?.copyWith(
                                        color: Colors.grey,
                                    ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                    'Properties you like will appear here',
                                    style: context.textTheme.bodyMedium?.copyWith(
                                        color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                ),
                            ],
                        ),
                    );
                }

                // Show properties list with load more functionality
                return NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollEndNotification &&
                            scrollNotification.metrics.pixels ==
                                scrollNotification.metrics.maxScrollExtent &&
                            controller.hasMore.value) {
                            controller.loadMoreProperties();
                        }
                        return false;
                    },
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        itemCount: controller.properties.length + (controller.hasMore.value ? 1 : 0),
                        itemBuilder: (context, index) {
                            // Load more indicator
                            if (index == controller.properties.length) {
                                return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16.0),
                                    child: Center(
                                        child: CircularProgressIndicator(),
                                    ),
                                );
                            }

                            final property = controller.properties[index];

                            print(property);
                            return null;
                        },
                    ),
                );
            }),
        );
    }
}


/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/abc_screen/controllers/contacted_controller.dart';
import 'package:prop_mize/app/modules/saved_properties_screen/controllers/saved_properties_controller.dart';

import '../../../core/themes/app_colors.dart';
import '../../all_listing_screen/views/widgets/property_card_widget.dart';

class SavedPropertiesView extends GetView<SavedPropertiesController>
{
    const SavedPropertiesView({super.key});

    @override
    Widget build(BuildContext context)
    {
        return Obx(()
            {
                return Scaffold(
                    appBar: AppBar(
                        title: Text('Saved Properties'),
                        actions: [
                            Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Text('Saved: ${controller.properties.length}', style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold))
                            )
                        ]
                    ),
                    body: controller.properties.isEmpty ? Center(child: SvgPicture.asset('assets/icons/404 Error-cuate.svg', width: 300)) : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                            itemCount: controller.properties.length + (controller.hasMore.value ? 1 : 0),
                            itemBuilder: (context, index)
                            {
                                if (index == controller.properties.length)
                                {
                                    return const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 16.0),
                                        child: Center(
                                            child: CircularProgressIndicator()
                                        )
                                    );
                                }

                                final property = controller.properties[index];
                                return PropertyCardWidget(properties: property, index: index, controller: controller);
                            }
                        )
                );
            }
        );
    }
}
*/