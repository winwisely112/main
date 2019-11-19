# Services 
The Services layer creates App level services that are required for functions of apps and modules.
The module provides following classes.

| Class        | Function           | 
|-------------|-------------|
|`StorageService`| This class intializes cache and Hive instance. It also provides `get` access to certain app-level variables. This is yet to be decided. |
|`NetworkService`| This class intialises Network connection. It provides basic querying features. Work in Progress. |
|`UserService`| This class caches the `users` table. This is only provided as an example on how to structure the bloc provider with network and storage provider. Work in Progress. |
|`AuthUserService`| This is a provider specific to current logged in user. Work in Progress. |
