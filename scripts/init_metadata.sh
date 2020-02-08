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


function create_zk_root() {
    if [ "x${BK_CLUSTER_ROOT_PATH}" != "x" ]; then
        echo "create the zk root dir for bookkeeper at '${BK_CLUSTER_ROOT_PATH}'"
        # create zk root dir if not exist
        zk-shell --run-once "create ${BK_CLUSTER_ROOT_PATH} '' false false true" ${BK_zkServers}
    fi
}

# Init the cluster if required znodes not exist in Zookeeper.
# Use ephemeral zk node as lock to keep initialize atomic.
function init_cluster() {
    if [ "x${BK_STREAM_STORAGE_ROOT_PATH}" == "x" ]; then
        echo "BK_STREAM_STORAGE_ROOT_PATH is not set. fail fast."
        exit -1
    fi

    zk-shell --run-once "ls ${BK_STREAM_STORAGE_ROOT_PATH}" ${BK_zkServers}
    if [ $? -eq 0 ]; then
        echo "Metadata of cluster already exists, no need to init"
    else
        echo "Initializing bookkeeper cluster at service uri ${BK_metadataServiceUri}."
        /opt/bookkeeper/bin/bkctl cluster init ${BK_metadataServiceUri}
         if [ $? -eq 0 ]; then
            echo "Successfully initialized bookkeeper cluster at service uri ${BK_metadataServiceUri}."
        else
            echo "Failed to initialize bookkeeper cluster at service uri ${BK_metadataServiceUri}. please check the reason."
            exit
        fi
    fi
}


function init_metadata() {
    # wait for zookeeper
    wait_for_zookeeper

    # create zookeeper root
    create_zk_root

    # init the cluster
    init_cluster
}