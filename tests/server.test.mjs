import assert from 'node:assert/strict';
import { after, before, test } from 'node:test';
import { createPreviewServer } from '../server.mjs';

let server, origin;
before(async () => {
  server = createPreviewServer();
  await new Promise(resolve => server.listen(0, '127.0.0.1', resolve));
  origin = `http://127.0.0.1:${server.address().port}`;
});
after(async () => { await new Promise(resolve => server.close(resolve)); });
test('serves the app with no-store and a restrictive CSP', async () => {
  const response = await fetch(origin);
  assert.equal(response.status, 200);
  assert.equal(response.headers.get('cache-control'), 'no-store');
  assert.match(response.headers.get('content-security-policy'), /frame-ancestors 'none'/);
  assert.match(await response.text(), /guest-input/);
});
test('only serves explicit preview assets, never repository or role files', async () => {
  for (const path of ['/.git/config', '/.env', '/roles/lead.md', '/server.mjs', '/tests/baseline.test.mjs', '/%2e%2e/package.json']) {
    assert.equal((await fetch(`${origin}${path}`)).status, 404, path);
  }
});
test('has no write API', async () => assert.equal((await fetch(origin, { method: 'POST', body: 'no' })).status, 405));
test('HEAD sends no body', async () => assert.equal(await (await fetch(origin, { method: 'HEAD' })).text(), ''));
test('version metadata has no machine path or remote URL', async () => {
  const body = await (await fetch(`${origin}/version.json`)).json();
  assert.deepEqual(Object.keys(body).sort(), ['branch', 'commit', 'dirty']);
  assert.equal(typeof body.dirty, 'boolean');
});
