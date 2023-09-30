import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';

import '../../../../config/routing/note_routes.dart';
import '../../../../utils/ui/custom_search_bar.dart';
import '../../model/note_model.dart';
import '../../viewmodel/notes_provider.dart';
import '../widgets/note_card_widget.dart';
import '../widgets/notes_pagination_error_widget.dart';

class NotesPage extends ConsumerStatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  ConsumerState<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends ConsumerState<NotesPage> {
  var isSearch = false;
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var notesRef = ref.watch(notesProvider.notifier);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(46.h),
          child: CustomSearchBar(
            title: 'Code23 Notlar',
            hintText: 'Notlarda ara...',
            isSearch: isSearch,
            searchController: searchController,
            searchTextOnSubmitted: (searchKey) {
              if (searchKey != null && searchKey.trim().isNotEmpty) {
                notesRef.search(searchKey: searchKey.trim());
              }
              return null;
            },
            backButtonOnPressed: () {
              searchController.text = "";
              setState(() {
                isSearch = false;
              });

              ref.invalidate(notesProvider);
            },
            closeButtonOnPressed: () {
              searchController.text = "";
              setState(() {
                isSearch = false;
              });

              ref.invalidate(notesProvider);
            },
          )),
      body: SafeArea(
        bottom: false,
        child: RiverPagedBuilder<int, Note>(
          pullToRefresh: true,
          firstPageKey: 1,
          provider: notesProvider,
          limit: 15,
          itemBuilder: (context, item, index) => NoteCardWidget(note: item),
          pagedBuilder: (controller, builder) => PagedListView(
              pagingController: controller, builderDelegate: builder),
          firstPageErrorIndicatorBuilder: (context, controller) {
            return NotesPaginationErrorWidget(
              controller: controller,
              messageTitle: 'Bir hata meydana geldi!',
              messageContent:
                  'Lütfen internet bağlantınızı kontrol edin ve tekrar deneyin.',
            );
          },
          noItemsFoundIndicatorBuilder: (context, controller) {
            return NotesPaginationErrorWidget(
              controller: controller,
              messageTitle: 'Kayıtlı not bulunamadı!',
              messageContent: 'Lütfen anahtar kelimeyi değiştirmeyi deneyin.',
              buttonVisible: false,
            );
          },
          newPageErrorIndicatorBuilder: (context, controller) {
            return NotesPaginationErrorWidget(
              controller: controller,
              messageTitle: 'Bir hata meydana geldi!',
              messageContent:
                  'Lütfen internet bağlantınızı kontrol edin ve tekrar deneyin.',
              //buttonVisible: true,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NoteRoutes(context).noteAddPage();
        },
        backgroundColor: Colors.black.withOpacity(0.75),
        child: FaIcon(
          FontAwesomeIcons.plus,
          size: 24.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
