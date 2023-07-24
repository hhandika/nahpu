import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/home/home.dart';
import 'package:nahpu/screens/projects/dashboard.dart';
import 'package:nahpu/screens/projects/project_info.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/services/database/project_queries.dart';
import 'package:nahpu/services/project_services.dart';
import 'package:nahpu/services/utility_services.dart';

enum MenuSelection { details, deleteProject }

class HomeBody extends ConsumerStatefulWidget {
  const HomeBody({super.key});

  @override
  HomeBodyState createState() => HomeBodyState();
}

class HomeBodyState extends ConsumerState<HomeBody> {
  // Table size
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ref.watch(projectListProvider).when(
              data: (data) {
                return _buildBody(data.reversed.toList());
              },
              loading: () {
                return const CommonProgressIndicator();
              },
              error: (error, stackTrace) {
                return Text(error.toString());
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(List<ListProjectResult> projectList) {
    if (projectList.isEmpty) {
      return const ProjectNotFound();
    } else {
      return ToggleView(projectList: projectList);
    }
  }
}

class ToggleView extends StatefulWidget {
  const ToggleView({super.key, required this.projectList});

  final List<ListProjectResult> projectList;

  @override
  State<ToggleView> createState() => _ToggleViewState();
}

class _ToggleViewState extends State<ToggleView> {
  bool isListSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Existing projects:',
                style: Theme.of(context).textTheme.titleLarge),
            IconButton(
                onPressed: () {
                  setState(() {
                    isListSelected = !isListSelected;
                  });
                },
                icon: isListSelected
                    ? const Icon(Icons.grid_view)
                    : const Icon(Icons.list_alt)),
          ],
        ),
        Divider(
          color: Theme.of(context).colorScheme.onSurface,
          thickness: 1.5,
        ),
        isListSelected
            ? ProjectListView(projectList: widget.projectList)
            : ProjectGridView(
                projectList: widget.projectList,
              ),
      ],
    );
  }
}

class ProjectNotFound extends StatelessWidget {
  const ProjectNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'No projects found!',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Create a new project to get started',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class ProjectListView extends StatelessWidget {
  const ProjectListView({super.key, required this.projectList});
  final List<ListProjectResult> projectList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: projectList.length,
        itemBuilder: (context, index) {
          return ProjectView(
            isList: true,
            project: projectList[index],
          );
        },
      ),
    );
  }
}

class ProjectGridView extends StatelessWidget {
  const ProjectGridView({
    super.key,
    required this.projectList,
  });

  final List<ListProjectResult> projectList;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    const int gridSize = 400;
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getCrossAxisCount(width, gridSize),
          childAspectRatio: 1.5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: projectList.length,
        itemBuilder: (context, index) {
          return ProjectView(isList: false, project: projectList[index]);
        },
      ),
    );
  }
}

class ProjectView extends ConsumerStatefulWidget {
  const ProjectView({
    super.key,
    required this.isList,
    required this.project,
  });

  final bool isList;
  final ListProjectResult project;

  @override
  ProjectViewState createState() => ProjectViewState();
}

class ProjectViewState extends ConsumerState<ProjectView> {
  @override
  Widget build(BuildContext context) {
    return widget.isList
        ? ListProjectCard(project: widget.project, onTap: _openProject())
        : GridProjectCard(project: widget.project, onPressed: _openProject());
  }

  VoidCallback _openProject() {
    return () {
      ref
          .read(projectUuidProvider.notifier)
          .updateProjectUuid(widget.project.uuid);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    };
  }
}

class ListProjectCard extends StatelessWidget {
  const ListProjectCard(
      {super.key, required this.project, required this.onTap});

  final ListProjectResult project;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          Icons.insert_drive_file_outlined,
          size: 40,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        title: Text(
          project.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          'Created: ${project.created}',
          style: const TextStyle(
            fontSize: 12,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: ProjectPopUpMenu(project: project),
        onTap: onTap,
      ),
    );
  }
}

class GridProjectCard extends StatelessWidget {
  const GridProjectCard(
      {super.key, required this.project, required this.onPressed});

  final ListProjectResult project;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(project.name),
          subtitle: Text('Created: ${project.created}'),
          trailing: ProjectPopUpMenu(project: project),
        ),
        child: FittedBox(
          alignment: Alignment.center,
          fit: BoxFit.cover,
          child: IconButton(
            icon: const Icon(Icons.insert_drive_file_outlined),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}

class ProjectPopUpMenu extends ConsumerStatefulWidget {
  const ProjectPopUpMenu({super.key, required this.project});

  final ListProjectResult project;

  @override
  ProjectPopUpMenuState createState() => ProjectPopUpMenuState();
}

class ProjectPopUpMenuState extends ConsumerState<ProjectPopUpMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuSelection>(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuSelection>>[
        PopupMenuItem<MenuSelection>(
          value: MenuSelection.details,
          child: const ListTile(
            leading: Icon(Icons.info_outlined),
            title: Text('Details'),
          ),
          onTap: () {
            _getProjectInfo(widget.project.uuid);
          },
        ),
        const PopupMenuDivider(),
        PopupMenuItem<MenuSelection>(
          value: MenuSelection.deleteProject,
          onTap: () => _deleteProject(widget.project.uuid),
          child: const ListTile(
              leading: Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
              title: Text(
                'Delete Project',
                style: TextStyle(color: Colors.red),
              )),
        ),
      ],
    );
  }

  Future<void> _deleteProject(String projectUuid) async {
    return Future.delayed(
      const Duration(seconds: 0),
      () => showDeleteAlertOnMenu(
        context: context,
        title: 'Delete project?',
        deletePrompt: 'You will delete this project permanently',
        onDelete: () async {
          try {
            await ProjectServices(ref: ref).deleteProject(projectUuid);
          } catch (e) {
            String error = e.toString();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: error.contains('787')
                    ? const Text(
                        'Delete all project data first before deleting project')
                    : Text('Something went wrong: $error'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
          if (mounted) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const Home()));
          }
        },
      ),
    );
  }

  void _getProjectInfo(String projectUuid) {
    // We technically can directly call the projectInfoProvider here,
    // but for the popup menu to work, we need to implement Future.delayed
    // and call the provider from the onTap function of the popup menu.
    // when we tested this, users have to tap twice to get the popup menu to work.
    // This solution works well.
    ProjectServices(ref: ref).getProjectByUuid(projectUuid).then(
          (value) => showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Project information'),
                content: SingleChildScrollView(
                    child: ProjectInfo(projectData: value)),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          ),
        );
  }
}
