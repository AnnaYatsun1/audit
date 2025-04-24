BlocBuilder<{{bloc_name.pascalCase()}}Bloc, {{bloc_name.pascalCase()}}State>(
  bloc: {{bloc_instance}},
  builder: (context, state) {
    if (state is {{bloc_name.pascalCase()}}Initial) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is {{bloc_name.pascalCase()}}Loaded) {
      return Text('Loaded!');
    } else if (state is {{bloc_name.pascalCase()}}Error) {
      return Text('Error: \${state.message}');
    }
    return const SizedBox.shrink();
  },
)
