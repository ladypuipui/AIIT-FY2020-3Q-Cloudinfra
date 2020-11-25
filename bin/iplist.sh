#!/bin/bash

egrep "lease|hostname|\}" /var/lib/dhcpd/dhcpd.leases | sed '1,2d'| perl -pe 's/\n/ /'| tr '}' '\n'| tr '{' ':' | grep client-hostname | sort | uniq
