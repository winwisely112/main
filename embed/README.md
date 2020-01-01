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

Next Steps are: We are moving to a Foreground and Background process model and so embedding is not needed.
- Foreground runs the FLutter Apps
- Background singleton service runs the golang code for all networking.
- GRPC based IO between them using IPC mechanism. Needs Research on implementation aspects for Mobile and Desktop
  - Desktop will be easy
  - Mobile not so easy :)
  - Or just use a GRPC socket and so we dont have to get into the weeds of IPC.
    - Often used approach
    - Will be secure if we use a Cert between Foreground and Background. Can be bootstrapped from the Server on startup 

How this affects a Dev ?
- We are doing this for UX and Security reasons. 

- The Background process ( aka Service ) runs the golang code that does all the Networking and other fancy stuff.

    - Will be putting in there fancy Search indexer, KV Store, VPN and other goodies that Flutter cant do. Its a nice clean approach.

- For a Flutter Dev:

    - The background process is best thought of as a PUB SUB topic based Network.

    - You are essentially working at the Domain Model layer and so your models do not have to match one to one to the PUB SUB topics. 

    - You can remap them how you want. Its gives the Flutter app the ability to compose their Domain Models to not be a one for one match as the PUB SUB topics in the network.

    - When a record changes in the Background process it wil just tell the Flutter foreground app over th GRPC stream.

    - We can set it up so the common Flutter code just puts it directly into HIVE, and so you just forget about it.


