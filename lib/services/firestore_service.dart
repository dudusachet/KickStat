import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Criar documento
  Future<void> createDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _db.collection(collection).doc(docId).set(data);
    } catch (e) {
      throw 'Erro ao criar documento: \$e';
    }
  }

  // Adicionar documento (ID automático)
  Future<String> addDocument({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    try {
      DocumentReference docRef = await _db.collection(collection).add(data);
      return docRef.id;
    } catch (e) {
      throw 'Erro ao adicionar documento: \$e';
    }
  }

  // Ler documento
  Future<DocumentSnapshot> getDocument({
    required String collection,
    required String docId,
  }) async {
    try {
      return await _db.collection(collection).doc(docId).get();
    } catch (e) {
      throw 'Erro ao buscar documento: \$e';
    }
  }

  // Stream de documento
  Stream<DocumentSnapshot> streamDocument({
    required String collection,
    required String docId,
  }) {
    return _db.collection(collection).doc(docId).snapshots();
  }

  // Buscar coleção
  Future<QuerySnapshot> getCollection({
    required String collection,
    Query Function(Query)? queryBuilder,
  }) async {
    try {
      Query query = _db.collection(collection);
      if (queryBuilder != null) {
        query = queryBuilder(query);
      }
      return await query.get();
    } catch (e) {
      throw 'Erro ao buscar coleção: \$e';
    }
  }

  // Stream de coleção
  Stream<QuerySnapshot> streamCollection({
    required String collection,
    Query Function(Query)? queryBuilder,
  }) {
    Query query = _db.collection(collection);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    return query.snapshots();
  }

  // Atualizar documento
  Future<void> updateDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _db.collection(collection).doc(docId).update(data);
    } catch (e) {
      throw 'Erro ao atualizar documento: \$e';
    }
  }

  // Deletar documento
  Future<void> deleteDocument({
    required String collection,
    required String docId,
  }) async {
    try {
      await _db.collection(collection).doc(docId).delete();
    } catch (e) {
      throw 'Erro ao deletar documento: \$e';
    }
  }

  // Batch write
  WriteBatch batch() => _db.batch();

  // Transaction
  Future<T> runTransaction<T>(
    Future<T> Function(Transaction) transactionHandler,
  ) async {
    return await _db.runTransaction(transactionHandler);
  }
}
