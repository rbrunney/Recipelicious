import 'dart:convert';
import 'dart:typed_data';
import 'package:basic_utils/basic_utils.dart';

class RSA {
  // Solution Found Here
  // https://www.appsloveworld.com/flutter/200/113/how-to-implement-rsa-encryption-in-dart-using-encrypt
  static String encrypt(String stringToEncrypt) {

    String publicKeyString = '-----BEGIN RSA PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAhhx2L91o+x4OtsYvJe6/QBlvdlQtiGQTX/CrZm5C/Pb+cu70VgKUkHmFFthJHdNbi963/an2sNqsuTZAvVJnFEImhgDnBB0AQ29ddmrTg5xJKIXH7Q0TThgRgnnFodb0+1mthHtgYnpdP3f4lIh+8HmAyrOekMQOqydhfYJmHsYZfJbDsOgvwlo3jgOsmfpMVn5pmIPLKFIcGAtMweHMu6pGSmL9cH0EauUSAXlFfEcNiZVGCA7jwIo3yC0vEmyc1f12/W9eQRiw0Doz318apwwnYCnYysuKUTxAuWGjS0GTv51k7fotn4hyjuUKy5emizn85CYd/F1vYsR8BipDqwIDAQAB\n-----END RSA PUBLIC KEY-----';

    // String Public Key To RSA Public Key
    var publicKey = CryptoUtils.rsaPublicKeyFromPem(publicKeyString);

    // Starting Cipher
    var cipher = AsymmetricBlockCipher('RSA/PKCS1');
    cipher.init(true, PublicKeyParameter<RSAPublicKey>(publicKey));

    // Converting into List<int>
    // Then Encode to Base64
    Uint8List output = cipher.process(Uint8List.fromList(utf8.encode(stringToEncrypt)));
    var base64EncodedText = base64Encode(output);
    return base64EncodedText;
  }
}