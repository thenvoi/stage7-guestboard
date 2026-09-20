import assert from 'node:assert/strict';
import test from 'node:test';
import { normalizeGuests, parseGuestInput } from '../guest-list.mjs';

// This is an executable acceptance contract. It intentionally fails on the frozen baseline.
test('deduplicates case and whitespace variants', () => {
  assert.deepEqual(normalizeGuests(['Ada', ' ada ', 'ADA']), ['ada']);
});
test('the audience import has two guests, in first-seen order', () => {
  assert.deepEqual(parseGuestInput('Ada\n ada \nLin\n'), ['ada', 'lin']);
});
