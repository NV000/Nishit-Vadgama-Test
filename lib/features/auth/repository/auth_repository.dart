import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/storage/secure_storage.dart';
import '../model/user_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<Either<String, UserModel>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return const Left('Sign in cancelled');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        return const Left('Google sign in failed');
      }

      final user = UserModel(
        id: firebaseUser.uid.hashCode,
        uid: firebaseUser.uid,
        name: firebaseUser.displayName ?? googleUser.displayName ?? 'User',
        email: firebaseUser.email ?? googleUser.email,
        mobile: firebaseUser.phoneNumber,
        photoUrl: firebaseUser.photoURL ?? googleUser.photoUrl,
        role: 'user',
      );

      if (googleAuth.idToken != null) {
        await SecureStorage.setAccessToken(googleAuth.idToken!);
      }
      await SecureStorage.setUserJson(user.toJsonString());

      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Authentication error: ${e.code}');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> logout() async {
    try {
      try {
        await _googleSignIn.signOut();
      } catch (_) {}
      try {
        await _firebaseAuth.signOut();
      } catch (_) {}
      await SecureStorage.clear();
      return const Right(true);
    } catch (e) {
      await SecureStorage.clear();
      return Left(e.toString());
    }
  }

  Future<UserModel?> getCachedUser() async {
    final currentUser = _firebaseAuth.currentUser;
    final json = await SecureStorage.getUserJson();
    final cached = (json != null && json.isNotEmpty) ? UserModel.fromJsonString(json) : null;

    if (currentUser != null) {
      return UserModel(
        id: currentUser.uid.hashCode,
        uid: currentUser.uid,
        name: currentUser.displayName ?? cached?.name ?? 'User',
        email: currentUser.email ?? cached?.email,
        mobile: currentUser.phoneNumber ?? cached?.mobile,
        photoUrl: currentUser.photoURL ?? cached?.photoUrl,
        role: 'user',
      );
    }

    return cached;
  }
}
