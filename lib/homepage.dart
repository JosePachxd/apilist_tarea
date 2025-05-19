import 'package:flutter/material.dart';
import 'package:apilist/models/noticias.dart';
import 'package:apilist/services/services_app.dart';

class NoticiasScreen extends StatefulWidget {
  const NoticiasScreen({super.key});

  @override
  State<NoticiasScreen> createState() => _NoticiasScreenState();
}

class _NoticiasScreenState extends State<NoticiasScreen> {
  
  late Future<Noticias> futureNoticias;

  @override
  void initState() {
    super.initState();
    futureNoticias = NoticiaServices().fetchNoticias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 2, 255),
        foregroundColor: const Color.fromARGB(255, 233, 250, 0),
        centerTitle: true,
        title: const Text("NOTICIAS HOY..."),
      ),
      body: FutureBuilder<Noticias>(
        future: futureNoticias,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        futureNoticias = NoticiaServices().fetchNoticias();
                      });
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.articles.isEmpty) {
            return const Center(child: Text('No hay noticias disponibles'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.articles.length,
              itemBuilder: (context, index) {
                final article = snapshot.data!.articles[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    title: Text(
                      article.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        
                        if (article.description != null)
                          Text(article.description!)
                        else
                          const Text('No hay descripción disponible'),
                        const SizedBox(height: 8),
                        Text(
                          'Fuente: ${article.source.name}',
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    leading: article.urlToImage != null && article.urlToImage!.isNotEmpty
                        ? Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(article.urlToImage!),
                                fit: BoxFit.cover,
                                // Manejar errores de carga de imagen
                                onError: (exception, stackTrace) {
                                  print('Error cargando imagen: $exception');
                                },
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          )
                        : Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported),
                          ),
                    onTap: () {
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Noticia seleccionada: ${article.title}')),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}