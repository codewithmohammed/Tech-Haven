import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class InfoCard extends StatelessWidget {
  const InfoCard(
      {super.key,
      required this.name,
      required this.email,
      required this.imageURL,
      required this.onTapSettingIcon});
  final String name;
  final String email;
  final String? imageURL;
  final void Function()? onTapSettingIcon;

  @override
  Widget build(BuildContext context) {
    print(imageURL == null);
    return ListTile(
      leading: imageURL != null
          ? Container(
              clipBehavior: Clip.antiAlias,
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                25,
              )),
              child: CachedNetworkImage(
                imageUrl: imageURL!,
                imageBuilder: (context, imageProvider) => Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.grey.shade300,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: AppPallete.whiteColor,
                      boxShadow: [Constants.globalBoxBlur],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  margin: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: AppPallete.whiteColor,
                    boxShadow: [Constants.globalBoxBlur],
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Icon(Icons.error),
                ),
              ),
            )
          : const SvgIcon(icon: CustomIcons.userCircleSvg, radius: 50),
      title: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        email,
        style: const TextStyle(
          color: Colors.white70,
        ),
      ),
      trailing: InkWell(
        onTap: onTapSettingIcon,
        child: const SvgIcon(
          color: AppPallete.whiteColor,
          icon: CustomIcons.settingSvg,
          radius: 25,
        ),
      ),
    );
  }
}
