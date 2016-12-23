{%- set version = salt['pillar.get']('phantomjs:version', '2.1.1') %}
{%- set architecture = salt['pillar.get']('phantomjs:architecture', 'x86_64') %}
{%- set checksum = salt['pillar.get']('phantomjs:checksum', False) %}
{%- set release_name = "phantomjs-" + version + "-linux-" + architecture %}

phantomjs_binary:
  archive.extracted:
    - name: /opt/{{ release_name }}
    - source: https://bitbucket.org/ariya/phantomjs/downloads/{{ release_name }}.tar.bz2
    - archive_format: tar
    {%- if checksum != False %}
    - source_hash: md5={{ checksum }}
    {%- else %}
    - skip_verify: True
    {%- endif %}

phantomjs_exec:
  file.symlink:
    - name: /usr/local/bin/phantomjs
    - target: /opt/{{ release_name }}/bin/phantomjs
