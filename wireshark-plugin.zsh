# vim: sts=-1 sw=4 foldmethod=marker
#description: 

wireshark_install(){
    local ret=1
    if lsb_release -i | grep -qi ubuntu; then
    elif lsb_release -i | grep -qi fedora; then
	sudo dnf install wireshark && ret=0
    elif lsb_release -i | grep -qi centos; then
    elif lsb_release -i | grep -qi arch; then
    elif lsb_release -i | grep -qi msys2; then
    elif lsb_release -i | grep -qi manjaro; then
    fi

    if (( ret )); then
    fi
}
