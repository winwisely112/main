# synchronisation

What happens when you network partitioned but want to still mutate your data ?

You need a way to synchronise changes with all other parties that are also working on that same data.

This is a classic Time / Space domain problem of eventual consistency

Patterns:
- Operational Transforms
- CRDT

Anti Patterns:
- RAFT is does not solve the synch problem. Its for real time replication and new Master election. There is onyl one master with RAFT.
- PAXOS has the same constructs as RAFT.
