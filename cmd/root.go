// Copyright 2019 Red Hat, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package main

import (
	"github.com/spf13/cobra"
	istioctl "istio.io/istio/istioctl/cmd"
)

func getRootCmd(args []string) *cobra.Command {

	rootCmd := &cobra.Command{
		Use:               "istio",
		Short:             "kubectl plugin to control Istio",
		SilenceUsage:      true,
		DisableAutoGenTag: true,
		Long: `Istio configuration command line utility for service operators to
debug and diagnose their Istio mesh.
`,
		//PersistentPreRunE: istioPersistentPreRunE,
	}

	rootCmd.SetArgs(args)
	rootCmd.AddCommand(istioctl.GetRootCmd(args))

	experimentalCmd := &cobra.Command{
		Use:     "experimental",
		Aliases: []string{"x", "exp"},
		Short:   "Experimental commands that may be modified or deprecated",
	}
	rootCmd.AddCommand(experimentalCmd)

	return rootCmd
}
