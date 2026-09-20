import { createServer } from 'node:http';
import { readFile } from 'node:fs/promises';
import { execFileSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { resolve } from 'node:path';

const root = fileURLToPath(new URL('.', import.meta.url));
const assets = new Map([
  ['/', ['index.html', 'text/html; charset=utf-8']],
  ['/index.html', ['index.html', 'text/html; charset=utf-8']],
  ['/styles.css', ['styles.css', 'text/css; charset=utf-8']],
  ['/app.mjs', ['app.mjs', 'text/javascript; charset=utf-8']],
  ['/guest-list.mjs', ['guest-list.mjs', 'text/javascript; charset=utf-8']],
]);

export function sourceVersion() {
  try {
    const git = args => execFileSync('git', args, { cwd: root, encoding: 'utf8', timeout: 2000, stdio: ['ignore', 'pipe', 'ignore'] }).trim();
    return { branch: git(['branch', '--show-current']) || 'detached', commit: git(['rev-parse', '--short=12', 'HEAD']), dirty: Boolean(git(['status', '--porcelain'])) };
  } catch {
    return { branch: 'unversioned', commit: 'unknown', dirty: true };
  }
}

export function createPreviewServer() {
  return createServer(async (request, response) => {
    response.setHeader('Cache-Control', 'no-store');
    response.setHeader('X-Content-Type-Options', 'nosniff');
    response.setHeader('Referrer-Policy', 'no-referrer');
    response.setHeader('Content-Security-Policy', "default-src 'self'; script-src 'self'; style-src 'self'; connect-src 'self'; img-src 'self'; object-src 'none'; base-uri 'none'; form-action 'none'; frame-ancestors 'none'");
    if (!['GET', 'HEAD'].includes(request.method)) {
      response.writeHead(405, { Allow: 'GET, HEAD' }); response.end(); return;
    }
    let path;
    try { path = new URL(request.url, 'http://localhost').pathname; } catch {
      response.writeHead(400); response.end(); return;
    }
    if (path === '/version.json') {
      response.writeHead(200, { 'Content-Type': 'application/json; charset=utf-8' });
      response.end(request.method === 'HEAD' ? undefined : JSON.stringify(sourceVersion())); return;
    }
    const asset = assets.get(path);
    if (!asset) { response.writeHead(404); response.end('Not found'); return; }
    try {
      const contents = await readFile(resolve(root, asset[0]));
      response.writeHead(200, { 'Content-Type': asset[1] });
      response.end(request.method === 'HEAD' ? undefined : contents);
    } catch { response.writeHead(500); response.end('Preview unavailable'); }
  });
}

if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  const port = Number(process.env.PORT || 4173);
  const host = process.env.HOST || '127.0.0.1';
  if (!Number.isInteger(port) || port < 1 || port > 65535) throw new Error('PORT must be between 1 and 65535.');
  const server = createPreviewServer();
  server.listen(port, host, () => console.log(`Guestboard preview: http://${host}:${port}`));
  for (const signal of ['SIGINT', 'SIGTERM']) process.on(signal, () => server.close(() => process.exit(0)));
}
