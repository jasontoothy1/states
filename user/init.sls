{% for user, details in pillar.get('user_list', {}).items() %}
{{ user }}:
  user.present:
    - fullname: {{ details['fullname'] }}
    - home: /home/{{ user }}
    - uid: {{ details['uid'] }}
    - password: {{ details['passwd'] }}
    - shell: /bin/bash
{% endfor %}

{% for user, details in pillar.get('user_list', {}).items() %}
/home/{{ user }}/.ssh:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - mode: 700
/home/{{ user }}/.ssh/authorized_keys:
  file:
    - managed
    - user: {{ user }}
    - group: {{ user }}
    - source: salt://user/userkeys/{{ user }}/{{ user }}_ssh
    - mode: 600
/home/{{ user }}/.google_authenticator:
  file:
    - managed
    - user: {{ user }}
    - group: {{ user }}
    - source: salt://user/userkeys/{{ user }}/{{ user }}_ga
    - mode: 400
{% endfor %}
/etc/gainstall.sh:
  file:
    - managed
    - user: root
    - group: root
    - source: salt://user/userkeys/gainstall.sh
    - mode: 770
/etc/pam.d/sshd:
  file:
    - managed
    - user: root
    - group: root
    - source: salt://user/userkeys/pam_min
    - mode: 644
/etc/ssh/sshd_config:
  file:
    - managed
    - user: root
    - group: root
    - source: salt://user/userkeys/sshd_config_min
    - mode: 644
sh /etc/gainstall.sh:
  cmd.run
service sshd restart:
  cmd.run
httpd:
  pkg:
    - installed
git:
  pkg:
    - installed
