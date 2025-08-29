import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/forgot_password/widget/include_phone_number/include_phone_number.dart';
import 'package:pstb/app/modules/forgot_password/widget/include_phone_number/include_phone_store.dart';

class IncludePhoneModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => IncludePhoneStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => IncludePhoneNumber(data: args.data)),
  ];
}
