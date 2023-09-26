import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../../../../config/routing/note_routes.dart';
import '../../../../utils/ui/note_properties_widget.dart';
import '../../model/note_model.dart';

class NoteCardWidget extends StatefulWidget {
  final Note note;

  const NoteCardWidget({super.key, required this.note});

  @override
  State<NoteCardWidget> createState() => _NoteCardWidgetState();
}

class _NoteCardWidgetState extends State<NoteCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: InkWell(
        onTap: () {
          NoteRoutes(context).noteDetailPage(note: widget.note);
        },
        borderRadius: BorderRadius.circular(15.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.note.user != null && widget.note.user!.name != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 6.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.note.user!.profileImageUrl ?? '',
                        imageBuilder: (context, imageProvider) => Container(
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(color: Colors.grey, spreadRadius: 1),
                            ],
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (
                          context,
                          url,
                        ) =>
                            SizedBox(
                                width: 24.w,
                                height: 24.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.grey,
                                  strokeWidth: 2,
                                )),
                        errorWidget: (context, url, error) => FaIcon(
                          FontAwesomeIcons.solidCircleUser,
                          size: 32.w,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        widget.note.user!.name ?? '',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
              Text(
                widget.note.title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (widget.note.content != null &&
                  widget.note.content!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 4.w),
                  child: Text(
                    widget.note.content ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              SizedBox(
                height: 4.w,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CardPropertiesWidget(
                      icon: FontAwesomeIcons.tags,
                      name: widget.note.category != null
                          ? widget.note.category!.getName()
                          : 'Diğer',
                    ),
                    CardPropertiesWidget(
                      icon: FontAwesomeIcons.solidClock,
                      name: widget.note.updatedAt != null
                          ? DateFormat('d MMMM HH:mm', 'tr')
                              .format(widget.note.updatedAt!)
                          : DateFormat('d MMMM HH:mm', 'tr')
                              .format(DateTime.now()),
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
