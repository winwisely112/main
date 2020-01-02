# CRDT

A simple test harness for File synchronisation between users.

Background: https://blog.textile.io/introducing-textiles-threads-protocol/

Is event based and is only for files, and not file content changes.

- For file content change a OT (Operational Transform) pattern is needed which we already have in Docs modules where the doc changes are modeled as OT.

Uses IPFS as the P2P medium.

Uses go-threads for the CRDT consistency.

