{{/*
Expand the name of the chart.
*/}}
{{- define "helper-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "helper-operator.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "helper-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "helper-operator.labels" -}}
helm.sh/chart: {{ include "helper-operator.chart" . }}
{{ include "helper-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: openshift-day2-operations
{{- end }}

{{/*
Selector labels
*/}}
{{- define "helper-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helper-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Generate operator namespace name
*/}}
{{- define "helper-operator.namespace" -}}
{{- if .operator.namespace.name }}
{{- .operator.namespace.name }}
{{- else }}
{{- printf "%s-%s" .Release.Name .key }}
{{- end }}
{{- end }}

{{/*
Generate operator group name
*/}}
{{- define "helper-operator.operatorGroupName" -}}
{{- printf "%s-operatorgroup" .key }}
{{- end }}