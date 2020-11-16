%title Going beyond Helm: How to use Jsonnet and Tanka to bulletproof your Kubernetes manifests
%author Jarosław Łukow && Wojciech Urbański / Nine Fives Labs
%date 2020-11-17

# Going beyond Helm: how to use Jsonnet and Tanka to bulletproof your Kubernetes manifests

## Jarosław Łukow && Wojciech Urbański

DevOpsDays Warsaw 2020 x Nine Fives Labs

---

# Who are we?

**Jarosław** works as a CI/CD engineer and consultant. He builds, packages, releases and deploys software on different kinds of infrastructure, from bare-metal machines through private to public clouds. Infrastructure as code, configuration as code, automation and integration are the tools of his trade. As a fan of open-source software and communities, he enjoys sharing his knowledge and experience with others, now also as a member of the Nine Fives Labs DevOps collective.

**Wojciech** is a DevOps Engineer, working on cloud-based and cloud-directed solutions. Currently, he's getting in-depth knowledge of Kubernetes, which he shares through talks and trainings. He enjoys speaking and helping people learn almost as much as he enjoys learning new things himself.

**Nine Fives Labs** is a group of people interested in automation, infrastructure, software development processes and networking. We speak everything that is cloud native, defined as code and automated. We run this blog and a YouTube channel to share our interests and ideas.

---

# Workshop agenda

0. Setup your environment!
1. Templating data in a text-based world - Why not?
2. Taming Kubernetes without templating, by using Jsonnet code and Tanka
3. But I don't want to (or can't) leave Helm!
4. It's not all rainbows and butterflies...
5. What else is there?

---

# Rules of conduct:

0. Before we proceed with the *work* -shop, we will explain the concepts briefly (yes, slides)
1. Afterwards, we will proceed with the tasks, showing and explaining as we go
2. If you're following with the tasks, let us know when you have a problem (raise a hand!)
3. Everything we do will be stored in a github repo for later.

---

# Ready, set...

`kind create cluster --name workshop`

---

# Templating hell (1)

Programming in Ansible templates (jinja2)

```jinja2
---
{% for k,v in instances.iteritems() -%}
  {%- for role in ['openstack_control', 'openstack_network', 'openstack_compute', 'vrouter', 'openstack_monitoring', 'openstack_storage', 'openstack'] -%}
    {%- if v.roles is defined and v.roles[role] is defined and v.roles[role] is mapping() and v.roles[role]|length() > 0 -%}
      {%- if hostvars[inventory_hostname].tmp_host is defined and v.ip == hostvars[inventory_hostname]['tmp_host'] -%}
        {%- for a,b in v.roles[role].iteritems() -%}
          {%- set excludes = ['PHYSICAL_INTERFACE', 'network_interface', 'kolla_internal_address', 'kolla_external_vip_interface', 'QOS_LOGICAL_QUEUES'] -%}
          {%- if a not in excludes -%}
            {%- print a + ': ' + b|string() + '\n' -%}
          {%- endif -%}
        {%- endfor -%}
      {%- endif -%}
    {%- endif -%}
  {%- endfor -%}
{%- endfor %}

kolla_internal_address: {{ host_internal_address }}
network_interface: {{ host_internal_interface }}
kolla_external_vip_interface: {{ host_external_interface }}
```

[contrail-ansible-deployer](https://github.com/Juniper/contrail-ansible-deployer/blob/R5.0/playbooks/roles/create_openstack_config/templates/host_vars.yml.j2)

---

# Templating hell (2)

Programming XML in Helm Templates

```golang
config.xml: |-
    <?xml version='1.0' encoding='UTF-8'?>
    <hudson>
      <disabledAdministrativeMonitors/>
{{- if .Values.master.imageTag }}
      <version>{{ .Values.master.imageTag }}</version>
{{- else }}
      <version>{{ .Values.master.tag }}</version>
{{- end }}
      <numExecutors>{{ .Values.master.numExecutors }}</numExecutors>
      <mode>{{ .Values.master.executorMode }}</mode>
      <useSecurity>{{ .Values.master.useSecurity }}</useSecurity>
{{ .Values.master.authorizationStrategy | indent 6 }}
{{ .Values.master.securityRealm | indent 6 }}
      <disableRememberMe>{{ .Values.master.disableRememberMe }}</disableRememberMe>
      <projectNamingStrategy class="jenkins.model.ProjectNamingStrategy$DefaultProjectNamingStrategy"/>
      <workspaceDir>${JENKINS_HOME}/workspace/${ITEM_FULLNAME}</workspaceDir>
      <buildsDir>${ITEM_ROOTDIR}/builds</buildsDir>
{{- if .Values.master.enableRawHtmlMarkupFormatter }}
      <markupFormatter class="hudson.markup.RawHtmlMarkupFormatter" plugin="antisamy-markup-formatter">
        <disableSyntaxHighlighting>true</disableSyntaxHighlighting>
      </markupFormatter>
{{- else }}
      <markupFormatter class="hudson.markup.EscapedMarkupFormatter"/>
{{- end }}
      <jdks/>
```

[Jenkins Helm Chart](https://github.com/helm/charts/blob/master/stable/jenkins/templates/config.yaml)

---

# What other traps wait for us when overtemplating things?

---

# So, we're putting logic (code) into templates (text) to represent the data (from other text) as text.

Then we load it into an API which parses the text to create an object!

Makes sense? No?

---

# Jsonnet - putting the data first

A data templating language for app and tool developers

- Generate config data
- Side-effect free
- Organize, simplify, unify
- Manage sprawling config

Born at Google as a "20% project" - Nowadays used in various configuration management tools.

Extends JSON by means of:

- functions
- libraries
- easy patching of objects
- multiple ways of referencing different objects.

---

# Using Jsonnet to manage Kubernetes

Kubernetes = a bunch of objects to manage
objects = data structures
to manage = store as code

## Next steps:

1. Learn Jsonnet
2. See it in action (using Tanka)
3. ...
4. Profit!

---

# Let's get to work!

https://github.com/ninefiveslabs/workshop-dod2020-warsaw

---

---

# Tanka vs Helm - The Lowlights

## General Jsonnet

* Pretty low popularity
  * Less bugs fixed
  * Less readily available components
  * Less related content on the Net
* Doesn't solve the most complex scenarios
* Dependency management subjectively worse than in other languages
* Pretty high entry barrier (a new programming language)

## Tanka VS Helm

* (+) Built-in diff capabilities
* (+) Environment-first focus
* (-) No release history
* (-) No introspective into the deployments

---

# Jsonnet outside of Tanka

* Alternative Kubernetes soolution - [Qbec](https://qbec.io)
* [ArgoCD](https://argoproj.github.io) can use Jsonnet to manage applications
* Others, like Spinnaker [sponnet](https://github.com/spinnaker/sponnet)

---

# Questions?

---

# Thanks for joining us!

jarek@ninefiveslabs.io / wojtek@ninefiveslabs.io

https://NineFivesLabs.io
