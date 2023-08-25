import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrouter/vrouter.dart';

class ProfilePictureSmall extends StatelessWidget {
  final String profileImageURL;
  final String profileId;
  final VoidCallback? onTap;

  const ProfilePictureSmall(
      {Key? key, required this.profileImageURL, required this.profileId, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => VRouter.of(context).to("/showprofile/:$profileId"),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppTheme.cardRadiusSmall,
        ),
        constraints: BoxConstraints.expand(
          height: AppTheme.cardPadding * 1.75,
          width: AppTheme.cardPadding * 1.75,
        ),
        child: ClipRRect(
          borderRadius: AppTheme.cardRadiusSmall,
          child: CachedNetworkImage(
            imageUrl: profileImageURL == ''
                ? 'http://ev-evgym.at/wp-content/uploads/2018/12/240_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg'
                : profileImageURL,
            placeholder: (context, url) => CircularProgressIndicator(), // Loading indicator
            errorWidget: (context, url, error) => Container(color: Colors.grey,
            child: Center(
              child: Icon(
                FontAwesomeIcons.sadCry,
              )
            ),), // Fallback when image loading fails
          ),
        ),
      ),
    );
  }


  buildProfilePicture2(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).unselectedWidgetColor,
          borderRadius: AppTheme.cardRadiusSmall,
        ),
        constraints: BoxConstraints.expand(
          height: 40,
          width: 40,
        ),
        child: ClipRRect(
          borderRadius: AppTheme.cardRadiusSmall,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://cdn.dribbble.com/users/4835348/screenshots/16497394/media/fd882f6e5c1d2b8ae6e99aae036be420.png?compress=1&resize=400x300'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ));
  }
}
