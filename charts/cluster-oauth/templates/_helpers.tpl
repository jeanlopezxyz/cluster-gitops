{{/*
Expand the name of the chart.
*/}}
{{- define "cluster-oauth.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "cluster-oauth.fullname" -}}
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
{{- define "cluster-oauth.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cluster-oauth.labels" -}}
helm.sh/chart: {{ include "cluster-oauth.chart" . }}
{{ include "cluster-oauth.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cluster-oauth.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cluster-oauth.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Generate htpasswd data from users array
*/}}
{{- define "cluster-oauth.htpasswdData" -}}
{{- if .Values.htpasswd.data -}}
{{- .Values.htpasswd.data }}
{{- else if .Values.htpasswd.users -}}
{{- $htpasswdContent := "" -}}
{{- range .Values.htpasswd.users -}}
{{- $htpasswdContent = printf "%s%s:%s\n" $htpasswdContent .username (htpasswd .username .password) -}}
{{- end -}}
{{- $htpasswdContent | b64enc }}
{{- end -}}
{{- end }}