# embed

Embed golang inside Flutter.

This has everything needed.

https://github.com/DimitarPetrov

- golang lib: https://github.com/DimitarPetrov/stegify
- flutter plugin that uses the golang lib: https://github.com/DimitarPetrov/stegify-flutter-plugin
- flutter app that uses the flutter plugin: https://github.com/DimitarPetrov/stegify-mobile


We are moving to a Foreground and Backgrond process model
- Foreground runs the FLutter Apps
- background singleton service runs the golang code for all networking.
- GRPC based IO between them.
