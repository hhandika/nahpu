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
        TitleForm(text: 'Associated Data', infoContent: AssociateDataInfo()),
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

class AssociateDataInfo extends StatelessWidget {
  const AssociateDataInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoContainer(
      content: [
        InfoContent(
          header: 'Overview',
          content: 'Associated data of the project. It includes data, such as '
              'the GenBank accession number and other digital data associated with the specimen.',
        ),
        InfoContent(
          content:
              'Some of digital data can also be added in the specimen part or media sections.'
              ' Use the associated data section to add data '
              'that is not covered in other sections.',
        )
      ],
    );
  }
}
