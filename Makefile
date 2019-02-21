## Copyright 2019 Red Hat, Inc.
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.

default: build

GOBINARY ?= go
EXE = kubectl-istio
HUB ?= docker.io/maistra
TAG ?= latest

clean:
	rm -f ./cmd/${EXE}

LDFLAGS = -extldflags -static
LD_EXTRAFLAGS = -X github.com/maistra/kubectl-istio-plugin/vendor/istio.io/istio/pkg/version.buildVersion=BORA
#LD_EXTRAFLAGS = -X istio.io/istio/pkg/version.Info=BORA

build:
	CGO_ENABLED=0 ${GOBINARY} build -o ./cmd/${EXE} -ldflags "${LDFLAGS} ${LD_EXTRAFLAGS}" ./cmd/...

image: build
	cp ./cmd/${EXE} container/ && \
	cd container && \
	docker build -t ${HUB}/kubectl-istio-plugin:${TAG} .

push: image
	docker push ${HUB}/kubectl-istio-plugin:${TAG}
