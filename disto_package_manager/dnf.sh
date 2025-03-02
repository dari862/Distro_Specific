Package_installer_(){
	my-superuser dnf install -y "$@"
}
Package_update_(){
	my-superuser dnf update -y
}
full_upgrade_(){
	my-superuser dnf -y upgrade
}
Package_remove_(){
	my-superuser dnf remove -y "$@"
}
Package_list_(){
	:
}
Packages_upgrade_(){
	my-superuser dnf -y upgrade
}
Package_cleanup() {
	my-superuser dnf clean all
	my-superuser dnf autoremove -y
       
    if [ -d /var/tmp ]; then
        my-superuser find /var/tmp -type f -atime +5 -delete
    fi
    if [ -d /tmp ]; then
        my-superuser find /tmp -type f -atime +5 -delete
    fi
    if [ -d /var/log ]; then
        my-superuser find /var/log -type f -name "*.log" -exec truncate -s 0 {} \;
    fi
    service_manager cleanup
}
