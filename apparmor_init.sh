#!/bin/bash

PS4='[\033[93m*\033[0m] '

if [ "$EUID" -ne 0 ]; then
  echo "Need to be root to lauch this script."
  exit 1
fi

set -x

cp /bin/bash /bin/nsduser_bash
useradd -m -s /bin/nsduser_bash nsd_user
echo "setting password for new user; use something easy: "
passwd nsd_user

cat <<EOF > /etc/apparmor.d/usr.bin.nsduser_bash
# Last Modified: Mon Feb 26 15:37:04 2024
abi <abi/3.0>,

include <tunables/global>

/usr/bin/nsduser_bash {
  include <abstractions/base>
  include <abstractions/bash>
  include <abstractions/consoles>

  deny owner /home/*/super_secrets/read_only/* w,
  deny owner /home/*/super_secrets/write_only/* r,
  owner /home/ rw,
  owner /home/** rw,
  owner /root/ rw,
  owner /root/** rw,
  /home/*/super_secrets/read_only/* r,
  /home/*/super_secrets/write_only/* w,


  /etc/init.d/ r,
  /etc/nsswitch.conf r,
  /etc/passwd r,
  /home/*/super_secrets/ r,
  /home/*/super_secrets/read_only/ r,
  /home/*/super_secrets/write_only/ r,
  /usr/bin/basename mrix,
  /usr/bin/cat mrix,
  /usr/bin/dash ix,
  /usr/bin/dirname mrix,
  /usr/bin/lesspipe mrix,
  /usr/bin/mkdir mrwix,
  /usr/bin/touch mrix,
  /usr/bin/rm mrix,
  /usr/bin/groups mrix,
  /usr/bin/nsduser_bash mr,
  /usr/share/bash-completion/bash_completion r,
  owner /home/*/.bash_history rw,
  owner /home/*/.bashrc r,
}
EOF

apparmor_parser -r /etc/apparmor.d/usr.bin.nsduser_bash
