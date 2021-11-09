import 'package:flutter/material.dart';
import 'package:nanny/models/models.dart';
import 'package:nanny/repository/nannies_repo.dart';
import 'package:nanny/service/locator_service.dart';
import 'package:nanny/viewmodel/nannies_view_model.dart';
import 'package:provider/provider.dart';

class NanniesScreen extends StatelessWidget {
  final INanniesRepo _repo = sl.get();

  NanniesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<INanniesViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('App Bar'),
      ),
      body: SafeArea(
        child: Center(
          child: viewModel.nannies.isEmpty
              ? const CircularProgressIndicator()
              : NanniesList(nannies: viewModel.nannies),
        ),
        // child: StreamBuilder<List<Nanny>>(
        //   stream: _repo.getNannies(),
        //   builder: (context, snapshot) {
        //     if (!snapshot.hasData) {
        //       return const CircularProgressIndicator();
        //     }
        //     return NanniesList(nannies: snapshot.data!);
        //   },
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _repo.addNanny(Nanny(name: 'Lol', about: 'its me'));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class NanniesList extends StatelessWidget {
  final INanniesRepo _repo = sl.get();
  final List<Nanny> nannies;

  NanniesList({
    Key? key,
    required this.nannies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nannies.length,
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () {
            _repo.deleteNanny(
              Nanny(
                name: 'test 3',
                about: 'about 2',
                referenceId: nannies[i].referenceId,
              ),
            );
          },
          child: ListTile(
            title: Text(nannies[i].about),
          ),
        );
      },
    );
  }
}
