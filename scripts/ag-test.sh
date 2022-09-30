#!/bin/sh

if [ -n "$DEBUG" ]; then
  set -x
fi
/bin/bash
#mvn test -Djitsi-meet.instance.url="https://meet.jit.si" -Djitsi-meet.tests.toRun="MuteTest"