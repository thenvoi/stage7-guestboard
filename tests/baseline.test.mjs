import assert from 'node:assert/strict';
import test from 'node:test';
import { normalizeGuests, parseGuestInput } from '../guest-list.mjs';

test('normalizes one handle', () => assert.deepEqual(normalizeGuests([' Ada ']), ['ada']));
test('ignores blank handles', () => assert.deepEqual(normalizeGuests(['', '  ']), []));
test('preserves first-seen order of distinct handles', () => assert.deepEqual(normalizeGuests(['Lin', 'Ada']), ['lin', 'ada']));
test('parses CRLF input', () => assert.deepEqual(parseGuestInput('Ada\r\nLin'), ['ada', 'lin']));
test('caps import size', () => assert.throws(() => parseGuestInput('x'.repeat(4097)), /4,096/));
test('caps line count', () => assert.throws(() => parseGuestInput('\n'.repeat(100)), /100 lines/));
test('caps individual handle length', () => assert.throws(() => parseGuestInput('x'.repeat(41)), /41 characters/));
