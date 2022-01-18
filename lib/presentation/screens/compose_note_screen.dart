import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notie/application/cubit/notecubit_cubit.dart';
import 'package:notie/domain/models/note.dart';
import 'package:notie/presentation/widgets/app_snackbar.dart';
import 'package:notie/presentation/widgets/custom_status_bar.dart';
import 'package:notie/presentation/widgets/top_bar_buttom.dart';
import 'package:notie/utils/app_color.dart';
import 'package:notie/utils/enums.dart';
import 'package:notie/utils/extensions.dart';
import 'package:notie/utils/notehelper_mixin.dart';
import 'package:provider/provider.dart';

class ComposeNoteScreen extends StatefulWidget {
  final Note? note;
  const ComposeNoteScreen({this.note, Key? key}) : super(key: key);

  @override
  State<ComposeNoteScreen> createState() => _ComposeNoteScreenState();
}

class _ComposeNoteScreenState extends State<ComposeNoteScreen>
    with HelperMixin {
  late TextEditingController _titleCtr;
  late TextEditingController _bodyCtr;

  @override
  void initState() {
    super.initState();

    _titleCtr = TextEditingController();
    _bodyCtr = TextEditingController();
    if (widget.note != null) {
      _titleCtr.text = widget.note?.title as String;
      _bodyCtr.text = widget.note?.body as String;
    }
  }

  @override
  void dispose() {
    _titleCtr.dispose();
    _bodyCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<NotecubitCubit>(context);
    return BlocListener<NotecubitCubit, NotecubitState>(
      listener: (context, state) {
        if (state is SaveNote) {
          if (state.success) {
            Navigator.pop(context);
          } else {
            AppSnackBar.failure(context, 'Fail to save note');
          }
        }
        if (state is UpdateNote) {
          if (state.updated) {
            Navigator.pop(context);
          } else {
            AppSnackBar.failure(context, 'Fail to Update note');
          }
        }
      },
      child: CustomStatusBar(
        child: Scaffold(
          backgroundColor: AppColor.mainColor,
          body: Padding(
            padding:
                const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: context.barHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TopBarButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const ImageIcon(
                          AssetImage('asset/images/ios_arrow.png'),
                          color: AppColor.white,
                          size: 16,
                        ),
                      ),
                      TopBarButton(
                        onPressed: () {
                          if (_titleCtr.text.isNotEmpty ||
                              _bodyCtr.text.isNotEmpty) {
                            final note = setNote(
                                noteType: NoteType.text,
                                title: _titleCtr.text,
                                body: _bodyCtr.text);

                            if (widget.note?.id == null) {
                              cubit.saveNote(note);
                            } else {
                              note.id = widget.note?.id;
                              cubit.updateNote(note);
                            }
                          } else {
                            AppSnackBar.failure(
                                context, 'Note cannot be empty');
                          }

                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: const Text(
                          'SAVE',
                          style: TextStyle(color: AppColor.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    controller: _titleCtr,
                    style: const TextStyle(fontSize: 30, color: AppColor.white),
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Title',
                        hintStyle:
                            TextStyle(color: Colors.white60, fontSize: 30)),
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    controller: _bodyCtr,
                    style: const TextStyle(color: AppColor.white),
                    maxLines: null,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Type something....',
                      hintStyle: TextStyle(color: Colors.white60),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
