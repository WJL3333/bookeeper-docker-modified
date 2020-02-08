#!/usr/bin/env bash
#
#/**
# * Copyright 2007 The Apache Software Foundation
# *
# * Licensed to the Apache Software Foundation (ASF) under one
# * or more contributor license agreements.  See the NOTICE file
# * distributed with this work for additional information
# * regarding copyright ownership.  The ASF licenses this file
# * to you under the Apache License, Version 2.0 (the
# * "License"); you may not use this file except in compliance
# * with the License.  You may obtain a copy of the License at
# *
# *     http://www.apache.org/licenses/LICENSE-2.0
# *
# * Unless required by applicable law or agreed to in writing, software
# * distributed under the License is distributed on an "AS IS" BASIS,
# * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# * See the License for the specific language governing permissions and
# * limitations under the License.
# */

source ${SCRIPTS_DIR}/common.sh

function wait_for_zookeeper() {
    echo "wait for zookeeper"
    until zk-shell --run-once "ls /" ${BK_zkServers}; do sleep 5; done
}

function wait_for_metadata() {
    echo "wait for metadata"
    until zk-shell --run-once "ls ${BK_STREAM_STORAGE_ROOT_PATH}" ${BK_zkServers}; do sleep 5; done
}

function init_bookie() {

    # create dirs if they don't exist
    create_bookie_dirs

    # wait zookeeper to run
    wait_for_zookeeper

    # wait until metadata ok in zk
    wait_for_metadata
}