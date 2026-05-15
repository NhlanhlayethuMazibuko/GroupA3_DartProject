import 'package:flutter/material.dart';
import 'package:group_a3/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/application_viewmodel.dart';
import '../widgets/application_card.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<ApplicationViewModel>().fetchAllApplications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<AuthViewModel>().signOut();
            },
          ),
        ],
      ),
      body: Consumer<ApplicationViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.errorMessage != null) {
            return Center(
              child: Text(
                vm.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (vm.applications.isEmpty) {
            return const Center(
              child: Text("No applications available"),
            );
          }

          return ListView.builder(
            itemCount: vm.applications.length,
            itemBuilder: (context, index) {
              final app = vm.applications[index];

              return Column(
                children: [
                  ApplicationCard(
                    application: app,
                    onDelete: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      final viewModel = context.read<ApplicationViewModel>();

                      await viewModel.deleteApplication(app.id);

                      if (!mounted) return;

                      messenger.showSnackBar(
                        const SnackBar(content: Text("Application deleted")),
                      );
                    },
                  ),

                  const SizedBox(height: 8),
                  //Action buttons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          final viewModel =
                              context.read<ApplicationViewModel>();

                          await viewModel.updateStatus(app.id, "approved");

                          if (!mounted) return;

                          messenger.showSnackBar(
                            const SnackBar(
                                content: Text("Application approved")),
                          );
                        },
                        child: const Text("Approve"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          final viewModel =
                              context.read<ApplicationViewModel>();

                          await viewModel.updateStatus(app.id, "rejected");

                          if (!mounted) return;

                          messenger.showSnackBar(
                            const SnackBar(
                                content: Text("Application rejected")),
                          );
                        },
                        child: const Text("Reject"),
                      ),
                    ],
                  ),

                  const Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
