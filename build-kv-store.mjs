import { writeFileSync } from 'fs';

let DATA = [];

const get = (type, key) => new Promise(resolve => {
  for (const record of DATA) if (record.type === type && record.key === key) return resolve({ value: record.val });
  return resolve({ value: undefined });
});

const set = (type, key, val) => new Promise(resolve => {
  let found = false;
  for (const record of DATA) if (record.type === type && record.key === key) {
    resolve({ old: { value: record.val } });
    record.val = val;
    found = true;
    break;
  }
  if (!found) {
    DATA.push({ type, key, val });
    resolve({ old: { value: undefined } });
  }
  writeFileSync('/app/KV_TMP.json', JSON.stringify(DATA));
});

const unset = (type, key) => new Promise(resolve => {
  const record = get(type, key);
  DATA = DATA.filter(x => !(x.type === type && x.key === key));
  writeFileSync('/app/KV_TMP.json', JSON.stringify(DATA));
  resolve({ old: { value: record.val } });
});

export default function () {
  return { get, set, unset };
};
