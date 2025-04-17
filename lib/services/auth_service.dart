import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Signup with email & role
  Future<User?> signUp(String email, String password, String role) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await _db.collection('users').doc(userCredential.user!.uid).set({'role': role});
    return userCredential.user;
  }

  // Login
  Future<User?> signIn(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  // Get role
  Future<String?> getUserRole(String uid) async {
    final snapshot = await _db.collection('users').doc(uid).get();
    return snapshot.data()?['role'];
  }

  // Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
