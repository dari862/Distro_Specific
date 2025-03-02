if command -v yay >/dev/null 2>&1;then
	package_manger="yay"
elif command -v paru >/dev/null 2>&1;then
	package_manger="paru"
else
	package_manger="my-superuser pacman"
fi

Package_installer_(){
	${package_manger} --noconfirm -S "$@"
}
Package_update_(){
	${package_manger} -Syu --noconfirm
}
full_upgrade_(){
	${package_manger} -Syu --noconfirm --needed archlinux-keyring
	${package_manger} -Syu --noconfirm
}
Packages_upgrade_(){
	${package_manger} -y upgrade
}
Package_remove_(){
	${package_manger} -Rs "$@"
}
Package_list_(){
	:
}
Package_cleanup() {
	my-superuser "$package_manger" -Sc --noconfirm
	my-superuser "$package_manger" -Rns "$(pacman -Qtdq)" --noconfirm > /dev/null || true
            
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
