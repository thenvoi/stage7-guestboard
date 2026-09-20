/** Normalize synthetic guest handles, preserving first-seen order. */
export function normalizeGuests(handles) {
  return [...new Set(handles)].map(handle => handle.trim().toLowerCase()).filter(Boolean);
}

export function parseGuestInput(input) {
  if (input.length > 4096) throw new Error('Keep your import under 4,096 characters.');
  const handles = input.split(/\r?\n/);
  if (handles.length > 100) throw new Error('Import up to 100 lines at a time.');
  if (handles.some(handle => handle.trim().length > 40)) {
    throw new Error('Keep each guest handle under 41 characters.');
  }
  return normalizeGuests(handles);
}
