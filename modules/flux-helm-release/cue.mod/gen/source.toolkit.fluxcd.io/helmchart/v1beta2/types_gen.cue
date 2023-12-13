// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni vendor crd -f https://github.com/fluxcd/source-controller/releases/download/v1.2.2/source-controller.crds.yaml

package v1beta2

import "strings"

// HelmChart is the Schema for the helmcharts API.
#HelmChart: {
	// APIVersion defines the versioned schema of this representation
	// of an object. Servers should convert recognized schemas to the
	// latest internal value, and may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion: "source.toolkit.fluxcd.io/v1beta2"

	// Kind is a string value representing the REST resource this
	// object represents. Servers may infer this from the endpoint
	// the client submits requests to. Cannot be updated. In
	// CamelCase. More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind: "HelmChart"
	metadata!: {
		name!: strings.MaxRunes(253) & strings.MinRunes(1) & {
			string
		}
		namespace!: strings.MaxRunes(63) & strings.MinRunes(1) & {
			string
		}
		labels?: {
			[string]: string
		}
		annotations?: {
			[string]: string
		}
	}

	// HelmChartSpec specifies the desired state of a Helm chart.
	spec!: #HelmChartSpec
}

// HelmChartSpec specifies the desired state of a Helm chart.
#HelmChartSpec: {
	accessFrom?: {
		// NamespaceSelectors is the list of namespace selectors to which
		// this ACL applies. Items in this list are evaluated using a
		// logical OR operation.
		namespaceSelectors: [...{
			// MatchLabels is a map of {key,value} pairs. A single {key,value}
			// in the matchLabels map is equivalent to an element of
			// matchExpressions, whose key field is "key", the operator is
			// "In", and the values array contains only "value". The
			// requirements are ANDed.
			matchLabels?: {
				[string]: string
			}
		}]
	}

	// Chart is the name or path the Helm chart is available at in the
	// SourceRef.
	chart: string

	// Interval at which the HelmChart SourceRef is checked for
	// updates. This interval is approximate and may be subject to
	// jitter to ensure efficient use of resources.
	interval: =~"^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"

	// ReconcileStrategy determines what enables the creation of a new
	// artifact. Valid values are ('ChartVersion', 'Revision'). See
	// the documentation of the values for an explanation on their
	// behavior. Defaults to ChartVersion when omitted.
	reconcileStrategy?: "ChartVersion" | "Revision" | *"ChartVersion"

	// SourceRef is the reference to the Source the chart is available
	// at.
	sourceRef: {
		// APIVersion of the referent.
		apiVersion?: string

		// Kind of the referent, valid values are ('HelmRepository',
		// 'GitRepository', 'Bucket').
		kind: "HelmRepository" | "GitRepository" | "Bucket"

		// Name of the referent.
		name: string
	}

	// Suspend tells the controller to suspend the reconciliation of
	// this source.
	suspend?: bool

	// ValuesFile is an alternative values file to use as the default
	// chart values, expected to be a relative path in the SourceRef.
	// Deprecated in favor of ValuesFiles, for backwards
	// compatibility the file specified here is merged before the
	// ValuesFiles items. Ignored when omitted.
	valuesFile?: string

	// ValuesFiles is an alternative list of values files to use as
	// the chart values (values.yaml is not included by default),
	// expected to be a relative path in the SourceRef. Values files
	// are merged in the order of this list with the last file
	// overriding the first. Ignored when omitted.
	valuesFiles?: [...string]

	// Verify contains the secret name containing the trusted public
	// keys used to verify the signature and specifies which provider
	// to use to check whether OCI image is authentic. This field is
	// only supported when using HelmRepository source with spec.type
	// 'oci'. Chart dependencies, which are not bundled in the
	// umbrella chart artifact, are not verified.
	verify?: {
		// MatchOIDCIdentity specifies the identity matching criteria to
		// use while verifying an OCI artifact which was signed using
		// Cosign keyless signing. The artifact's identity is deemed to
		// be verified if any of the specified matchers match against the
		// identity.
		matchOIDCIdentity?: [...{
			// Issuer specifies the regex pattern to match against to verify
			// the OIDC issuer in the Fulcio certificate. The pattern must be
			// a valid Go regular expression.
			issuer: string

			// Subject specifies the regex pattern to match against to verify
			// the identity subject in the Fulcio certificate. The pattern
			// must be a valid Go regular expression.
			subject: string
		}]

		// Provider specifies the technology used to sign the OCI
		// Artifact.
		provider: "cosign" | *"cosign"
		secretRef?: {
			// Name of the referent.
			name: string
		}
	}

	// Version is the chart version semver expression, ignored for
	// charts from GitRepository and Bucket sources. Defaults to
	// latest when omitted.
	version?: string | *"*"
}
