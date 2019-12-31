# embed

Embed golang inside Flutter.

Why ?

- Flutter is great at GUI
- Golang is great at networking.

Basic example for bring up that has everything needed.

https://github.com/DimitarPetrov

- golang lib: https://github.com/DimitarPetrov/stegify
- flutter plugin that uses the golang lib: https://github.com/DimitarPetrov/stegify-flutter-plugin
- flutter app that uses the flutter plugin: https://github.com/DimitarPetrov/stegify-mobile

Next Steps are:
We are moving to a Foreground and Backgrond process model
- Foreground runs the FLutter Apps
- background singleton service runs the golang code for all networking.
- GRPC based IO between them.
