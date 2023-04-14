import { encrypt } from '$lib/server/utils';

export async function load() {
	const secret = encrypt('my-secret-value');
	return { secret };
}
