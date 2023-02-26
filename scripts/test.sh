#!/bin/bash

flutter test --coverage --machine > test-report.json
lcov --remove coverage/lcov.info \
    '*/test/*' \
    '*/*.g.dart' \
    '*/*_state.dart' \
    '*/*_event.dart' \
    '*/entity.dart' \
    '*/error.dart' \
    '*/generated_plugin_registrant.dart' -o coverage/lcov.info
