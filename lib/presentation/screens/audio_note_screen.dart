import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:notie/application/cubit/recoder_cubit.dart';
import 'package:notie/presentation/widgets/top_bar_buttom.dart';
import 'package:notie/utils/app_color.dart';

class AudioNoteScreen extends StatefulWidget {
  const AudioNoteScreen({Key? key}) : super(key: key);

  @override
  State<AudioNoteScreen> createState() => _AudioNoteScreenState();
}

class _AudioNoteScreenState extends State<AudioNoteScreen> {
  late final _audioPath;
  @override
  void initState() {
    super.initState();
    context.read<RecoderCubit>().init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RecoderCubit>();
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 20.0),
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
                    color: AppColor.white,
                    size: 16,
                  ),
                ),
                TopBarButton(
                  onPressed: () {},
                  child: const Text(
                    'SAVE',
                    style: TextStyle(color: AppColor.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            BlocBuilder<RecoderCubit, RecoderState>(
              builder: (context, state) {
                if (state is Recording) {
                  return Text(
                    state.timer.toString(),
                    style:
                        const TextStyle(fontSize: 40.0, color: AppColor.white),
                  );
                }
                return const Text(
                  '00:00:00',
                  style: TextStyle(fontSize: 40.0, color: AppColor.white),
                );
              },
            ),
            const SizedBox(height: 30),
            Icon(
              Icons.mic,
              size: 140,
              color: AppColor.white.withOpacity(0.7),
            ),
            const SizedBox(height: 140),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await cubit.record();
                    },
                    child: const Text('Record')),
                ElevatedButton(
                    onPressed: () async {
                      await cubit.pause();
                    },
                    child: const Text('Pause')),
                ElevatedButton(
                    onPressed: () async {
                      await cubit.resume();
                    },
                    child: const Text('Resume')),
                ElevatedButton(
                    onPressed: () async {
                      setState(() async {
                        _audioPath = await cubit.stop();
                      });
                    },
                    child: const Text('Stop')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
