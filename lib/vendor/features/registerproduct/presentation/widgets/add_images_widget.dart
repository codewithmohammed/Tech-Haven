import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/icons/icons.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/pick_image.dart';

import 'package:tech_haven/core/entities/image.dart' as model;
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/widgets/list_view_container.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/widgets/sub_text.dart';

class AddImagesWidget extends StatefulWidget {
  const AddImagesWidget(
      {super.key,
      required this.productImages,
      this.productImagesLink,
      required this.deletedImagesIndex,
      required this.canAddNewImages});

  final Map<int, List<File>> productImages;
  final Map<int, List<model.Image>>? productImagesLink;
  final List<int> deletedImagesIndex;
  final bool canAddNewImages;

  @override
  State<AddImagesWidget> createState() => _AddImagesWidgetState();
}

class _AddImagesWidgetState extends State<AddImagesWidget> {
  void selectMultipleImages(int mainIndex) async {
    final pickedImages = await pickMultipleImages();
    if (pickedImages != null) {
      if (widget.productImages.containsKey(mainIndex)) {
        setState(() {
          widget.productImages[mainIndex]!.addAll(pickedImages);
        });
      } else {
        setState(() {
          widget.productImages[mainIndex] = pickedImages;
        });
      }
    } else {
      showSnackBar(
          context: context,
          title: 'Oh',
          content: 'You Failed To SelectImage',
          contentType: ContentType.failure);
    }
  }

  void selectImage(int mainIndex) async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      // print(widget.productImages.length);
      setState(() {
        widget.productImages[mainIndex] = [pickedImage];
      });
      // widget.productImages.value = widget.productImagesTemp;
      // print(widget.productImages.length);
    } else {
      showSnackBar(
          context: context,
          title: 'Oh',
          content: 'You Failed To SelectImage',
          contentType: ContentType.failure);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.productImagesLink != null) {}
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.productImagesLink != null
                      ? widget.productImagesLink!.length
                      : widget.productImages.length,
                  itemBuilder: (context, index) {
                    return ListViewContainer(
                      onTapCenterWidget: () {
                        // setState(() {
                        //   attributeCount++;
                        // });
                      },
                      onPressedCrossIcon: () {
                        if (widget.productImagesLink != null) {
                          setState(() {
                            widget.deletedImagesIndex.add(index);
                          });
                        } else {
                          setState(() {
                            if (widget.productImages.containsKey(index + 1)) {
                              final value = widget.productImages[index + 1];
                              widget.productImages[index] = value!;
                              widget.productImages.remove(index + 1);
                            } else {
                              widget.productImages.remove(index);
                            }
                          });
                        }
                      },
                      containerWidth: 80,
                      centerWidget: Stack(
                        alignment: Alignment.center,
                        children: [
                          widget.productImagesLink != null
                              ? Image.network(
                                  widget.productImagesLink![index]!.first
                                      .imageURL,
                                )
                              : Image.file(
                                  widget.productImages[index]!.first,
                                  fit: BoxFit.cover,
                                ),
                          if ((widget.deletedImagesIndex.contains(index)) &&
                              (widget.productImagesLink != null))
                            GestureDetector(
                              onTap: () {
                                if (widget.productImagesLink != null) {
                                  setState(() {
                                    widget.deletedImagesIndex.remove(index);
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: Colors.red.withOpacity(0.5),
                                child: const Center(
                                  child: Text(
                                    'Undo Removing this Images',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      crossIcon: (widget.deletedImagesIndex.contains(index) &&
                              (widget.productImagesLink != null))
                          ? false
                          : true,
                    );
                  },
                ),
              ),
            ),
            if (widget.productImagesLink == null)
              SizedBox(
                height: 100,
                child: ListViewContainer(
                    crossIcon: false,
                    containerWidth: 80,
                    color: AppPallete.darkgreyColor,
                    centerWidget: const SvgIcon(
                      icon: CustomIcons.plusSvg,
                      radius: 20,
                    ),
                    onTapCenterWidget: () {
                      selectImage(widget.productImages.length);
                    },
                    onPressedCrossIcon: () {}),
              ),
          ],
        ),
        Constants.kHeight,
        const GlobalTitleText(
          title: 'Upload Image',
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.productImagesLink != null
              ? widget.productImagesLink!.length
              : widget.productImages.length,
          itemBuilder: (context, mainIndex) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubText(
                  subText: 'color ${mainIndex + 1}',
                ),
                Container(
                  width: 80,
                  height: 100,
                  margin: const EdgeInsets.all(
                    5,
                  ),
                  decoration: const BoxDecoration(
                    color: AppPallete.darkgreyColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                  child: InkWell(
                    child: Center(
                      child: widget.productImagesLink != null
                          ? Image.network(
                              widget.productImagesLink![mainIndex]![0].imageURL)
                          : Image.file(
                              widget.productImages[mainIndex]!.first,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.productImagesLink != null
                              ? widget.productImagesLink![mainIndex]!.length
                              : widget.productImages[mainIndex]!.length,
                          itemBuilder: (context, index) {
                            return ListViewContainer(
                              onTapCenterWidget: () {
                                // setState(() {
                                //   totalImageCount++;
                                // });
                              },
                              onPressedCrossIcon: () {
                                setState(() {
                                  widget.productImages[mainIndex]!
                                      .removeAt(index);
                                });
                              },
                              containerWidth: 150,
                              centerWidget: widget.productImagesLink != null
                                  ? Image.network(
                                      widget
                                          .productImagesLink![mainIndex]![index]
                                          .imageURL,
                                    )
                                  : Image.file(
                                      widget.productImages[mainIndex]![index],
                                    ),
                              crossIcon: widget.productImagesLink != null
                                  ? false
                                  : index == 0
                                      ? false
                                      : true,
                            );
                          },
                        ),
                      ),
                      if (widget.productImagesLink == null)
                        ListViewContainer(
                            crossIcon: false,
                            containerWidth: 150,
                            centerWidget: const SvgIcon(
                              icon: CustomIcons.plusSvg,
                              radius: 20,
                            ),
                            onTapCenterWidget: () {
                              selectMultipleImages(mainIndex);
                            },
                            onPressedCrossIcon: () {}),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
