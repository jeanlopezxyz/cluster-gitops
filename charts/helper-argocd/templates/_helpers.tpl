{{/*
Expand the name of the chart.
*/}}
{{- define "helper-argocd.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "helper-argocd.fullname" -}}
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
{{- define "helper-argocd.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "helper-argocd.labels" -}}
helm.sh/chart: {{ include "helper-argocd.chart" . }}
{{ include "helper-argocd.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: openshift-day2-operations
{{- end }}

{{/*
Selector labels
*/}}
{{- define "helper-argocd.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helper-argocd.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Generate Application name
*/}}
{{- define "helper-argocd.appName" -}}
{{- printf "%s-%s" .Release.Name .key }}
{{- end }}

{{/*
Generate sync policy for applications
*/}}
{{- define "helper-argocd.syncPolicy" -}}
{{- if .app.syncPolicy }}
syncPolicy:
{{- toYaml .app.syncPolicy | nindent 2 }}
{{- else }}
syncPolicy:
{{- toYaml .global.syncPolicy | nindent 2 }}
{{- end }}
{{- end }}