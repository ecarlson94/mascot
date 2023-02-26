#!/bin/bash

flutter test --coverage --machine > test-report.json
lcov --remove coverage/lcov.info \
    '*/test/*' \
    '*/*.g.dart' \
    '*/generated_plugin_registrant.dart' -o coverage/lcov.info
