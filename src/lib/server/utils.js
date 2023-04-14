import { env } from '$env/dynamic/private';
import { createCipheriv, pbkdf2Sync, randomBytes } from 'crypto';

const key = pbkdf2Sync(env.SECRET_KEY, randomBytes(16), 100000, 32, 'sha256');

/**
 *
 * @param {string} text
 */
export function encrypt(text) {
	const iv = randomBytes(16);
	const cipher = createCipheriv('aes-256-cbc', key, iv);
	let result = cipher.update(text, 'utf8', 'hex');
	result += cipher.final('hex');
	return iv.toString('hex') + result;
}
