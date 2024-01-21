import { readFileSync, existsSync } from 'fs';
import { kvStore } from './kvStore.mjs';

(async() => {
  if (!existsSync('./KV_TMP.json')) return;
  console.log('### Restoring built key-value store... ###');
  const data = JSON.parse(readFileSync('./KV_TMP.json'));
  for (const record of data) {
    const current = await kvStore.get(record.type, record.key);
    if (current.value) continue;
    await kvStore.set(record.type, record.key, record.val);
  }
  console.log('### Built key-value store restored. ###');
})();
