import 'package:go_router/go_router.dart';
import 'package:ruta_demo/main/presentation/screens/screens.dart';
import 'package:ruta_demo/main/presentation/screens/test_screen.dart';
import 'package:ruta_demo/main/presentation/widgets/test.dart';

final appRouter = GoRouter(initialLocation: '/articulos', routes: [
  GoRoute(path: '/main', builder: (context, state) => const MainScreen()),
  GoRoute(
      path: '/articulos', builder: (context, state) => const ArticulosScreen()),
  GoRoute(path: '/pedidos', builder: (context, state) => const PedidosScreen()),
  GoRoute(
      path: '/nuevo-pedido', builder: (context, state) => const TestScreen()),
  GoRoute(
      path: '/vendedores',
      builder: (context, state) => const VendedoresScreen()),
  GoRoute(
      path: '/sucursales',
      builder: (context, state) => const SucursalesScreen()),
  GoRoute(path: '/monedas', builder: (context, state) => const MonedasScreen()),
  GoRoute(
      path: '/almacenes', builder: (context, state) => const AlmacenesScreen()),
  GoRoute(
      path: '/cobradores',
      builder: (context, state) => const CobradoresScreen()),
  GoRoute(
      path: '/clientes', builder: (context, state) => const ClientesScreen()),
  GoRoute(
      path: '/condicionesPago',
      builder: (context, state) => const CondicionesPagoScreen()),
  GoRoute(path: '/test', builder: (context, state) => MobileOrderApp()),
]);
