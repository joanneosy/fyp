package util;

import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.security.SecureRandom;
import org.apache.commons.codec.binary.Base64;

public class HashCode {
    
    // The higher the number of iterations the more 
    // expensive computing the hash is for us and
    // also for an attacker.
    private final int iterations = 20*1000;
    private final int saltLen = 32;
    private final int desiredKeyLen = 256;

    // Computes a salted PBKDF2 hash of given plaintext
    // suitable for storing in a database. 
    // Empty are not supported. 
    public String generateSaltedHash(String toHash) throws Exception {
        byte[] salt = SecureRandom.getInstance("SHA1PRNG").generateSeed(saltLen);
        // store the salt with the password
        return Base64.encodeBase64String(salt) + "$" + hash(toHash, salt);
    }

    // Checks whether given plaintext corresponds 
    // to a stored salted hash
    public boolean check(String toCheck, String stored) throws Exception{
        String[] saltAndPass = stored.split("\\$");
        if (saltAndPass.length != 2) {
            throw new IllegalStateException(
                "The stored password have the form 'salt$hash'");
        }
        String hashOfInput = hash(toCheck, Base64.decodeBase64(saltAndPass[0]));
        return hashOfInput.equals(saltAndPass[1]);
    }

    // using PBKDF2 from Sun, an alternative is https://github.com/wg/scrypt
    // cf. http://www.unlimitednovelty.com/2012/03/dont-use-bcrypt.html
    private String hash(String toHash, byte[] salt) throws Exception {
        if (toHash == null || toHash.length() == 0)
            throw new IllegalArgumentException("Empty passwords are not supported.");
        SecretKeyFactory f = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
        SecretKey key = f.generateSecret(new PBEKeySpec(
            toHash.toCharArray(), salt, iterations, desiredKeyLen)
        );
        return Base64.encodeBase64String(key.getEncoded());
    }
    

}