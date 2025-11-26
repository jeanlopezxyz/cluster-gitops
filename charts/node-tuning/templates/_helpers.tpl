{{/*
Expand the name of the chart.
*/}}
{{- define "node-tuning.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "node-tuning.fullname" -}}
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
{{- define "node-tuning.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "node-tuning.labels" -}}
helm.sh/chart: {{ include "node-tuning.chart" . }}
{{ include "node-tuning.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "node-tuning.selectorLabels" -}}
app.kubernetes.io/name: {{ include "node-tuning.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Generate kubelet configuration for worker nodes
*/}}
{{- define "node-tuning.workerKubeletConfig" -}}
apiVersion: v1
kind: kubelet
{{- if .Values.maxPods.enabled }}
maxPods: {{ .Values.maxPods.worker }}
{{- end }}
{{- if .Values.systemReserved.enabled }}
systemReserved:
  cpu: "{{ .Values.systemReserved.worker.cpu }}"
  memory: "{{ .Values.systemReserved.worker.memory }}"
  ephemeral-storage: "{{ .Values.systemReserved.worker.ephemeral_storage }}"
{{- end }}
{{- end }}

{{/*
Generate kubelet configuration for master nodes
*/}}
{{- define "node-tuning.masterKubeletConfig" -}}
apiVersion: v1
kind: kubelet
{{- if .Values.maxPods.enabled }}
maxPods: {{ .Values.maxPods.master }}
{{- end }}
{{- if .Values.systemReserved.enabled }}
systemReserved:
  cpu: "{{ .Values.systemReserved.master.cpu }}"
  memory: "{{ .Values.systemReserved.master.memory }}"
  ephemeral-storage: "{{ .Values.systemReserved.master.ephemeral_storage }}"
{{- end }}
{{- end }}