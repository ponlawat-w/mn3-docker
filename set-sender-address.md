# Setting Mail Sender Address

1.
```bash
docker exec -it arango arangosh
```

2.
```bash
db._useDatabase('moodlenet__email-service')
```

3.
```bash
db._update(db._collection('Moodlenet_simple_key_value_store').firstExample('_key', 'mailerCfg::'), { value: { defaultFrom: 'noreply@shisa.app', defaultReplyTo: 'noreply@shisa.app' } })
```
