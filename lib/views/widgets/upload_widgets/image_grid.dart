import 'package:flutter/material.dart';
import 'package:send_man/models/image_upload_model.dart';
import 'package:send_man/viewmodels/image_grid_vm.dart';
import 'package:send_man/viewmodels/vm_provider.dart';
import 'package:send_man/views/widgets/common_widgets/empty_builder.dart';
import 'package:send_man/views/widgets/upload_widgets/image_grid_item.dart';

class ImgGrid extends StatelessWidget {
  final List<CoreImage> coreImgs;
  const ImgGrid({
    Key? key,
    required this.coreImgs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VMProvider<ImgGridVm>(
      vm: ImgGridVm(),
      builder: (context, vm) {
        return coreImgs.isEmpty
            ? EmptyBuilder(
                title: "No uploads yet ?",
                subTitle:
                    "Press the button on top right corner\nto upload your first image",
              )
            : GridView.builder(
                itemCount: coreImgs.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(10.0),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 1.5,
                ),
                itemBuilder: (context, index) {
                  final _coreImg = coreImgs[index];

                  return ImgGridItem(
                    coreImg: _coreImg,
                    vm: vm,
                  );
                },
              );
      },
    );
  }
}
