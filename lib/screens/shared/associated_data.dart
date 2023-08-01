import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/forms.dart';

class AssociatedDataViewer extends ConsumerStatefulWidget {
  const AssociatedDataViewer({super.key});

  @override
  AssociatedDataViewerState createState() => AssociatedDataViewerState();
}

class AssociatedDataViewerState extends ConsumerState<AssociatedDataViewer> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        TitleForm(text: 'Associated Data', infoContent: [
          InfoContent(
            text: 'Associated data is data that'
                ' is not directly related to the project,'
                ' but is still relevant to the project.'
                ' This data is not required to be filled out.',
          ),
        ]),
        SizedBox(height: 16),
        Flexible(
          child: Text(
            'Coming soon...',
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
