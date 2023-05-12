#!/bin/bash

flutter pub get
cd web/js
npm install
browserify index.js -o bundle.js
cd ../..
