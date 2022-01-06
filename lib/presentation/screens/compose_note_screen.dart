import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notie/application/cubit/notecubit_cubit.dart';
import 'package:notie/presentation/widgets/top_bar_buttom.dart';
import 'package:notie/utils/notehelper_mixin.dart';
import 'package:provider/provider.dart';

class ComposeNoteScreen extends StatefulWidget {
  const ComposeNoteScreen({Key? key}) : super(key: key);

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
    return Scaffold(
      backgroundColor: const Color(0XFF01284E),
      body: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopBarButton(
                    onPressed: () {},
                    child: const ImageIcon(
                      AssetImage('asset/images/ios_arrow.png'),
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  TopBarButton(
                    onPressed: () {
                      if (nonEmptyNote(_titleCtr.text, _bodyCtr.text)) {
                        cubit.saveNote(
                            _titleCtr.text, _bodyCtr.text, noteColor());
                      }
                    },
                    child: const Text(
                      'SAVE',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              TextField(
                controller: _titleCtr,
                style: const TextStyle(fontSize: 30, color: Colors.white),
                decoration: const InputDecoration.collapsed(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.white60, fontSize: 30)),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: _bodyCtr,
                style: const TextStyle(color: Colors.white),
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
    );
  }
}
