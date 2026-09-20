import { parseGuestInput } from './guest-list.mjs';

const initialGuests = ['ada', 'lin', 'maya', 'leo', 'noa', 'sam'];
const sampleInput = 'Ada\n ada \nLin';
const input = document.querySelector('#guest-input');
const error = document.querySelector('#input-error');
const list = document.querySelector('#guest-list');
input.value = sampleInput;

function render(guests, message) {
  list.replaceChildren(...guests.map(handle => {
    const card = document.createElement('li');
    card.className = 'guest-card';
    const avatar = document.createElement('span');
    avatar.className = 'avatar';
    avatar.setAttribute('aria-hidden', 'true');
    avatar.textContent = [...handle][0].toUpperCase();
    const name = document.createElement('h3');
    name.className = 'guest-name';
    name.textContent = handle;
    const detail = document.createElement('p');
    detail.className = 'guest-detail';
    detail.textContent = 'Demo guest';
    card.append(avatar, name, detail);
    return card;
  }));
  document.querySelector('#guest-count').textContent = String(guests.length);
  document.querySelector('#empty-state').hidden = guests.length > 0;
  document.querySelector('#board-status').textContent = message;
}

document.querySelector('#import-form').addEventListener('submit', event => {
  event.preventDefault();
  try {
    const guests = parseGuestInput(input.value);
    error.textContent = '';
    input.removeAttribute('aria-invalid');
    render(guests, `${guests.length} ${guests.length === 1 ? 'guest' : 'guests'} imported. This board stays in your browser.`);
  } catch (failure) {
    error.textContent = failure.message;
    input.setAttribute('aria-invalid', 'true');
    input.focus();
  }
});

document.querySelector('#reset-demo').addEventListener('click', () => {
  input.value = sampleInput;
  error.textContent = '';
  input.removeAttribute('aria-invalid');
  render(initialGuests, 'Demo reset. Ready for your next import.');
});

render(initialGuests, 'Six friendly faces to get things started.');
fetch('/version.json').then(response => response.json()).then(version => {
  document.querySelector('#source-version').textContent = `${version.branch} · ${version.commit}${version.dirty ? ' · working changes' : ''}`;
}).catch(() => { /* The guest board also works on an ordinary static server. */ });
