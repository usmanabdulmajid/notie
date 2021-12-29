import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF01284E),
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
                GestureDetector(
                  onTap: () {},
                  child: const ImageIcon(
                    AssetImage('asset/images/menu_button.png'),
                    color: Colors.white,
                  ),
                ),
                const CircleAvatar(
                  backgroundColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 40,
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'search note',
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.mic),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: EdgeInsets.zero,
                crossAxisCount: 4,
                itemCount: 23,
                itemBuilder: (BuildContext context, int index) => Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'note ${index + 1}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: Text(
                          '''nm,dnm,n,mnjfmnfmvfnvnmfvnmfnmfvn,mfnv,mnf,mn,mfnvfmbvb,nf,bvnmbfvnmbv,mfjbvjbnkjrhntkjgrbhjnrfvjnjhnkjnvkjdn,jbdcd,hjbad,djbnckjn,kjhfkjhckjehfckjhrkfjhr''',
                          overflow: TextOverflow.ellipsis,
                          maxLines: index.isOdd ? 12 : 6,
                        ),
                      )
                    ],
                  ),
                ),
                staggeredTileBuilder: (int index) {
                  return StaggeredTile.count(2, index.isOdd ? 2 : 1.5);
                },
                mainAxisSpacing: 6.0,
                crossAxisSpacing: 10.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
