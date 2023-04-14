<script>
	import { PUBLIC_APP_NAME } from '$env/static/public';

	export let data;
</script>

<svelte:head>
	<title>{PUBLIC_APP_NAME}</title>
</svelte:head>

<main>
	<h1>Welcome to {PUBLIC_APP_NAME}</h1>
	<p>Visit <a href="https://kit.svelte.dev">kit.svelte.dev</a> to read the documentation</p>
	<pre>{data.secret}</pre>
</main>
