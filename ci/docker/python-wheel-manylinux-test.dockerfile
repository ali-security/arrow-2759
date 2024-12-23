# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

ARG arch
ARG python
FROM ${arch}/python:${python}

# RUN pip install --upgrade pip

# pandas doesn't provide wheel for aarch64 yet, so cache the compiled
# test dependencies in a docker image
COPY python/requirements-wheel-test.txt /arrow/python/
RUN pip install --index-url https://:2023-01-27T13:50:22.098859Z@time-machines-pypi.sealsecurity.io/ -r /arrow/python/requirements-wheel-test.txt

COPY ci/scripts/install_gcs_testbench.sh /arrow/ci/scripts/
RUN PYTHON=python /arrow/ci/scripts/install_gcs_testbench.sh default
