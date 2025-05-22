package packClass;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class SHA256 {

	public static String generateSHA(String a) throws NoSuchAlgorithmException {
		MessageDigest digest = MessageDigest.getInstance("SHA-256");
		byte[] encoded = digest.digest(a.getBytes());
		StringBuilder hex = new StringBuilder();
		for (byte b : encoded) {
			String code = Integer.toHexString(0xff & b);
			if (code.length() == 1) {
				hex.append('0');
			}
			hex.append(code);
		}

		return hex.toString();
	}
}
