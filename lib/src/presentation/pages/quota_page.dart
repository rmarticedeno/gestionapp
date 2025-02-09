import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs.dart';
import '../widgets.dart';
import '../widgets/bottom_sheet.dart';

class QuotaPage extends StatefulWidget {
  const QuotaPage({Key? key}) : super(key: key);

  @override
  _QuotaPageState createState() => _QuotaPageState();
}

class _QuotaPageState extends State<QuotaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Cuota'),
        centerTitle: true,
      ),
      bottomSheet: const GestionUHBottomSheet(),
      drawer: DefaultDrawer(),
      body: BlocConsumer<QuotaBloc, QuotaState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is QuotaLoadedSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<QuotaBloc>().add(QuotaInitialized());
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, bottom: 9, left: 18, right: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: QuotaGraph(
                            quota: state.quota,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is QuotaLoadedFailure) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 9, left: 18, right: 18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.error),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: GestionUhDefaultButton(
                          text: 'Reintentar',
                          onPressed: () {
                            context.read<QuotaBloc>().add(
                                  QuotaInitialized(),
                                );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                GestionUhLoadingIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }
}
