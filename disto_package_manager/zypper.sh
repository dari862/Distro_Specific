Package_installer_(){
	my-superuser zypper install -y "$@"
}
Package_update_(){
	my-superuser zypper ref
}
full_upgrade_(){
	my-superuser zypper -y --non-interactive dup
}
Package_remove_(){
	my-superuser zypper remove -y "$@"
}
Package_list_(){
	:
}
Packages_upgrade_(){
	my-superuser zypper -y upgrade
}
Package_cleanup() {
	my-superuser zypper clean -a
	my-superuser zypper tidy
	my-superuser zypper cc -a

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
