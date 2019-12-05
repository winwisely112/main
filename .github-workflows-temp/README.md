flutter web
https://github.com/rodydavis/personal-website/blob/master/.github/workflows/main.yml


## CI

0. Tag the code. See the main make file

1. Create a Release when code is tagged:
https://github.com/actions/create-release

SO first a dev must create a new tag and push to the repo.
Then build the code and package and release
Then other processes can listen for the release event and auto deploy.

Cloudrun looks perfect because you can run tons of versions


