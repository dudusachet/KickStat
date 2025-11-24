import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kickstat/services/analytics_service.dart';
import 'package:kickstat/screens/login_screen.dart';
import 'package:kickstat/screens/home_screen.dart';
// import 'firebase_options.dart'; // Será gerado pelo flutterfire configure

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // A inicialização do Firebase deve ser feita após a configuração do projeto
  // com o comando 'flutterfire configure' e a criação do arquivo firebase_options.dart.
  // Por enquanto, usaremos uma inicialização básica.
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  
  // Inicialização temporária para simulação
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final analyticsService = AnalyticsService();
    
    return MaterialApp(
      title: 'KickStat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Observador do Analytics para rastrear navegação
      navigatorObservers: [
        analyticsService.getAnalyticsObserver(),
      ],
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Widget que gerencia autenticação
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Se está carregando
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        // Se tem erro
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Erro: ${snapshot.error}'),
            ),
          );
        }
        
        // Se está autenticado, vai para home
        if (snapshot.hasData) {
          return const HomeScreen();
        }
        
        // Se não está autenticado, vai para login
        return const LoginScreen();
      },
    );
  }
}


