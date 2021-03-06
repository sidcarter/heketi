#!/bin/sh

# Based on blog:
# https://coderwall.com/p/gy2eng/bring-vagrant-vms-up-in-parallel
vmup() {

    # Start all vms
    for id in {0..29}; do
    vm="storage${id}"
    echo "[$vm] Bringing up VM"

    vagrant up $vm --provider=libvirt --no-provision &
    done

    # Start client
    vagrant up client --provider=libvirt --no-provision &

    # Make sure all child processes have finished before exiting.
    wait
}

vmup
vagrant provision
vagrant halt
vmup
